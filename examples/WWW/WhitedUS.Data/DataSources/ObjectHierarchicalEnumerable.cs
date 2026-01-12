using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Reflection;
using System.Web;
using System.Web.UI;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// <see cref="IHierarchicalEnumerable"/> implementation for <see cref="ObjectHierarchicalDataSource"/>.
    /// </summary>
    public class ObjectHierarchicalEnumerable : IHierarchicalEnumerable {
        private ObjectHierarchyData _parent;

        internal static readonly BindingFlags PublicProperties = BindingFlags.Public | BindingFlags.GetProperty;

        internal ObjectHierarchicalEnumerable(ObjectHierarchyData parent) {
            if (parent == null) {
                throw new ArgumentNullException("parent");
            }
            _parent = parent;
        }

        #region IHierarchicalEnumerable Members

        IHierarchyData IHierarchicalEnumerable.GetHierarchyData(object enumeratedItem) {
            return (IHierarchyData)enumeratedItem;
        }

        #endregion

        #region IEnumerable Members

        System.Collections.IEnumerator IEnumerable.GetEnumerator() {
            object data = _parent.Item;

            if (data is string) {
                yield break;
            }

            if (_parent.Owner != null) {
                SelectMethod selectMethod = _parent.Owner.SelectMethods.GetSelectMethod(data.GetType());
                if (selectMethod != null) {
                    if (selectMethod.PropertyNames != null) {
                        for (int i = 0; i < selectMethod.PropertyNames.Length; i++) {
                            yield return new ObjectHierarchyData(selectMethod.GetPropertyValue(i, data), _parent, i);
                        }
                    }
                    else if (selectMethod.Method.Length != 0) {
                        data = selectMethod.GetValueFromMethod(data);
                    }
                }
            }

            // If the object is enumerable (and not a string), we enumerate it.
            IEnumerable enumerableParent = data as IEnumerable;
            if (enumerableParent != null) {
                int i = 0;
                foreach (object enumerated in enumerableParent) {
                    yield return new ObjectHierarchyData(enumerated, _parent, i++);
                }
            }
            yield break;
        }

        #endregion
    }
}