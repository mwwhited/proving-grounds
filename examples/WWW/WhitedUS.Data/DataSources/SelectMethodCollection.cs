using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.UI;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// A collection of <see cref="SelectMethod"/>s. This collection can maintain state in the ViewState.
    /// </summary>
    public class SelectMethodCollection : StateManagedCollection {
        private static readonly Type[] knownTypes = new Type[] { typeof(SelectMethod) };

        internal SelectMethodCollection() {
        }

        /// <summary>
        /// Indexed and strongly-typed access to the elements of the collection.
        /// </summary>
        /// <param name="i">The index of the element.</param>
        /// <returns>The <see cref="SelectMethod"/> at that index.</returns>
        public SelectMethod this[int i] {
            get {
                return (SelectMethod)((IList)this)[i];
            }
            set {
                ((IList)this)[i] = value;
            }
        }

        /// <summary>
        /// Adds a <see cref="SelectMethod"/> to the collection.
        /// </summary>
        /// <param name="selectMethod">The <see cref="SelectMethod"/> to add.</param>
        /// <returns>The index of the <see cref="SelectMethod"/>.</returns>
        public int Add(SelectMethod selectMethod) {
            return ((IList)this).Add(selectMethod);
        }

        /// <summary>
        /// Determines if a <see cref="SelectMethod"/> is in the collection.
        /// </summary>
        /// <param name="selectMethod">The <see cref="SelectMethod"/> to find.</param>
        /// <returns>true if the <see cref="SelectMethod"/> is in the collection.</returns>
        public bool Contains(SelectMethod selectMethod) {
            return ((IList)this).Contains(selectMethod);
        }

        /// <summary>
        /// Copies the collection to a <see cref="SelectMethod"/> array.
        /// </summary>
        /// <param name="selectMethodArray">The array to copy the collection to.</param>
        /// <param name="index">The index at which copying begins.</param>
        public void CopyTo(SelectMethod[] selectMethodArray, int index) {
            base.CopyTo(selectMethodArray, index);
        }

        public SelectMethod GetSelectMethod(Type type) {
            SelectMethod defaultMethod = null;
            string typeName = type.Name;
            foreach (SelectMethod method in this) {
                if ((defaultMethod == null) && (method.TypeName.Length == 0)) {
                    defaultMethod = method;
                }
                else if (typeName == method.TypeName) {
                    return method;
                }
            }
            return defaultMethod;
        }

        /// <summary>
        /// The index of the provided <see cref="SelectMethod"/>.
        /// </summary>
        /// <param name="selectMethod">The <see cref="SelectMethod"/> for which we want the index.</param>
        /// <returns>The index of the <see cref="SelectMethod"/> if it is in the collection, -1 otherwise.</returns>
        public int IndexOf(SelectMethod selectMethod) {
            return ((IList)this).IndexOf(selectMethod);
        }

        /// <summary>
        /// Inserts a <see cref="SelectMethod"/> into the collection at the specified index.
        /// </summary>
        /// <param name="index">The index where to insert.</param>
        /// <param name="selectMethod">The <see cref="SelectMethod"/> to insert.</param>
        public void Insert(int index, SelectMethod selectMethod) {
            ((IList)this).Insert(index, selectMethod);
        }

        protected override object CreateKnownType(int index) {
            return new SelectMethod();
        }

        protected override Type[] GetKnownTypes() {
            return knownTypes;
        }

        /// <summary>
        /// Removes a <see cref="SelectMethod"/> from the collection.
        /// </summary>
        /// <param name="selectMethod">The <see cref="SelectMethod"/> to remove.</param>
        public void Remove(SelectMethod selectMethod) {
            ((IList)this).Remove(selectMethod);
        }

        /// <summary>
        /// Removes a <see cref="SelectMethod"/> from the collection.
        /// </summary>
        /// <param name="index">The index of the <see cref="SelectMethod"/> to remove.</param>
        public void RemoveAt(int index) {
            ((IList)this).RemoveAt(index);
        }

        protected override void SetDirtyObject(object o) {
            if (o is SelectMethod) {
                ((SelectMethod)o).SetDirty();
            }
        }
    }
}

