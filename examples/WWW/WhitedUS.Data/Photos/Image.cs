using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.Photos
{
    public partial class Image
    {
        public class ImageCompare : IEqualityComparer<Image>
        {

            #region IEqualityComparer<Image> Members

            public bool Equals(Image x, Image y)
            {
                return x.ImageID == y.ImageID;
            }

            public int GetHashCode(Image obj)
            {
                return obj.GetHashCode();
            }

            #endregion
        }

        public override bool Equals(object obj)
        {
            var tag = obj as Image;
            if (tag != null)
                return this.ImageID == tag.ImageID;         
            return base.Equals(obj);
        }

        public override int GetHashCode()
        {
            return this.ImageID.GetHashCode();
        }
    }
}
