using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Shared.Data;
using WhitedUS.Shared.Models;
using WhitedUS.Shared.Models.Security;
using System.Diagnostics.Contracts;
using WhitedUS.Common.Security.Crypt;
using System.Diagnostics;
using WhitedUS.Common.Security;

namespace WhitedUS.Web.Security
{
    public class AspnetMembershipProvider : MembershipProvider
    {
        public AspnetMembershipProvider()
        {
        }

        public override void Initialize(string name, NameValueCollection config)
        {
            base.Initialize(name, config);

            this.Name = name;
            this.ApplicationName = config["applicationName"];
            this.ConnectionString = config["connectionString"];
        }

        private ApplicationModel _application;
        private ApplicationModel Application
        {
            get
            {
                if (_application == null)
                    using (var db = GetDataContext())
                        _application = db.Applications.Select(app => new ApplicationModel
                                        {
                                            Name = app.Name,
                                            Description = app.Description,

                                            EnablePasswordReset = app.EnablePasswordReset,
                                            MaxInvalidPasswordAttempts = app.MaxInvalidPasswordAttempts,
                                            MinRequiredNonAlphanumericCharacters = app.MinRequiredNonAlphanumericCharacters,
                                            MinRequiredPasswordLength = app.MinRequiredPasswordLength,
                                            PasswordAttemptWindow = app.PasswordAttemptWindow,
                                            PasswordStrengthRegularExpression = app.PasswordStrengthRegularExpression,
                                            RequiresQuestionAndAnswer = app.RequiresQuestionAndAnswer,
                                            RequiresUniqueEmail = app.RequiresUniqueEmail,
                                            InvalidPasswordWindow = app.InvalidPasswordWindow,
                                        }).FirstOrDefault(app => app.Name == this.ApplicationName);
                return _application;
            }
        }
        private SharedEntities GetDataContext()
        {
            return SharedEntities.Factory(this.ConnectionString);
        }

        public string Name { get; private set; }
        public string ConnectionString { get; private set; }

        public override string ApplicationName { get; set; }
        public override bool EnablePasswordRetrieval
        {
            get { return false; }
        }
        public override MembershipPasswordFormat PasswordFormat
        {
            get { return MembershipPasswordFormat.Hashed; }
        }

        public override bool EnablePasswordReset
        {
            get { return this.Application.EnablePasswordReset; }
        }
        public override int MaxInvalidPasswordAttempts
        {
            get { return this.Application.MaxInvalidPasswordAttempts; }
        }
        public override int MinRequiredNonAlphanumericCharacters
        {
            get { return this.Application.MinRequiredNonAlphanumericCharacters; }
        }
        public override int MinRequiredPasswordLength
        {
            get { return this.Application.MinRequiredPasswordLength; }
        }
        public override int PasswordAttemptWindow
        {
            get { return this.Application.PasswordAttemptWindow; }
        }
        public override string PasswordStrengthRegularExpression
        {
            get { return this.Application.PasswordStrengthRegularExpression; }
        }
        public override bool RequiresQuestionAndAnswer
        {
            get { return this.Application.RequiresQuestionAndAnswer; }
        }
        public override bool RequiresUniqueEmail
        {
            get { return this.Application.RequiresUniqueEmail; }
        }
        public override string Description
        {
            get { return this.Application.Description; }
        }

        private MembershipUser GetUserFromEntity(User entity)
        {
            return new MembershipUser(
            this.Name,
            entity.UserName,
            entity.UserID,
            entity.Email,
            entity.RecoveryQuestion,
            entity.Description,
            entity.IsApproved,
            entity.IsLockedOut,
            entity.CreationDate,
            entity.LastLoginDate,
            entity.LastActivityDate,
            entity.LastPasswordChangedDate,
            entity.LastLockoutDate
            );
        }
        private string Hash(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return null;
            return UnixCrypt.Hash<Md5Crypt>(input);
        }
        private bool CompareHash(string hash, string input)
        {
            return UnixCrypt.MatchHash(input, hash);
        }

        public override string GetPassword(string username, string answer)
        {
            throw new InvalidOperationException();
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == username);
                var timestamp = DateTime.UtcNow;

                if (entity != null && this.CompareHash(entity.PasswordCrypt, oldPassword))
                {
                    entity.PasswordCrypt = this.Hash(newPassword);
                    entity.LastPasswordChangedDate = timestamp;
                    entity.LastActivityDate = timestamp;

                    db.SaveChanges();
                }

