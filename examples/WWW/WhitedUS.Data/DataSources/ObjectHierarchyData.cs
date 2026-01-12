using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// The <see cref="IHierarchyData"/> implementation for <see cref="CompositeHierarchicalDataSource"/>.
    /// </summary>
    public class ObjectHierarchyData : IHierarchyData, ICustomTypeDescriptor {

        private object _data;
        private ObjectHierarchyData _parent;
        private int _index = -1;
        private string _path;
        private ObjectHierarchicalDataSource _owner;

        /// <summary>
        /// Constructs an ObjectHierarchyData object, which is a wrapper around any object that can be used in ObectHierarchy enumerables.
        /// </summary>
        /// <param name="data">The object to wrap.</param>
        /// <param name="parent">The parent of the object in the graph. Must be IEnumerable to use this constructor.</param>
        /// <param name="index">The index of the object in the enumeration of the parent.</param>
        internal ObjectHierarchyData(object data, ObjectHierarchyData parent, int index) {

            if (index < 0) {
                throw new ArgumentOutOfRangeException("index", "Index must be a positive integer.");
            }
            _index = index;
            _data = data;
            _parent = parent;
            if (_parent != null) {
                _owner = _parent.Owner;
            }
        }

        /// <summary>
        /// Constructs an ObjectHierarchyData object, which is a wrapper around any object that can be used in ObectHierarchy enumerables.
        /// </summary>
        /// <param name="data">The object to wrap.</param>
        /// <param name="parent">The parent of the object in the graph. Must be IEnumerable to use this constructor.</param>
        /// <param name="index">The index of the object in the enumeration of the parent.</param>
        internal ObjectHierarchyData(object data, ObjectHierarchyData parent, int index, ObjectHierarchicalDataSource owner) {

            if (index < 0) {
                throw new ArgumentOutOfRangeException("index", "Index must be a positive integer.");
            }
            _index = index;
            _data = data;
            _parent = parent;
            _owner = owner;
        }

        public IHierarchicalEnumerable Children {
            get {
                return new ObjectHierarchicalEnumerable(this);
            }
        }

        public virtual bool HasChildren {
            get {
                object data = _data;

                if (data is string) {
                    return false;
                }

                if (Owner != null) {
                    SelectMethod selectMethod = Owner.SelectMethods.GetSelectMethod(data.GetType());
                    if (selectMethod != null) {
                        if (selectMethod.PropertyNames != null) {
                            return (selectMethod.PropertyNames.Length != 0);
                        }
                        else if (selectMethod.Method.Length != 0) {
                            data = selectMethod.GetValueFromMethod(data);
                        }
                    }
                }

                IEnumerable enumerableData = data as IEnumerable;
                if (enumerableData != null) {
                    return enumerableData.GetEnumerator().MoveNext();
                }
                return false;
            }
        }

        public virtual object Item {
            get {
                return _data;
            }
        }

        public virtual ObjectHierarchyData Parent {
            get {
                return _parent;
            }
        }

        internal ObjectHierarchicalDataSource Owner {
            get {
                return _owner;
            }
        }

        public virtual string Path {
            get {
                if (Parent == null) {
                    return String.Empty;
                }
                if (_path == null) {
                    // If we don't yet have a path, create one and cache it
                    string parentPath = (Parent != null) ? Parent.Path : String.Empty;
                    _path = parentPath + "." + _index.ToString();
                }
                return _path;
            }
        }

        public override string ToString() {
            return _data.ToString();
        }

        #region IHierarchyData Members

        IHierarchicalEnumerable IHierarchyData.GetChildren() {
            return Children;
        }

        IHierarchyData IHierarchyData.GetParent() {
            return Parent;
        }

        bool IHierarchyData.HasChildren {
            get {
                return HasChildren;
            }
        }

        object IHierarchyData.Item {
            get { return _data; }
        }

        string IHierarchyData.Path {
            get {
                return Path;
            }
        }

        string IHierarchyData.Type {
            get {
                return _data.GetType().Name;
            }
        }

        #endregion

        #region ICustomTypeDescriptor Members
        System.ComponentModel.AttributeCollection ICustomTypeDescriptor.GetAttributes() {
            return TypeDescriptor.GetAttributes(_data);
        }

        string ICustomTypeDescriptor.GetClassName() {
            return TypeDescriptor.GetClassName(_data);
        }

        string ICustomTypeDescriptor.GetComponentName() {
            return TypeDescriptor.GetComponentName(_data);

        }

        TypeConverter ICustomTypeDescriptor.GetConverter() {
            return TypeDescriptor.GetConverter(_data);
        }

        EventDescriptor ICustomTypeDescriptor.GetDefaultEvent() {
            return TypeDescriptor.GetDefaultEvent(_data);
        }

        PropertyDescriptor ICustomTypeDescriptor.GetDefaultProperty() {
            return TypeDescriptor.GetDefaultProperty(_data);
        }

        object ICustomTypeDescriptor.GetEditor(Type editorBaseType) {
            return TypeDescriptor.GetEditor(_data, editorBaseType);
        }

        EventDescriptorCollection ICustomTypeDescriptor.GetEvents() {
            return TypeDescriptor.GetEvents(_data);
        }

        EventDescriptorCollection ICustomTypeDescriptor.GetEvents(Attribute[] attrs) {
            return TypeDescriptor.GetEvents(_data, attrs);
        }

        PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties() {
            return ((ICustomTypeDescriptor)this).GetProperties(null);
        }

        PropertyDescriptorCollection ICustomTypeDescriptor.GetProperties(Attribute[] attrFilter) {
            PropertyDescriptorCollection dataProperties = TypeDescriptor.GetProperties(_data, attrFilter);
            List<PropertyDescriptor> properties = new List<PropertyDescriptor>(dataProperties.Count + 1);
            properties.Add(new ObjectHierarchyDataPropertyDescriptor("#"));
            foreach (PropertyDescriptor descriptor in dataProperties) {
                properties.Add(descriptor);
            }
            return new PropertyDescriptorCollection(properties.ToArray());
        }

        object ICustomTypeDescriptor.GetPropertyOwner(PropertyDescriptor pd) {
            return _data;
        }
        #endregion

        private class ObjectHierarchyDataPropertyDescriptor : PropertyDescriptor {
            private string _name;

            public ObjectHierarchyDataPropertyDescriptor(string name)
                : base(name, null) {

                _name = name;
            }


            public override Type ComponentType {
                get {
                    return typeof(ObjectHierarchyData);
                }
            }

            public override bool IsReadOnly {
                get {
                    return true;
                }
            }

            public override Type PropertyType {
                get {
                    return typeof(string);
                }
            }

            public override bool CanResetValue(object o) {
                return false;
            }

            public override object GetValue(object o) {
                ObjectHierarchyData data = o as ObjectHierarchyData;
                if (data != null && _name == "#") {
                    return data.Item.ToString();
                }

                return String.Empty;
            }

            public override void ResetValue(object o) {
                return;
            }

            public override void SetValue(object o, object value) {
            }

            public override bool ShouldSerializeValue(object o) {
                return true;
            }
        }
    }
}
