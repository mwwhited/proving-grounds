using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.Photos
{
    public partial class Tag
    {
        public class TagCompare : IEqualityComparer<Tag>
        {

            #region IEqualityComparer<Tag> Members

            public bool Equals(Tag x, Tag y)
            {
                return x.ImageID == y.ImageID && x.Name == y.Name;
            }

            public int GetHashCode(Tag obj)
            {
                return obj.GetHashCode();
            }

            #endregion
        }

        public override bool Equals(object obj)
        {
            var tag = obj as Tag;
            if (tag != null)
                return this.ImageID == tag.ImageID && this.Name == tag.Name;
            return base.Equals(obj);
        }

        public override int GetHashCode()
        {
            return this.ImageID.GetHashCode() + this.Name.GetHashCode();
        }
    }
}
