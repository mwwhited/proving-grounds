using Ssb.Modeling.Models;
using System;
using System.Collections.Generic;
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

namespace Ssb.Modeling.Wpf.EditorControls
{
    /// <summary>
    /// Interaction logic for ServiceEditor.xaml
    /// </summary>
    public partial class ServiceEditor : UserControl
    {
        public ServiceEditor()
        {
            InitializeComponent();
        }

        public static readonly DependencyProperty QueuesSourceProperty =
            DependencyProperty.Register("QueuesSource", typeof(IEnumerable<QueueModel>), typeof(ServiceEditor));
        public IEnumerable<QueueModel> QueuesSource
        {
            get { return this.GetValue(QueuesSourceProperty) as IEnumerable<QueueModel>; }
            set { this.SetValue(QueuesSourceProperty, value); }
        }

        public static readonly DependencyProperty ContractsSourceProperty =
            DependencyProperty.Register("ContractsSource", typeof(IEnumerable<ContractModel>), typeof(ServiceEditor));
        public IEnumerable<ContractModel> ContractsSource
        {
            get { return this.GetValue(ContractsSourceProperty) as IEnumerable<ContractModel>; }
            set { this.SetValue(ContractsSourceProperty, value); }
        }
    }
}
