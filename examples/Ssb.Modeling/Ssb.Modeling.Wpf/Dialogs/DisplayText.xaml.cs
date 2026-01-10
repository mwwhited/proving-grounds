using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace Ssb.Modeling.Wpf.Dialogs
{
    /// <summary>
    /// Interaction logic for DisplayText.xaml
    /// </summary>
    public partial class DisplayText : Window
    {
        public DisplayText()
        {
            InitializeComponent();
        }

        public static bool? Show(Stream result, string title = null)
        {
            using (var reader = new StreamReader(result))
            {
                return DisplayText.Show(reader.ReadToEnd(), title);
            }
        }

        public static bool? Show(string input, string title = null)
        {
            var view = new DisplayText()
            {
                DataContext = input,
                Title = title ?? "Show"
            };
            return view.ShowDialog();
        }
    }
}
