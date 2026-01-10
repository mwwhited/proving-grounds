using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.Tools.WsdlClientBuilder
{
    class Program
    {
        static void Main(string[] args)
        {
            var wsdlFile = @"..\..\..\OobDev.TotalConnect2.Client\rs_alarmnet_com_TC21API_TC2.wsdl";
            var modelFolder = Path.GetFullPath(Path.Combine(Path.GetDirectoryName(wsdlFile), "Models"));
            if (!Directory.Exists(modelFolder))
                Directory.CreateDirectory(modelFolder);

            var xml = XElement.Load(wsdlFile);
            XNamespace tm = "http://microsoft.com/wsdl/mime/textMatching/";
            XNamespace soapenc = "http://schemas.xmlsoap.org/soap/encoding/";
            XNamespace mime = "http://schemas.xmlsoap.org/wsdl/mime/";
            XNamespace soap = "http://schemas.xmlsoap.org/wsdl/soap/";
            XNamespace soap12 = "http://schemas.xmlsoap.org/wsdl/soap12/";
            XNamespace http = "http://schemas.xmlsoap.org/wsdl/http/";
            XNamespace wsdl = "http://schemas.xmlsoap.org/wsdl/";
            XNamespace tns = "https://services.alarmnet.com/TC2/";
            XNamespace s1 = "https://services.alarmnet.com/TC2/AbstractTypes";
            XNamespace s = "http://www.w3.org/2001/XMLSchema";

            var services = (from service in xml.Elements(wsdl + "service")
                            from port in service.Elements(wsdl + "port")
                            from address in port.Elements(http + "address")
                            let binding = (string)port.Attribute("binding")
                            let bindingPrefix = binding?.Split(':').FirstOrDefault()
                            let bindingNamespace = xml.GetNamespaceOfPrefix(bindingPrefix)
                            let portName = (string)port.Attribute("name")
                            select new
                            {
                                //ServiceName = (string)service.Attribute("name"),
                                // PortName = portName,
                                Location = (string)address.Attribute("location"),
                                // BindingPrefix = bindingPrefix,
                                // BindingNamespace = bindingNamespace,
                                Binding = (from bindingX in xml.Elements(wsdl + "binding")
                                           let type = (string)bindingX.Attribute("type")
                                           where binding == type
                                           from httpBinding in bindingX.Elements(http + "binding")
                                           select new
                                           {
                                               Type = type,
                                               Verb = (string)httpBinding.Attribute("verb"),
                                               Operations = (from operation in bindingX.Elements(wsdl + "operation")
                                                             let httpOpertation = operation.Element(http + "operation")
                                                             let input = operation.Element(wsdl + "input").Elements().FirstOrDefault()
                                                             let output = operation.Element(wsdl + "output").Elements().FirstOrDefault()
                                                             select new
                                                             {
                                                                 Location = (string)httpOpertation.Attribute("location"),
                                                                 Input = input.Name.LocalName,
                                                                 Output = output.Name.LocalName,
                                                             }).ToArray(),
                                           }).FirstOrDefault(),
                                PortType = (from portType in xml.Elements(wsdl + "portType")
                                            let name = (string)portType.Attribute("name")
                                            where name == portName
                                            select new
                                            {
                                                Operations = (from operation in portType.Elements(wsdl + "operation")
                                                              let documentation = operation.Element(wsdl + "documentation")
                                                              let input = operation.Element(wsdl + "input")
                                                              let output = operation.Element(wsdl + "output")
                                                              select new
                                                              {
                                                                  OperationName = (string)operation.Attribute("name"),
                                                                  Documentation = (string)documentation,
                                                                  InputType = (string)input.Attribute("message"),
                                                                  OutputType = (string)output.Attribute("message"),
                                                                  operation,
                                                              }).ToArray(),
                                            }).FirstOrDefault(),
                                Messages = (from message in xml.Elements(wsdl + "message")
                                            select new
                                            {
                                                MessageName = (string)message.Attribute("name"),
                                                Parameters = (from part in message.Elements(wsdl + "part")
                                                              let element = (string)part.Attribute("element")
                                                              let elementPrefix = binding?.Split(':').FirstOrDefault()
                                                              let elementType = binding?.Split(':').Skip(1).FirstOrDefault()
                                                              select new
                                                              {
                                                                  ParameterName = (string)part.Attribute("name"),
                                                                  ElementPrefix = elementPrefix,
                                                                  ElementNamespace = xml.GetNamespaceOfPrefix(bindingPrefix),
                                                                  ElementType = elementType,
                                                              }).ToArray(),
                                            }).ToArray(),
                                Types = (from types in xml.Elements(wsdl + "types")
                                         from schema in types.Elements(s + "schema")
                                         let targetNamespace = (string)schema.Attribute("targetNamespace")
                                         where targetNamespace == bindingNamespace
                                         from element in schema.Elements(s + "element")
                                         let name = (string)element.Attribute("name")
                                         let elements = element.Descendants(s + "element")
                                         let attributes = element.Descendants(s + "attribute")
                                         select new
                                         {
                                             Name = name,
                                             Elements = (from e in elements
                                                         select new
                                                         {
                                                             Name = (string)e.Attribute("name"),
                                                             Type = (string)e.Attribute("type"),
                                                             Min = (int?)e.Attribute("minOccurs"),
                                                             Max = (int?)e.Attribute("maxOccurs"),
                                                         }).ToArray(),
                                             Attributes = (from e in attributes
                                                           select new
                                                           {
                                                               Name = (string)e.Attribute("name"),
                                                               Type = (string)e.Attribute("type"),
                                                               Use = (string)e.Attribute("use"),
                                                               Min = (int?)e.Attribute("minOccurs"),
                                                               Max = (int?)e.Attribute("maxOccurs"),
                                                           }).ToArray(),
                                         }).ToArray(),
                            }).ToArray();

            var result = new XElement("Services",
                from service in services.Skip(1).Take(1)
                select new XElement("Service",
                        new XAttribute("Location", service.Location),
                        //from message in service.Messages
                        //select new XElement("Message",
                        //    new XAttribute("Type", message.MessageName)
                        ////from parm in message.Parameters
                        ////select new XElement("Parameter",
                        ////    new XAttribute("Name", parm.ParameterName)
                        ////    //new XAttribute("Type", parm.ElementType)
                        ////)
                        //),
                        new XElement("Types",
                            from type in service.Types
                            select new XElement("Type",
                                new XAttribute("Name", type.Name),
                                from element in type.Elements
                                select new XElement("Element",
                                    new XAttribute("Name", element.Name ?? ""),
                                    new XAttribute("Type", element.Type ?? ""),
                                    new XAttribute("Min", element.Min ?? -1),
                                    new XAttribute("Max", element.Max ?? -1)
                                ),
                                from attribute in type.Attributes
                                select new XElement("Attribute",
                                    new XAttribute("Name", attribute.Name ?? ""),
                                    new XAttribute("Type", attribute.Type ?? ""),
                                    new XAttribute("Min", attribute.Min ?? -1),
                                    new XAttribute("Max", attribute.Max ?? -1),
                                    new XAttribute("Use", attribute.Use ?? "")
                                )
                            )
                        ),
                        new XElement("PortType",
                            from operation in service.PortType.Operations
                            select new XElement("Operation",
                                new XAttribute("Documentation", operation.Documentation ?? ""),
                                new XAttribute("InputType", operation.InputType ?? ""),
                                new XAttribute("OutputType", operation.OutputType ?? ""),
                                new XAttribute("OperationName", operation.OperationName ?? "")
                            )
                        ),
                        new XElement("Binding",
                            new XAttribute("Type", service.Binding.Type),
                            new XAttribute("Verb", service.Binding.Verb),
                            from operation in service.Binding.Operations
                            select new XElement("Operations",
                                new XAttribute("Location", operation.Location),
                                new XAttribute("Input", operation.Input),
                                new XAttribute("Output", operation.Output)
                                )
                            )
                        )
                );

            result.Save("ClientXml.xml");
        }
    }
}
