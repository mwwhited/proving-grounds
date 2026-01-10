using Fluent;
using Microsoft.Win32;
using Ssb.Modeling.Models;
using Ssb.Modeling.Models.Providers;
using Ssb.Modeling.Wpf.DesignerData;
using Ssb.Modeling.Wpf.Dialogs;
using Ssb.Modeling.Wpf.Providers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml.Linq;

namespace Ssb.Modeling.Wpf
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : RibbonWindow
    {
        private IResourceLoader ResourceLoader { get; set; }
        private IXslTransform Transformer { get; set; }

        public MainWindow()
        {
            InitializeComponent();

            this.ResourceLoader = new ResourceLoader();
            this.Transformer = new XslTransformer();

            this.DataContext = new ApplicationViewModel(this.LoadXml, this.SaveXml, this.New,
                                                        this.PresentSqlCreate, this.ImportSql,
                                                        this.Transformer, this.ResourceLoader);
        }

        private Task<XElement> ImportSql()
        {
            //TODO: Add Dirty Check
            var connectionString = SqlConnectionDialog.GetConnectionString();

            if (string.IsNullOrWhiteSpace(connectionString))
                return null;

            return SqlServiceBrokerProvider.GetXml(connectionString, this.ResourceLoader);
            //TODO: Clear dirty check
        }

        private void PresentSqlCreate(Stream result)
        {
            //TODO: Add Validation Check
            this.Dispatcher.Invoke(() => DisplayText.Show(result, title: "Create SQL"));
        }

        private Task<bool> New()
        {
            //TODO: Add Dirty Check
            return Task.Run(() => true);
            //TODO: Clear dirty check
        }

        private async Task SaveXml(XElement xml)
        {
            await SaveProject.SaveXml(xml);
            //TODO: Clear dirty check
        }

        private async Task<XElement> LoadXml()
        {
            //TODO: Add Dirty Check
            return await LoadProject.LoadXml();
            //TODO: Clear dirty check
        }

    }
}
