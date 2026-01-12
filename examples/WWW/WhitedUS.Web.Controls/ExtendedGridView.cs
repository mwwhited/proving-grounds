using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace WhitedUS.Web.Controls
{
    public class ExtendedGridView : GridView
    {
        public string SelectedString
        {
            get { return (SelectedValue ?? string.Empty).ToString(); }
        }
        public int SelectedInt32
        {
            get { return (int)(SelectedValue ?? -1); }
        }
    }
}
