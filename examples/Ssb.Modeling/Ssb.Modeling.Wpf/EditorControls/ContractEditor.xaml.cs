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
    /// Interaction logic for ContractEditor.xaml
    /// </summary>
    public partial class ContractEditor : UserControl
    {
        public ContractEditor()
        {
            InitializeComponent();
        }

        public static readonly DependencyProperty MessageTypesSourceProperty =
            DependencyProperty.Register("MessageTypesSource", typeof(IEnumerable<MessageTypeModel>), typeof(ContractEditor));
        public IEnumerable<MessageTypeModel> MessageTypesSource
        {
            get { return this.GetValue(MessageTypesSourceProperty) as IEnumerable<MessageTypeModel>; }
            set { this.SetValue(MessageTypesSourceProperty, value); }
        }
    }
}
