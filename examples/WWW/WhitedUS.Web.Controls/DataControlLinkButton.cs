using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Drawing;

namespace WhitedUS.Web.Controls
{
    [SupportsEventValidation]
    internal class DataControlLinkButton : LinkButton
    {
        // Fields
        private string _callbackArgument;
        private IPostBackContainer _container;
        private bool _enableCallback;

        // Methods
        internal DataControlLinkButton(IPostBackContainer container)
        {
            this._container = container;
        }

        internal void EnableCallback(string argument)
        {
            this._enableCallback = true;
            this._callbackArgument = argument;
        }

        protected override PostBackOptions GetPostBackOptions()
        {
            if (this._container != null)
            {
                return this._container.GetPostBackOptions(this);
            }
            return base.GetPostBackOptions();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            this.SetCallbackProperties();
            base.Render(writer);
        }

        private void SetCallbackProperties()
        {
            if (this._enableCallback)
            {
                var container = this._container as ICallbackContainer;
                if (container != null)
                {
                    string callbackScript = container.GetCallbackScript(
                                                this, 
                                                this._callbackArgument);
                    if (!string.IsNullOrEmpty(callbackScript))
                    {
                        this.OnClientClick = callbackScript;
                    }
                }
            }
        }

        // Properties
        public override bool CausesValidation
        {
            get
            {
                if (this._container != null)
                    return false;
                return base.CausesValidation;
            }
            set
            {
                if (this._container != null)
                    throw new NotSupportedException(
                        "CannotSetValidationOnDataControlButtons");
                base.CausesValidation = value;
            }
        }
    }

 

}
