using Ssb.Modeling.Wpf.Models;
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
using System.Windows.Shapes;

namespace Ssb.Modeling.Wpf.Dialogs
{
    /// <summary>
    /// Interaction logic for SqlConnectionDialog.xaml
    /// </summary>
    public partial class SqlConnectionDialog : Window
    {
        public SqlConnectionDialog()
        {
            InitializeComponent();
        }

        public static string GetConnectionString()
        {
            var sqlDialog = new SqlConnectionDialog();
            if (sqlDialog.ShowDialog() ?? false)
            {
                var model = sqlDialog.DataContext as SqlConnectionModel;
                return model.ConnectionString;
            }

            return null;
        }
    }
}