                return false;
            }
        }
        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == username);
                var timestamp = DateTime.UtcNow;

                if (entity != null)
                {
                    entity.PasswordCrypt = this.Hash(password);
                    entity.RecoveryQuestion = newPasswordQuestion;
                    entity.RecoveryAnswer = this.Hash(newPasswordAnswer);
                    entity.LastPasswordChangedDate = timestamp;
                    entity.LastActivityDate = timestamp;

                    db.SaveChanges();
                }

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
            out MembershipCreateStatus status)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(username))
                {
                    status = MembershipCreateStatus.InvalidUserName;
                    return null;
                }
                if (string.IsNullOrWhiteSpace(password))
                {
                    status = MembershipCreateStatus.InvalidPassword;
                    return null;
                }
                if (providerUserKey != null && !(providerUserKey is Guid))
                {
                    status = MembershipCreateStatus.InvalidProviderUserKey;
                    return null;
                }

                //TODO: Email Address Validation
                if (string.IsNullOrWhiteSpace(email))
                {
                    status = MembershipCreateStatus.InvalidEmail;
                    return null;
                }

                if (this.RequiresQuestionAndAnswer)
                {
                    if (string.IsNullOrWhiteSpace(passwordQuestion))
                    {
                        status = MembershipCreateStatus.InvalidQuestion;
                        return null;
                    }
                    if (string.IsNullOrWhiteSpace(passwordAnswer))
                    {
                        status = MembershipCreateStatus.InvalidAnswer;
                        return null;
                    }
                }

                using (var db = this.GetDataContext())
                {
                    if (db.Users.Any(u => u.UserName == username))
                    {
                        status = MembershipCreateStatus.DuplicateUserName;
                        return null;
                    }

                    var userid = (providerUserKey != null && providerUserKey is Guid)
                                    ? (Guid)providerUserKey
                                    : Guid.NewGuid();
                    if (db.Users.Any(u => u.UserID == userid))
                    {
                        status = MembershipCreateStatus.DuplicateProviderUserKey;
                        return null;
                    }

                    if (this.RequiresUniqueEmail && db.Users.Any(u => u.Email == email))
                    {
                        status = MembershipCreateStatus.DuplicateEmail;
                        return null;
                    }

                    var timestamp = DateTime.UtcNow;
                    var mintimestamp = new DateTime(1754, 1, 1);
                    var entity = new User
                    {
                        UserName = username,
                        PasswordCrypt = this.Hash(password),
                        Email = email,
                        RecoveryQuestion = passwordQuestion,
                        RecoveryAnswer = this.Hash(passwordAnswer),
                        IsApproved = isApproved,

                        CreationDate = timestamp,
                        LastActivityDate = timestamp,
                        LastPasswordChangedDate = timestamp,
                        LastLockoutDate = mintimestamp,
                        LastLoginDate = mintimestamp,

                        UserID = userid,

                        IsLockedOut = false,
                        IsOnline = false,
                        IsServiceAccount = false,
                        //Description,                    
                    };

                    db.Users.AddObject(entity);
                    db.SaveChanges();

                    var membership = GetUserFromEntity(entity);
                    status = MembershipCreateStatus.Success;
                    return membership;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("AspnetMembershipProvider::CreateUser-{0}", ex);
                status = MembershipCreateStatus.ProviderError;
                return null;
                //status = MembershipCreateStatus.UserRejected;
            }
        }
        public override int GetNumberOfUsersOnline()
        {
            using (var db = this.GetDataContext())
                return db.Users.Count(u => u.IsOnline);
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            using (var db = this.GetDataContext())
            {
                var user = db.Users.SingleOrDefault(u => u.UserName == username);

                if (deleteAllRelatedData)
                    foreach (var role in user.Roles)
                        user.Roles.Remove(role);

                db.Users.DeleteObject(user);

                db.SaveChanges();

                return true;
            }
        }
        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            using (var db = this.GetDataContext())
            {
                var users = db.Users.Where(u => u.Email.Contains(emailToMatch)).OrderBy(u => u.UserName);
                totalRecords = db.Users.Count();
                var query = users.Skip(pageIndex * pageSize).Take(pageSize).ToList();

                var collection = new MembershipUserCollection();
                query.ForEach(entity => collection.Add(this.GetUserFromEntity(entity)));

                return collection;
            }
        }
        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            using (var db = this.GetDataContext())
            {
                var users = db.Users.Where(u => u.UserName.Contains(usernameToMatch)).OrderBy(u => u.UserName);
                totalRecords = db.Users.Count();
                var query = users.Skip(pageIndex * pageSize).Take(pageSize).ToList();

                var collection = new MembershipUserCollection();
                query.ForEach(entity => collection.Add(this.GetUserFromEntity(entity)));

                return collection;
            }
        }
        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            using (var db = this.GetDataContext())
            {
                var users = db.Users.OrderBy(u => u.UserName);
                totalRecords = db.Users.Count();
                var query = users.Skip(pageIndex * pageSize).Take(pageSize).ToList();

                var collection = new MembershipUserCollection();
                query.ForEach(entity => collection.Add(this.GetUserFromEntity(entity)));

                return collection;
            }
        }
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            if (string.IsNullOrWhiteSpace(username))
                return null;

            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == username);

                if (entity == null)
                    return null;

                if (userIsOnline)
                {
                    entity.LastLoginDate = DateTime.UtcNow;
                    entity.IsOnline = true;
                    db.SaveChanges();
                }

                var result = this.GetUserFromEntity(entity);
                return result;
            }
        }
        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            if (providerUserKey == null || !(providerUserKey is Guid))
                throw new InvalidOperationException();

            using (var db = this.GetDataContext())
            {
                var userId = (Guid)providerUserKey;
                var entity = db.Users.Single(u => u.UserID == userId);

                if (userIsOnline)
                {
                    entity.LastLoginDate = DateTime.UtcNow;
                    entity.IsOnline = true;
                    db.SaveChanges();
                }

                var result = this.GetUserFromEntity(entity);
                return result;
            }
        }
        public override string GetUserNameByEmail(string email)
        {
            using (var db = this.GetDataContext())
            {
                var username = db.Users
                                 .Where(u => u.Email == email)
                                 .Select(u => u.UserName)
                                 .FirstOrDefault()
                                 ;
                return username;

            }
        }
        public override string ResetPassword(string username, string answer)
        {
            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == username);
                var timestamp = DateTime.UtcNow;

                if (entity == null)
                    throw new ApplicationException("User Not Found");

                entity.LastActivityDate = timestamp;

                string newPassword = null;
                if (!this.CompareHash(entity.RecoveryAnswer, answer))
                {
                    var checkTime = entity.FailedAnswerWindowsStart
                                    + (this.Application.InvalidPasswordWindow - new DateTime(1900, 1, 1))
                                          ;
                    if (timestamp > checkTime || entity.FailedAnswerCount == 0)
                    {
                        entity.FailedAnswerCount = 1;
                        entity.FailedAnswerWindowsStart = timestamp;
                    }
                    else
                    {
                        entity.FailedAnswerCount += 1;
                    }

                    if (entity.FailedAnswerCount >= this.MaxInvalidPasswordAttempts)
                    {
                        entity.IsLockedOut = true;
                    }
                }
                else
                {
                    newPassword = PasswordTools.GeneratePassword(this.MinRequiredPasswordLength);
                    entity.PasswordCrypt = Hash(newPassword);
                    entity.LastPasswordChangedDate = timestamp;
                }

                db.SaveChanges();

                return newPassword;
            }
        }
        public override bool UnlockUser(string userName)
        {
            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == userName);

                if (entity == null)
                    return false;

                entity.IsLockedOut = false;

                db.SaveChanges();

                return true;
            }
        }

        public override void UpdateUser(MembershipUser user)
        {
            var providerUserKey = user.ProviderUserKey;
            if (providerUserKey == null || !(providerUserKey is Guid))
                throw new InvalidOperationException();
            var userId = (Guid)providerUserKey;
            using (var db = this.GetDataContext())
            {
                var entity = db.Users.Single(u => u.UserID == userId);
                var timestamp = DateTime.UtcNow;

                entity.UserName = user.UserName;
                entity.Email = user.Email;
                entity.Description = user.Comment;
                entity.LastActivityDate = timestamp;
                entity.IsApproved = user.IsApproved;

                db.SaveChanges();
            }
        }
        public override bool ValidateUser(string username, string password)
        {
            if (string.IsNullOrWhiteSpace(username)
                || string.IsNullOrWhiteSpace(password))
                return false;

            using (var db = this.GetDataContext())
            {
                var entity = db.Users.SingleOrDefault(u => u.UserName == username);

                if (entity == null)
                    return false;

                var timestamp = DateTime.UtcNow;
                var result = false;

                entity.LastActivityDate = timestamp;
                if (entity.IsLockedOut || !entity.IsApproved)
                {
                }
                else if (this.CompareHash(entity.PasswordCrypt, password))
                {
                    entity.LastLoginDate = timestamp;
                    entity.FailedAnswerCount = 0;
                    entity.FailedPasswordCount = 0;

                    result = true;
                }
                else
                {
                    var checkTime = entity.FailedPasswordWindowsStart
                                    + (this.Application.InvalidPasswordWindow - new DateTime(1900, 1, 1))
                                          ;
                    if (timestamp > checkTime || entity.FailedPasswordCount == 0)
                    {
                        entity.FailedPasswordCount = 1;
                        entity.FailedPasswordWindowsStart = timestamp;
                    }
                    else
                    {
                        entity.FailedPasswordCount += 1;
                    }

                    if (entity.FailedPasswordCount >= this.MaxInvalidPasswordAttempts)
                    {
                        entity.IsLockedOut = true;
                    }
                }
                db.SaveChanges();
                return result;
            }
        }
    }
}
