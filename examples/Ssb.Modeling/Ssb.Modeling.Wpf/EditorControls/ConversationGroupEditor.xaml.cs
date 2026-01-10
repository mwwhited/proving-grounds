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
    /// Interaction logic for ConversationGroupEditor.xaml
    /// </summary>
    public partial class ConversationGroupEditor : UserControl
    {
        public ConversationGroupEditor()
        {
            InitializeComponent();
        }

        public static readonly DependencyProperty ConversationsSourceProperty =
            DependencyProperty.Register("ConversationsSource", typeof(IEnumerable<ConversationModel>), typeof(ConversationGroupEditor));
        public IEnumerable<ConversationModel> ConversationsSource
        {
            get { return this.GetValue(ConversationsSourceProperty) as IEnumerable<ConversationModel>; }
            set { this.SetValue(ConversationsSourceProperty, value); }
        }
    }
}
