using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using System.Xml.Linq;
using SafeAuto.BusinessModelInterface.AutoInsurance;
using SafeAuto.Framework;

namespace SafeAuto.ConsoleApplication.DialogueProviderTestSuite
{
	public class ReflectivePolicyTest
	{
		public IPolicyReportData UpgradePolicyReportData(string filename)
		{
			return UpgradePolicyReportData(XElement.Load(filename));
		}
		public IPolicyReportData UpgradePolicyReportData(XElement policyReportData10Xml)
		{
			var policyReportData = ObjectFactory.Create<IPolicyReportData>();
			policyReportData.PolicyInfo = ReflectiveFill<IPolicy>(policyReportData10Xml.Element("Policy"));
			policyReportData.PolicyDetail = ReflectiveFill<IPolicyDetail>(policyReportData10Xml.Element("PolicyDetail"));
			policyReportData.PolicyCustomer = ReflectiveFill<ICustomer>(policyReportData10Xml.Element("Customer"));
			policyReportData.Drivers = ReflectiveFill<IDriverList>(policyReportData10Xml.Element("Drivers"));
			policyReportData.Vehicles = ReflectiveFill<IVehicleList>(policyReportData10Xml.Element("Vehicles"));

			return policyReportData;
		}

		private object ReflectiveFill(Type type, XElement xmlData)
		{
			var method = typeof(ReflectivePolicyTest).GetMethod("ReflectiveFill", BindingFlags.Instance | BindingFlags.NonPublic, null, new[] { typeof(XElement) }, null);
			var genericMethod = method.MakeGenericMethod(type);
			var obj = genericMethod.Invoke(this, new[] { xmlData });
			return obj;
		}
		private object ParseFill(Type type, XElement xmlData)
		{
			if (type == typeof(string))
				return xmlData.Value;

			var argTypes = new[] {
				typeof(string),
				type.MakeByRefType(),
			};

			var tryParse = type.GetMethod("TryParse", BindingFlags.Public | BindingFlags.Static, null, argTypes, null);
			if (tryParse != null)
			{
				var methodArgs = new object[2];
				methodArgs[0] = xmlData.Value;
				var ret = tryParse.Invoke(null, methodArgs);
				var isTrue = (bool)ret;
				if (isTrue)
					return methodArgs[1];
			}

			throw new NotSupportedException();
		}
		private T ReflectiveFill<T>(XElement xmlData)
			where T : class
		{
			var obj = ObjectFactory.Create<T>();
			var type = obj.GetType();

			var policyElements = xmlData.Elements();
			var properties = type.GetProperties();

			var propMatches = from element in policyElements
							  join property in properties on element.Name.LocalName.ToUpperInvariant() equals property.Name.ToUpperInvariant()
							  where !string.IsNullOrEmpty(element.Value)
							  select new
							  {
								  element,
								  property
							  };

			foreach (var match in propMatches)
			{
				object value = null;
				var innerType = match.property.PropertyType;
				if (innerType.IsInterface)
					value = ReflectiveFill(innerType, match.element);
				else if (IsSimpleType(innerType))
					value = ParseFill(innerType, match.element);


				if (value != null)
					match.property.SetValue(obj, value, null);
			}

			var enumerableProperties = from property in properties
									   where property.PropertyType != typeof(string)
									   where typeof(IEnumerable).IsAssignableFrom(property.PropertyType)
									   select property;
			foreach (var property in enumerableProperties)
			{
				if (property.PropertyType.IsArray)
				{
					var childType = property.PropertyType.GetElementType();
					var children = xmlData.Elements().Select(x => ReflectiveFill(childType, x)).ToArray();
					var childArray = Array.CreateInstance(childType, children.Length);
					Array.Copy(children, childArray, childArray.Length);

					property.SetValue(obj, childArray, null);
				}
			}

			return obj;
		}

		//private object BuildArray(Type type, XElement xmlData)
		//{
		//}

		private static readonly Type[] WriteTypes = new[] {
			typeof(string), typeof(DateTime), typeof(Enum), typeof(decimal), typeof(Guid),
		};
		private static bool IsSimpleType(Type type)
		{
			return type.IsPrimitive || WriteTypes.Contains(type);
		}

	}
}
