using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Xml;
using System.Runtime.Serialization;
using System.IO;
using System.Xml.Serialization;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Reflection;
using System.Collections;

namespace WhitedUS.Common.Converters
{
    public static class ObjectConverters
    {
        public static void WriteXml(this object input, Stream stream)
        {
            input.WriteXml(stream, string.Empty);
        }
        public static void WriteXml(this object input,
                                    Stream stream,
                                    string defaultNode)
        {
            if (input == null)
                return;

            if (!stream.CanWrite)
                throw new InvalidOperationException("Can not write to stream");

            if (input is XmlNode || input is XNode)
            {
                var buffer = Encoding.UTF8.GetBytes(input.ToXml());
                stream.Write(buffer, 0, buffer.Length);
            }
            else
            {
                if (input.HasDataContract())
                    input.SerializeDataContact(stream);
                else if (input.IsExtendedPrimitive() ||
                         input is IXmlSerializable)
                    input.SerializeXml(stream);
                else
                {
                    var ret = input.ToXml(defaultNode, null);
                    if (ret != null)
                    {
                        var buffer = ret.ToString().ToByteArray();
                        stream.Write(buffer, 0, buffer.Length);
                    }
                }
            }
        }

        //public static bool IsAnonymousType(this Type input)
        //{
        //    if (input == null)
        //        return false;

        //    if (!input.GetCustomAttributes(typeof(CompilerGeneratedAttribute), true).Any())
        //        return false;

        //    if (!input.IsSealed)
        //        return false;

        //    if (input.Name.Contains(">f__AnonymousType")
        //        || input.Name.StartsWith("VB$AnonymousType_"))
        //        return true;

        //    return false;
        //}

        //public static bool IsAnonymousType(this object input)
        //{
        //    if (input == null)
        //        return false;

        //    var type = input.GetType();
        //    return type.IsAnonymousType();
        //}

        public static string ToXml(this object input)
        {
            if (input == null)
                return null;

            if (input is XmlNode)
                return ((XmlNode)input).OuterXml;
            else if (input is XNode)
                return input.ToString();
            //else if (input.IsAnonymousType())
            //{
            //    var ret = input.ToXNode();
            //    if (ret == null)
            //        return null;
            //    return ret.ToString();
            //}
            else
            {
                if (input.HasDataContract())
                {
                    using (var ms = new MemoryStream())
                    {
                        input.SerializeDataContact(ms);
                        return ms.Rewind().ToEncodedString();
                    }
                }
                else if (input.CanSerializeXml()) //input.IsExtendedPrimitive() || input is IXmlSerializable)
                {
                    using (var ms = new MemoryStream())
                    {
                        input.SerializeXml(ms);
                        return ms.Rewind().ToEncodedString();
                    }
                }
                else
                {
                    var ret = input.ToXml(null, null);
                    if (ret == null)
                        return null;
                    else
                        return ret.ToString();
                }
            }
        }

        public static bool HasDataContract(this object input)
        {
            if (input != null)
                return input.GetType()
                    .GetCustomAttributes(typeof(DataContractAttribute), true)
                    .Length > 0;
            return false;
        }

        public static void SerializeDataContact(this object input,
                                                Stream stream)
        {
            if (input == null)
                return;

            if (!stream.CanWrite)
                throw new InvalidOperationException("Can not write to stream");

            new DataContractSerializer(input.GetType())
                .WriteObject(stream, input);
        }

        public static void SerializeXml(this object input, Stream stream)
        {
            if (input == null)
                return;

            if (!stream.CanWrite)
                throw new InvalidOperationException("Can not write to stream");

            new XmlSerializer(input.GetType()).Serialize(stream, input);
        }

        public static XNode ToXNode(this object input)
        {
            if (input == null)
                return null;

            if (input is XNode)
                return (XNode)input;

            //var inputType = input.GetType();
            //if (input.IsAnonymousType())
            //{
            //    var fields = inputType.GetProperties();
            //    var values = from fi in fields
            //                 let indexer = fi.GetIndexParameters()
            //                 where indexer != null || indexer.Length > 0
            //                 let val = fi.GetValue(input, null).ToXNode()
            //                 where val != null
            //                 select new XElement(fi.Name, val);
            //    return new XElement("object", values);
            //}

            var ret = input.ToXml();
            if (string.IsNullOrEmpty(ret))
                return null;
            return XElement.Parse(ret);
        }

        public static bool IsExtendedPrimitive(this object input)
        {
            if (input == null)
                return false;

            var inputType = input.GetType();
            return
                inputType.IsPrimitive ||
                input is string ||
                input is DateTime
                ;
        }

        public static bool CanSerializeXml(this object input)
        {
            if (input == null)
                return false;

            return input is XNode ||
                input is XmlNode ||
                input is IXmlSerializable ||
                input.IsExtendedPrimitive() ||
                input.HasDataContract() ||
                input.GetType().GetConstructor(new Type[0]) != null
                ;
        }

        public static XNode ToXml(this object input, string nodeName)
        {
            return input.ToXml(nodeName, null);
        }

        public static XNode ToXml(this object input,
                                  string nodeName,
                                  Collection<object> context)
        {
            if (input == null)
                return null;

            var inputType = input.GetType();
            string xmlName = null;
            if (string.IsNullOrEmpty(nodeName))
                xmlName = inputType.Name;
            else
                xmlName = nodeName;

            if (input.CanSerializeXml())
                return new XElement(XmlConvert.EncodeName(xmlName),
                    input.ToXNode());

            if (context == null)
            {
                return ToXml(input, nodeName, new Collection<object>());
            }
            else
            {
                var props = inputType.GetProperties()
                                     .Where(pi => pi.CanRead &&
                                                  pi.GetGetMethod()
                                                    .GetParameters()
                                                    .Length == 0);

                var hashCode = input.GetHashCode();

                if (context.Contains(input))
                    return new XElement(XmlConvert.EncodeName(xmlName),
                        new XElement("HashCode_Pointer", hashCode));
                else
                {
                    context.Add(input);
                    return new XElement(XmlConvert.EncodeName(xmlName),
                        new XAttribute("HashCode_ID", hashCode),
                        from pi in props
                        let v = pi.GetValue(input, null)
                        where v != null
                        select v.ToXml(pi.Name, context)
                        );
                }
            }
        }
    }
}
