using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Configuration;
using System.Reflection;
using WhitedUS.Libs.Converters;
using System.ComponentModel;
using System.Web.UI;
using System.Web.Caching;
using System.Threading;
using WhitedUS.Common;

namespace WhitedUS.Web.Controls
{
    [DefaultProperty("ImageContent")]
    public class ImageView : Image //,INamingContainer
    {
        private ImageData _imageData = new ImageData();

        protected override void OnInit(EventArgs e)
        {
            if (Page != null)
            {
                Page.RegisterRequiresControlState(this);
                base.OnInit(e);
            }
        }

        protected override object SaveControlState()
        {
            return (object)_imageData;
        }

        protected override void LoadControlState(object savedState)
        {
            if (savedState != null && savedState is ImageData)
                _imageData = (ImageData)savedState;
            else
                _imageData = new ImageData();
        }

        [DefaultValue("image/jpeg")]
        public string MimeType
        {
            get
            {
                if (string.IsNullOrEmpty(_imageData.MimeType))
                    return "image/jpeg";
                else
                    return _imageData.MimeType;
            }
            set { _imageData.MimeType = value; }
        }

        [DefaultValue((byte[])null)]
        public byte[] ImageContent
        {
            get 
            {
                if (_imageData.Buffer != null)
                    return _imageData.Buffer;
                return null; 
            }
            set
            {
                _imageData.Buffer = value;
                if (_imageData.Buffer != null)
                    ImageStore.AddImageView(_imageData);
            }
        }

        [DefaultValue((string)null)]
        public string Key
        {
            get { return _imageData.Key; }
            //set { _imageData.Key = value; }
        }

        [DefaultValue((string)null)]
        public string ImageContentBase64
        {
            get { return ImageContent.ToBase64(); }
            set { ImageContent = value.FromBase64(); }
        }

        [DefaultValue((string)null)]
        public override string ImageUrl
        {
            get { return string.Format(ImageStore.ImageUrl, _imageData.Key); }
            set { throw new NotSupportedException(
                "This is a special image handler " +
                "please do not use this property"); }
        }
    }
}
