using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Security.Data;

namespace WhitedUS.Security
{
    public class MyMembershipUser : MembershipUser, IMyIdentity
    {
        private Guid _myIdentityID;
        private bool _isDisabled;
        
        protected MyMembershipUser()
        {
        }

        MyMembershipUser(
            string providerName, 
            string name,
            Guid providerUserKey, 
            string email, 
            string passwordQuestion, 
            string comment, 
            bool isApproved, 
            bool isLockedOut, 
            DateTime creationDate, 
            DateTime lastLoginDate, 
            DateTime lastActivityDate, 
            DateTime lastPasswordChangedDate, 
            DateTime lastLockoutDate
            ): base (            
                providerName, 
                name, 
                providerUserKey, 
                email, 
                passwordQuestion, 
                comment, 
                isApproved, 
                isLockedOut, 
                creationDate, 
                lastLoginDate, 
                lastActivityDate, 
                lastPasswordChangedDate, 
                lastLockoutDate
            )
        {
            if (providerUserKey == Guid.Empty)
                throw new ArgumentOutOfRangeException();

            _isDisabled = !isApproved;
            _myIdentityID = providerUserKey;
        }

        public static MyMembershipUser CreateInstance(string providerName, MyUser myUser)
        {
            return new MyMembershipUser(
                providerName,
                myUser.UserName,
                myUser.UniqueID,
                myUser.EmailAddress,
                myUser.ChangePasswordQuestion,
                myUser.Comment,
                !myUser.IsDisabled,
                myUser.IsLocked,
                myUser.DateCreated,
                myUser.DateLastLogin ?? DateTime.MinValue,
                myUser.DateLastActivity ?? DateTime.MinValue,
                myUser.DateLastPasswordChange ?? DateTime.MinValue,
                myUser.DateLastLocked ?? DateTime.MinValue
                );
        }

        #region IMyIdentity Members

        public Guid MyIdentityID { get { return _myIdentityID; } }

        #endregion

        #region IIdentity Members

        public string AuthenticationType { get { return Constants.AUTHENTICATION_TYPE; } }

        public bool IsAuthenticated { get { return this.IsApproved & this.IsOnline & !this.IsLockedOut; } }

        public string Name { get { return UserName; } }

        #endregion

        #region IMyResource Members

        public Guid MyResourceID { get { return MyIdentityID; } }

        public bool IsDisabled { get { return _isDisabled; } }

        #endregion
    }
}
