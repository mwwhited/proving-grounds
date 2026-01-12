using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Common;
using WhitedUS.Libs.Security.Crypt;
using WhitedUS.Security.Data;
using System.Data.Linq;
using WhitedUS.Security.Configuration;

//WhitedUS.Security.MyMembershipProvider,WhitedUS.Security,PublicKeyToken=f78fa6828975ead6
namespace WhitedUS.Security
{
    public class MyMembershipProvider : MembershipProvider
    {
        public override string ApplicationName
        {
            get { return MyProvidersConfiguration.CurrentConfig.ApplicationName; }
            set { MyProvidersConfiguration.CurrentConfig.ApplicationName = value; }
        }

        public override bool EnablePasswordReset { get { return true; } }

        public override bool EnablePasswordRetrieval { get { return false; } }

        public override MembershipPasswordFormat PasswordFormat { get { return MembershipPasswordFormat.Hashed; } }

        public override bool RequiresUniqueEmail { get { return true; } }

        public override bool RequiresQuestionAndAnswer { get { return true; } }

        public override int MaxInvalidPasswordAttempts
        {
            get { return MyMembershipProviderConfiguration.CurrentConfig.MaxInvalidPasswordAttempts; }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { return MyMembershipProviderConfiguration.CurrentConfig.MinRequiredNonAlphanumericCharacters; }
        }

        public override int MinRequiredPasswordLength
        {
            get { return MyMembershipProviderConfiguration.CurrentConfig.MinRequiredPasswordLength; }
        }

        public override int PasswordAttemptWindow
        {
            get { return MyMembershipProviderConfiguration.CurrentConfig.PasswordAttemptWindow; }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { return MyMembershipProviderConfiguration.CurrentConfig.PasswordStrengthRegularExpression; }
        }

        private IQueryable<MyUser> QueryUsers(DataMyAuthenticationDataContext db)
        {
            return (from u in db.MyUsers
                    //join uar in db.MyUserApplicationRoles on u.UniqueID equals uar.UserID
                    //join ar in db.MyApplicationRoles on uar.ApplicationRoleID equals ar.UniqueID
                    //join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
                    //where a.ApplicationName == ApplicationName && a.IsEnabled
                    select u); //.Where(predicate);
        }

