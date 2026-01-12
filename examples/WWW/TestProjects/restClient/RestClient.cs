using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.ServiceModel.Description;
using System.Text;
using System.Xml.Serialization;
using restClient.Linq;

namespace restClient
{
    public class RestClient : ClientBase<IRestClient>
    {
        public RestClient(string uri)
            : base(new WebHttpBinding()
            {
            }, new EndpointAddress(uri))
        {
            this.Endpoint.Behaviors.Add(new WebHttpBehavior());
        }

        #region IMediaRestClient Members

        public RestServiceSet GetServices()
        {
            return this.Channel.GetServices()
                               .DeserializeTo<RestServiceSet>();
        }

        #endregion

        public void CreateClientProxy(string @namespace,
                                             string @class)
        {
            using (var writer = new StreamWriter(@class + ".cs"))
                CreateClientProxy(@namespace, @class, writer);
        }
        public void CreateClientProxy(string @namespace,
                                      string @class,
                                      TextWriter writer)
        {
            var res = this.GetServices();

            //writer.WriteLine("using System;");
            writer.WriteLine("using System.ServiceModel;");
            writer.WriteLine("using System.ServiceModel.Web;");
            writer.WriteLine("using System.ServiceModel.Description;");
            writer.WriteLine();

            writer.WriteLine("namespace " + @namespace);
            writer.WriteLine("{");

            BuildInterface(res, @class, writer);
            BuildProxyClass(res, @class, writer);
            BuildClass(res, @class, writer);

            writer.WriteLine("}");
        }

        private void BuildClass(RestServiceSet res, string @class, TextWriter writer)
        {
            writer.WriteLine("\tpublic partial class " + @class);
            //writer.WriteLine("\t\t: IDisposable");
            writer.WriteLine("\t{");

            writer.WriteLine("\t\tpublic " + @class + "(string uri)");
            writer.WriteLine("\t\t{");
            writer.WriteLine("\t\t\tthis.Proxy = new {0}Proxy(uri);", @class);
            writer.WriteLine("\t\t}");

            writer.WriteLine("\t\tprivate {0}Proxy Proxy {{ get; set; }}", @class);

            foreach (var service in res.Services)
            {
                if (!string.IsNullOrEmpty(service.Description))
                {
                    writer.WriteLine("\t\t/// <summary>");
                    writer.WriteLine("\t\t/// {0}", service.Description);
                    writer.WriteLine("\t\t/// </summary>");
                }

                writer.Write("\t\t");
                writer.Write("public ");
                writer.Write(service.ReturnTypeName);
                writer.Write(" ");
                writer.Write(service.Name);
                writer.Write("(");

                foreach (var parameter in service.Parameters.Parameters)
                {
                    if (parameter.Position > 0)
                        writer.Write(", ");
                    writer.Write(parameter.TypeName);
                    writer.Write(" ");
                    writer.Write(parameter.Name);
                }

                writer.Write(")");
                writer.WriteLine();

                writer.WriteLine("\t\t{");
                writer.Write("\t\t\treturn this.Proxy.{0}(",
                    service.Name);

                foreach (var parameter in service.Parameters.Parameters)
                {
                    if (parameter.Position > 0)
                        writer.Write(", ");
                    writer.Write(parameter.Name);
                }

                writer.WriteLine(");");
                writer.WriteLine("\t\t}");
            }

            writer.WriteLine("\t}");
        }
        private void BuildProxyClass(RestServiceSet res, string @class, TextWriter writer)
        {
            writer.WriteLine("\tpublic partial class " + @class + "Proxy");
            writer.WriteLine("\t\t: ClientBase<I{0}Client>, I{0}Client", @class);
            writer.WriteLine("\t{");

            writer.WriteLine("\t\tpublic " + @class + "Proxy(string uri)");
            writer.WriteLine("\t\t\t: base(new WebHttpBinding(), new EndpointAddress(uri))");
            writer.WriteLine("\t\t{");
            writer.WriteLine("\t\t\tthis.Endpoint.Behaviors.Add(new WebHttpBehavior());");
            writer.WriteLine("\t\t}");

            foreach (var service in res.Services)
            {
                if (!string.IsNullOrEmpty(service.Description))
                {
                    writer.WriteLine("\t\t/// <summary>");
                    writer.WriteLine("\t\t/// {0}", service.Description);
                    writer.WriteLine("\t\t/// </summary>");
                }

                writer.Write("\t\t");
                writer.Write("public ");
                writer.Write(service.ReturnTypeName);
                writer.Write(" ");
                writer.Write(service.Name);
                writer.Write("(");

                foreach (var parameter in service.Parameters.Parameters)
                {
                    if (parameter.Position > 0)
                        writer.Write(", ");
                    writer.Write(parameter.TypeName);
                    writer.Write(" ");
                    writer.Write(parameter.Name);
                }

                writer.Write(")");
                writer.WriteLine();

                writer.WriteLine("\t\t{");
                writer.Write("\t\t\treturn this.Channel.{0}(",
                    service.Name);

                foreach (var parameter in service.Parameters.Parameters)
                {
                    if (parameter.Position > 0)
                        writer.Write(", ");
                    writer.Write(parameter.Name);
                }

                writer.WriteLine(");");
                writer.WriteLine("\t\t}");
            }

            writer.WriteLine("\t}");
        }
        private void BuildInterface(RestServiceSet res, string @class, TextWriter writer)
        {
            writer.WriteLine("\t[ServiceContract]");
            writer.WriteLine("\tpublic interface I" + @class + "Client");
            writer.WriteLine("\t{");

            foreach (var service in res.Services)
            {
                writer.WriteLine("\t\t[OperationContract]");

                writer.WriteLine("\t\t[WebInvoke(");
                writer.WriteLine("\t\t\tBodyStyle = WebMessageBodyStyle.{0},", service.Details.BodyStyle);
                writer.WriteLine("\t\t\tResponseFormat = WebMessageFormat.{0},", service.Details.ResponseFormat);
                writer.WriteLine("\t\t\tRequestFormat = WebMessageFormat.{0},", service.Details.RequestFormat);
                writer.WriteLine("\t\t\tUriTemplate = \"{0}\",", service.Details.UriTemplate);
                writer.WriteLine("\t\t\tMethod = \"{0}\"", service.Details.Method);
                writer.WriteLine("\t\t\t)]");

                writer.Write("\t\t");
                writer.Write(service.ReturnTypeName);
                writer.Write(" ");
                writer.Write(service.Name);
                writer.Write("(");

                foreach (var parameter in service.Parameters.Parameters)
                {
                    if (parameter.Position > 0)
                        writer.Write(", ");
                    writer.Write(parameter.TypeName);
                    writer.Write(" ");
                    writer.Write(parameter.Name);
                }

                writer.Write(");");
                writer.WriteLine();
            }

            writer.WriteLine("\t}");
        }
    }
}
