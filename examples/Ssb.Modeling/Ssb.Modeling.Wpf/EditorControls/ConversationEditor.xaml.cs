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
    /// Interaction logic for ConversationEditor.xaml
    /// </summary>
    public partial class ConversationEditor : UserControl
    {
        public ConversationEditor()
        {
            InitializeComponent();
        }

        public static readonly DependencyProperty ServicesSourceProperty =
            DependencyProperty.Register("ServicesSource", typeof(IEnumerable<ServiceModel>), typeof(ConversationEditor));
        public IEnumerable<ServiceModel> ServicesSource
        {
            get { return this.GetValue(ServicesSourceProperty) as IEnumerable<ServiceModel>; }
            set { this.SetValue(ServicesSourceProperty, value); }
        }
    }
}