        public IQueryable<MyUser> AllUsers(DataMyAuthenticationDataContext db)
        {
            return db.MyUsers;
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            if (string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(oldPassword) ||
                string.IsNullOrEmpty(newPassword))
                return false;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    MyUser myUser = QueryUsers(db).Where(u => u.UserName == username).SingleOrDefault();

                    if (myUser == null)
                        return false;

                    else if (UnixCrypt.MatchHash(oldPassword, myUser.PasswordHash))
                    {
                        myUser.PasswordHash = UnixCrypt.Hash(newPassword, MyMembershipProviderConfiguration.CurrentConfig.PasswordICryptClass);
                        db.SubmitChanges();
                        return true;
                    }
                    else
                        return false;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return false;
            }
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            if (string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(newPasswordQuestion) ||
                string.IsNullOrEmpty(newPasswordAnswer))
                return false;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    MyUser myUser = QueryUsers(db).Where(u => u.UserName == username).SingleOrDefault();
                    if (myUser == null)
                        return false;
                    else if (UnixCrypt.MatchHash(password, myUser.PasswordHash))
                    {
                        myUser.ChangePasswordQuestion = newPasswordQuestion;
                        myUser.ChangePasswordAnswerHash = UnixCrypt.Hash(newPasswordAnswer.ToLowerInvariant(), MyMembershipProviderConfiguration.CurrentConfig.PasswordICryptClass);

                        db.Refresh(RefreshMode.KeepChanges, myUser);
                        db.SubmitChanges();
                        return true;
                    }
                    else
                        return false;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return false;
            }
        }

        public override MembershipUser CreateUser(
            string username,
            string password,
            string email,
            string passwordQuestion,
            string passwordAnswer,
            bool isApproved,
            object providerUserKey,
            out MembershipCreateStatus status
            )
        {
            if (string.IsNullOrEmpty(username))
            {
                status = MembershipCreateStatus.InvalidUserName;
                return null;
            }
            if (string.IsNullOrEmpty(password))
            {
                status = MembershipCreateStatus.InvalidPassword;
                return null;
            }
            if (string.IsNullOrEmpty(passwordQuestion))
            {
                status = MembershipCreateStatus.InvalidQuestion;
                return null;
            }
            if (string.IsNullOrEmpty(passwordAnswer))
            {
                status = MembershipCreateStatus.InvalidAnswer;
                return null;
            }
            if (
                providerUserKey == null ||
                !(providerUserKey is Guid) ||
                ((Guid)providerUserKey == Guid.Empty)
                )
            {
                providerUserKey = Guid.NewGuid();
                //status = MembershipCreateStatus.InvalidProviderUserKey;
                //return null;
            }

            try
            {
                MyUser myUser = new MyUser()
                {
                    UserName = username,
                    PasswordHash = UnixCrypt.Hash(password, MyMembershipProviderConfiguration.CurrentConfig.PasswordICryptClass),
                    EmailAddress = email,
                    ChangePasswordQuestion = passwordQuestion,
                    ChangePasswordAnswerHash = UnixCrypt.Hash(passwordAnswer.ToLowerInvariant(), MyMembershipProviderConfiguration.CurrentConfig.PasswordICryptClass),
                    IsDisabled = !isApproved
                };

                MembershipUser membershipUser = MyMembershipUser.CreateInstance(this.GetType().Name, myUser);
                myUser.DateLastActivity = DateTime.UtcNow;

                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    db.MyUsers.InsertOnSubmit(myUser);
                    db.SubmitChanges(ConflictMode.FailOnFirstConflict);
                }

                if (Roles.Provider != null && !Roles.Provider.IsUserInRole(username, Constants.DEFAULT_ROLE))
                {
                    try
                    {
                        Roles.Provider.AddUsersToRoles(new[] { username }, new[] { Constants.DEFAULT_ROLE });
                    }
                    catch (Exception ex)
                    {
                        Debug.Write("MyMembershipProvider::CreateUser() - ");
                        Debug.WriteLine(ex.Message);
                    }
                }

                status = MembershipCreateStatus.Success;
                return membershipUser;
            }
            catch (SqlException sqlEx)
            {
                status = MembershipCreateStatus.UserRejected;
                if (sqlEx.Errors != null)
                    foreach (var sqlError in sqlEx.Errors.OfType<SqlError>())
                    {
                        if (string.IsNullOrEmpty(sqlError.Message))
                            continue;
                        else if (sqlError.Message.Contains("IX_MyUser_EmailAddress"))
                            status = MembershipCreateStatus.DuplicateEmail;
                        else if (sqlError.Message.Contains("IX_MyUser_UserName"))
                            status = MembershipCreateStatus.DuplicateUserName;
                        else if (sqlError.Message.Contains("PK_MyUser_UniqueID"))
                            status = MembershipCreateStatus.DuplicateProviderUserKey;
                    }
                return null;
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                status = MembershipCreateStatus.UserRejected;
                return null;
            }
        }

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                MembershipUserCollection users = new MembershipUserCollection();
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    foreach (var myUser in QueryUsers(db)
                        .Where(u => u.EmailAddress.Contains(emailToMatch))
                        .Skip(pageIndex * pageSize)
                        .Take(pageSize)
                        .Select(u => MyMembershipUser.CreateInstance(this.GetType().Name, u))
                        )
                        users.Add(myUser);
                }
                totalRecords = users.Count;
                return users;
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                totalRecords = 0;
                return null;
            }
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                MembershipUserCollection users = new MembershipUserCollection();
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    foreach (var myUser in QueryUsers(db)
                        .Where(u => u.UserName.Contains(usernameToMatch))
                        .Skip(pageIndex * pageSize)
                        .Take(pageSize)
                        .Select(u => MyMembershipUser.CreateInstance(this.GetType().Name, u))
                        )
                        users.Add(myUser);
                }
                totalRecords = users.Count;
                return users;
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                totalRecords = 0;
                return null;
            }
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            try
            {
                MembershipUserCollection users = new MembershipUserCollection();
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    foreach (var myUser in QueryUsers(db)
                        .Skip(pageIndex * pageSize)
                        .Take(pageSize)
                        .Select(u => MyMembershipUser.CreateInstance(typeof(MyMembershipProvider).Name, u))
                        )
                        users.Add(myUser);
                }
                totalRecords = users.Count;
                return users;
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                totalRecords = 0;
                return null;
            }
        }

        public override string GetUserNameByEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
                return null;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    var myUser = QueryUsers(db).Where(u => u.EmailAddress == email).SingleOrDefault();

                    if (myUser == null)
                        return null;

                    return myUser.UserName;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return null;
            }
        }

        public override bool ValidateUser(string username, string password)
        {
            if (string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password))
                return false;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    var users = QueryUsers(db).Where(u => u.UserName == username);
                    var myUser = users.SingleOrDefault();

                    if (myUser == null)
                        return false;

                    if (UnixCrypt.MatchHash(password, myUser.PasswordHash))
                    {
                        myUser.DateLastLogin = DateTime.UtcNow;
                        db.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return false;
            }
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotSupportedException();
        }

        public override bool UnlockUser(string userName)
        {
            if (string.IsNullOrEmpty(userName))
                return false;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    var myUser = QueryUsers(db).Where(u => u.UserName == userName).FirstOrDefault();

                    if (myUser == null)
                        return false;

                    if (myUser.IsLocked)
                    {
                        myUser.IsLocked = false;
                        db.SubmitChanges();
                    }
                    return true;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return false;
            }
        }

        public override void UpdateUser(MembershipUser user)
        {
            if (user == null)
                throw new ArgumentOutOfRangeException("You must provide a user");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var myUser = QueryUsers(db).Where(u => u.UserName == user.UserName).SingleOrDefault();

                if (myUser == null)
                    throw new NullReferenceException("User not found");

                if (myUser.Comment != user.Comment)
                    myUser.Comment = user.Comment;

                if (myUser.EmailAddress != user.Email)
                    myUser.EmailAddress = user.Email;

                if (myUser.IsDisabled == user.IsApproved)
                    myUser.IsDisabled = !user.IsApproved;

                //if(myUser.

                db.SubmitChanges();
            }
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            if (string.IsNullOrEmpty(username))
                return false;

            try
            {
                using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
                {
                    var myUser = QueryUsers(db).Where(u => u.UserName == username).FirstOrDefault();

                    if (myUser == null)
                        return false;

                    db.MyUsers.DeleteOnSubmit(myUser);
                    db.SubmitChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                EventLogger.LogEvent(ex);
                return false;
            }
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            if (string.IsNullOrEmpty(username))
                return null;

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var myUser = db.MyUsers.Where(u => u.UserName == username).SingleOrDefault();

                if (myUser == null)
                    return null;

                if (userIsOnline)
                {
                    myUser.DateLastActivity = DateTime.UtcNow;
                    db.SubmitChanges();
                }

                return MyMembershipUser.CreateInstance(typeof(MyMembershipProvider).Name, myUser);
            }
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            if (!(providerUserKey is Guid) || ((Guid)providerUserKey) == Guid.Empty)
                return null;

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var myUser = QueryUsers(db).Where(u => u.UniqueID == (Guid)providerUserKey).SingleOrDefault();

                if (myUser == null)
                    return null;

                if (userIsOnline)
                {
                    myUser.DateLastActivity = DateTime.UtcNow;
                    db.SubmitChanges();
                }

                return MyMembershipUser.CreateInstance(typeof(MyMembershipProvider).Name, myUser);
            }
        }

        public override string ResetPassword(string username, string answer)
        {
            if (string.IsNullOrEmpty(username))
                throw new NullReferenceException("UserName must be provided");

            if (string.IsNullOrEmpty(answer))
                throw new NullReferenceException("Answer must be provided");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var myUser = QueryUsers(db).Where(u => u.UserName == username).SingleOrDefault();

                if (myUser == null)
                    throw new NullReferenceException(string.Format("User \"{0}\" not found", username));

                if (!UnixCrypt.MatchHash(answer, myUser.ChangePasswordAnswerHash.ToLowerInvariant()))
                    throw new InvalidOperationException("Invalid Answer");

                string newPassword = MyMembershipProviderConfiguration.PasswordGenerator();

                myUser.PasswordHash = UnixCrypt.Hash(newPassword, MyMembershipProviderConfiguration.CurrentConfig.PasswordICryptClass);

                db.SubmitChanges();

                return newPassword;
            }
        }

        public override int GetNumberOfUsersOnline()
        {
            //TODO: MyMembershipProvider::GetNumberOfUsersOnline
            throw new NotImplementedException();
        }
    }
}
