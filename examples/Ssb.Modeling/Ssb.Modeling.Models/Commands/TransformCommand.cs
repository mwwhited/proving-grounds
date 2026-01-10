using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.Resources;
using Ssb.Modeling.Models.Providers;

namespace Ssb.Modeling.Models.Commands
{
    public class TransformCommand : CommandBase
    {
        public TransformCommand(
            IXslTransform transformer,
            IResourceLoader resourceLoader,
            string stylesheetResourceName,
            Func<object, Task<XElement>> getSource,
            Action<Stream> onResult)
        {
            this.Transformer = transformer;
            this.ResourceLoader = resourceLoader;
            this.StylesheetResourceName = stylesheetResourceName;
            this.GetSource = getSource;
            this.OnResult = onResult;
        }

        protected async override void OnExecute(object parameter)
        {
            var stylesheet = await this.ResourceLoader.GetResource(this.StylesheetResourceName)
                                                      .ConfigureAwait(false);
            var sourceXml = await this.GetSource(parameter)
                                      .ConfigureAwait(false);
            using (var source = new MemoryStream())
            {
                sourceXml.Save(source);
                source.Position = 0;
                var result = await this.Transformer.Transform(stylesheet, source)
                                                   .ConfigureAwait(false);
                result.Position = 0;
                this.OnResult(result);
            }           
        }

        private IXslTransform Transformer { get; set; }
        private IResourceLoader ResourceLoader { get; set; }
        private string StylesheetResourceName { get; set; }
        private Func<object, Task<XElement>> GetSource { get; set; }
        private Action<Stream> OnResult { get; set; }
    }
}
