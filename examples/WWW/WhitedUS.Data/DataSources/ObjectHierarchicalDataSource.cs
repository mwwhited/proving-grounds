using System;
using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// Wraps an object graph in a hierarchical data source.
    /// </summary>
    [ParseChildren(true)]
    [PersistChildren(false)]
    public class ObjectHierarchicalDataSource : HierarchicalDataSourceControl {

        private object _objectGraph;
        private SelectMethodCollection _selectMethods;

        private const char expressionPartSeparator = '.';

        public ObjectHierarchicalDataSource() {
        }

        /// <summary>
        /// The underlying object.
        /// </summary>
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public virtual object ObjectInstance {
            get {
                if (_objectGraph != null) {
                    return _objectGraph;
                }
                Type objectType = Type.GetType(TypeName);
                _objectGraph = Activator.CreateInstance(objectType);
                return _objectGraph;
            }
            set {
                if (value == null) {
                    throw new ArgumentNullException("value");
                }
                _objectGraph = value;
            }
        }

        /// <summary>
        /// The collection of selection instructions.
        /// </summary>
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [Category("Data")]
        public virtual SelectMethodCollection SelectMethods {
            get {
                if (_selectMethods == null) {
                    _selectMethods = new SelectMethodCollection();
                }
                return _selectMethods;
            }
        }

        /// <devdoc>
        /// The type to instantiate as the root of this object graph.
        /// </devdoc>
        [DefaultValue("")]
        public virtual string TypeName {
            get {
                string s = ViewState["TypeName"] as string;
                return (s != null) ? s : String.Empty;
            }
            set {
                ViewState["TypeName"] = value;
            }
        }

        /// <summary>
        /// Gets a <see cref="ObjectHierarchicalDataSourceView"/> for the provided path.
        /// </summary>
        /// <param name="viewPath">
        /// The path to the view.
        /// The path has the syntax object.property.property[intIndexer].property.
        /// Only string and integer indexers are supported for the moment.
        /// Parentheses can be used in place of square brackets for the indexers.
        /// The syntax here is almost the same as the ASP.NET databinding syntax.
        /// </param>
        /// <returns>A view of the data for this path.</returns>
        protected override HierarchicalDataSourceView GetHierarchicalView(string viewPath) {
            viewPath = viewPath.Trim();

            if (String.IsNullOrEmpty(viewPath)) {
                return new ObjectHierarchicalDataSourceView(new ObjectHierarchyData(ObjectInstance, null, 0, this));
            }

            if (ObjectInstance == null) {
                return null;
            }

            string[] expressionParts = viewPath.Split(expressionPartSeparator);

            object property = ObjectInstance;
            object propertyParent = null;
            ObjectHierarchyData data = new ObjectHierarchyData(ObjectInstance, null, 0, this);
            foreach (string expressionPart in expressionParts) {

                if (String.IsNullOrEmpty(expressionPart)) {
                    continue;
                }

                propertyParent = property;

                int index = Int32.Parse(expressionPart, NumberStyles.Integer, CultureInfo.InvariantCulture);

                // Find the right select method for the property, and fall back on enumerating the object if not found.
                SelectMethod method = SelectMethods.GetSelectMethod(property.GetType());
                bool done = false;
                if (method != null) {
                    if (method.PropertyNames != null && method.PropertyNames.Length != 0) {
                        property = method.GetPropertyValue(index, property);
                        done = true;
                    }
                    else if (method.Method.Length != 0) {
                        property = method.GetValueFromMethod(property);
                    }
                }
                if (!done) {
                    Array collectionArray = property as Array;
                    if (collectionArray != null) {
                        property = collectionArray.GetValue(index);
                    }
                    else {
                        IList collectionIList = property as IList;
                        if (collectionIList != null) {
                            property = collectionIList[index];
                        }
                        else {
                            PropertyInfo propInfo =
                                property.GetType().GetProperty(
                                    "Item",
                                    BindingFlags.Public | BindingFlags.Instance,
                                    null,
                                    null,
                                    new Type[] { typeof(Int32) },
                                    null);

                            if (propInfo != null) {
                                property = propInfo.GetValue(property, new object[] { index });
                            }
                            else {
                                IEnumerable collectionEnumerable = property as IEnumerable;
                                if (collectionEnumerable != null) {
                                    int i = 0;
                                    foreach (object enumerated in collectionEnumerable) {
                                        if (i++ == index) {
                                            property = enumerated;
                                            done = true;
                                            break;
                                        }
                                    }
                                    if (!done) {
                                        throw new ArgumentOutOfRangeException("viewPath", "Index out of range.");
                                    }
                                }
                            }
                        }
                    }
                }
                data = new ObjectHierarchyData(property, data, index);
            }
            return new ObjectHierarchicalDataSourceView(data);
        }

        #region State Management

        protected override void LoadViewState(object savedState) {
            Pair pairState = savedState as Pair;
            if (pairState != null) {
                base.LoadViewState(pairState.First);
                ((IStateManager)_selectMethods).LoadViewState(pairState.Second);
            }
            else {
                base.LoadViewState(savedState);
            }
        }

        protected override object SaveViewState() {
            if (_selectMethods != null && _selectMethods.Count > 0) {
                return new Pair(base.SaveViewState(), ((IStateManager)_selectMethods).SaveViewState());
            }
            return base.SaveViewState();
        }

        protected override void TrackViewState() {
            base.TrackViewState();

            if (_selectMethods != null) {
                ((IStateManager)_selectMethods).TrackViewState();
            }
        }
        #endregion
    }
}
