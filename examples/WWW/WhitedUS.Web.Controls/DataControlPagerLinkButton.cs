using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace WhitedUS.Web.Controls
{
    [SupportsEventValidation]
    internal class DataControlPagerLinkButton : DataControlLinkButton
    {
        // Methods
        internal DataControlPagerLinkButton(IPostBackContainer container)
            : base(container)
        {
        }

        // Properties
        public override bool CausesValidation
        {
            get { return false; }
            set { throw new NotSupportedException(
                "CannotSetValidationOnPagerButtons"); }
        }
    }


}
