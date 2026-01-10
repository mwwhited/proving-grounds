using Ssb.Modeling.Models.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;
using System.Xml;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class XmlSchemaModel : ViewModelBase
    {
        public XmlSchemaModel()
        {
            this.ReformatXml = new DoActionCommand(this.DoReformatXml);
        }

        public ICommand ReformatXml { get; private set; }
        private void DoReformatXml(object obj)
        {
            try
            {
                var xml = XElement.Parse(this.XmlSchema);
                this.XmlSchema = xml.ToString();
            }
            catch
            {
            }
        }

        private string _xmlSchema;
        public string XmlSchema // Database Schema
        {
            get { return this._xmlSchema; }
            set
            {
                this._xmlSchema = value;
                this.TrySetTargetNamespace(this._xmlSchema);
                this.OnPropertyChanged("XmlSchema");
            }
        }

        private string _targetNamespace = "Unknown";
        public string TargetNamespace
        {
            get { return this._targetNamespace; }
            set
            {
                this._targetNamespace = value;
                this.OnPropertyChanged("TargetNamespace");
            }
        }

        private void TrySetTargetNamespace(string xmlString)
        {
            try
            {
                var xml = XElement.Parse(xmlString);
                this.TargetNamespace = (string)xml.Attribute("targetNamespace");
            }
            catch
            {
            }
        }
    }
}
