using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// A view on the <see cref="ObjectHierarchicalDataSource"/>.
    /// </summary>
    public class ObjectHierarchicalDataSourceView : HierarchicalDataSourceView {
        private ObjectHierarchyData _parent;

        internal ObjectHierarchicalDataSourceView(ObjectHierarchyData parent) {
            if (parent == null) {
                throw new ArgumentNullException("parent");
            }
            _parent = parent;
        }

        public ObjectHierarchyData Parent {
            get { return _parent; }
        }

        public override bool Equals(object obj) {
            // The object is immutable, so it's ok to override Equals and GetHashCode.
            ObjectHierarchicalDataSourceView ohds = obj as ObjectHierarchicalDataSourceView;
            if (ohds == null) {
                return false;
            }
            return (ohds.Parent == Parent);
        }

        public override int GetHashCode() {
            // The object is immutable, so it's ok to override Equals and GetHashCode.
            return Parent.GetHashCode();
        }

        public override IHierarchicalEnumerable Select() {
            return new ObjectHierarchicalEnumerable(Parent);
        }
    }
}
