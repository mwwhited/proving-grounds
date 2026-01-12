using System;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Reflection;
using System.Web.UI;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {

    public class SelectMethod : IStateManager {

        private bool _isTrackingViewState;
        private string[] _propertyNames;
        private string _selectMethod;
        //private string _sortParameterName;
        private string _typeName;

        public SelectMethod() {
        }

        [TypeConverter(typeof(PropertyNamesConverter))]
        public virtual string[] PropertyNames {
            get {
                return _propertyNames;
            }
            set {
                _propertyNames = value;
            }
        }

        [DefaultValue("")]
        public virtual string Method {
            get {
                return (_selectMethod != null) ? _selectMethod : String.Empty;
            }
            set {
                _selectMethod = value;
            }
        }

        [DefaultValue("")]
        public virtual string TypeName {
            get {
                return (_typeName != null) ? _typeName : String.Empty;
            }
            set {
                _typeName = value;
            }
        }

        public virtual void SetDirty() {
        }

        #region IStateManager Members
        bool IStateManager.IsTrackingViewState {
            get {
                return IsTrackingViewState;
            }
        }

        protected virtual bool IsTrackingViewState {
            get {
                return _isTrackingViewState;
            }
        }

        internal object GetPropertyValue(int propertyIndex, object target) {
            PropertyInfo propInfo = target.GetType().GetProperty(
                PropertyNames[propertyIndex],
                BindingFlags.Public | BindingFlags.Instance);

            if (propInfo != null) {
                return propInfo.GetValue(target, null);
            }
            throw new InvalidOperationException(String.Format("Property {0} not found.", PropertyNames[propertyIndex]));
        }

        internal object GetValueFromMethod(object target) {
            MemberInfo[] memberInfo = target.GetType().GetMember(Method, BindingFlags.Public | BindingFlags.Instance);

            if ((memberInfo != null) && (memberInfo.Length != 0)) {
                if ((memberInfo[0].MemberType | MemberTypes.Method) != 0) {
                    return ((MethodInfo)memberInfo[0]).Invoke(target, new object[] { });
                }
                else if ((memberInfo[0].MemberType | MemberTypes.Property) != 0) {
                    return ((PropertyInfo)memberInfo[0]).GetValue(target, null);
                }
            }
            throw new InvalidOperationException(String.Format("Member {0} not found.", Method));
        }

        void IStateManager.LoadViewState(object state) {
            LoadViewState(state);
        }

        protected virtual void LoadViewState(object state) {
            object[] arrayState = state as object[];
            if (arrayState != null && arrayState.Length == 3) {
                PropertyNames = (string[])arrayState[0];
                Method = (string)arrayState[1];
                TypeName = (string)arrayState[2];
            }
        }

        object IStateManager.SaveViewState() {
            return SaveViewState();
        }

        protected virtual object SaveViewState() {
            return new object[] {
			PropertyNames,
			Method,
			TypeName};
        }

        void IStateManager.TrackViewState() {
            TrackViewState();
        }

        protected virtual void TrackViewState() {
            _isTrackingViewState = true;
        }

        #endregion
    }
}