using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using WhitedUS.Web.Areas.Administration.Models;

namespace WhitedUS.Web.Areas.Administration.Controllers
{
    [Authorize(Roles = "Administrators")]
    public class UsersController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        private UserModel ToModel(MembershipUser user)
        {
            if (user == null)
                return null;
            return new UserModel
            {
                UserID = (Guid)user.ProviderUserKey,
                UserName = user.UserName,
                Comment = user.Comment,
                CreationDate = user.CreationDate,
                Email = user.Email,
                IsApproved = user.IsApproved,
                IsLockedOut = user.IsLockedOut,
                IsOnline = user.IsOnline,
                LastActivityDate = user.LastActivityDate,
                LastLockoutDate = user.LastLockoutDate,
                LastLoginDate = user.LastLoginDate,
                LastPasswordChangedDate = user.LastPasswordChangedDate,
            };
        }

        [HttpPost]
        public ActionResult List(int page = 1, int pageSize = 20)
        {
            int count;
            var users = Membership.Provider.GetAllUsers(page - 1, pageSize, out count);
            var query = from user in users.Cast<MembershipUser>()
                        select new UserModel
                        {
                            UserID = (Guid)user.ProviderUserKey,
                            UserName = user.UserName,
                            Comment = user.Comment,
                            CreationDate = user.CreationDate,
                            Email = user.Email,
                            IsApproved = user.IsApproved,
                            IsLockedOut = user.IsLockedOut,
                            IsOnline = user.IsOnline,
                            LastActivityDate = user.LastActivityDate,
                            LastLockoutDate = user.LastLockoutDate,
                            LastLoginDate = user.LastLoginDate,
                            LastPasswordChangedDate = user.LastPasswordChangedDate,
                        };

            if (this.Request.IsAjaxRequest())
            {
                var pageModel = PageModel.ToModel(page, pageSize, count, query);
                return this.Json(pageModel);
            }
            throw new NotSupportedException();
        }

        [HttpPost]
        public ActionResult Save(UserSimpleModel model)
        {
            var user = Membership.Provider.GetUser(model.UserName, false);
            var success = false;
            if (user == null)
            {
                var tempPassword = Guid.NewGuid().ToString();
                MembershipCreateStatus status;
                var membershipUser = Membership.Provider.CreateUser(
                    model.UserName,
                    tempPassword,
                    model.Email,
                    null,
                    null,
                    model.IsApproved,
                    null,
                    out status);

                if (status == MembershipCreateStatus.Success)
                {
                    var password = membershipUser.ResetPassword();
                    membershipUser.Comment = model.Comment;
                    Membership.Provider.UpdateUser(membershipUser);
                    success = true;
                }
            }
            else
            {
                user.Comment = model.Comment;
                user.Email = model.Email;
                user.IsApproved = model.IsApproved;

                Membership.Provider.UpdateUser(user);
                success = true;
            }

            if (this.Request.IsAjaxRequest())
            {
                var newUser = Membership.Provider.GetUser(model.UserName, false);
                var newModel = this.ToModel(newUser);
                return this.Json(new
                {
                    Success = success,
                    User = newModel,
                });
            }
            throw new NotSupportedException();
        }

        [HttpDelete]
        public ActionResult Delete(UserSimpleModel model)
        {
            var success = Membership.Provider.DeleteUser(model.UserName, true);
            if (this.Request.IsAjaxRequest())
            {
                return this.Json(new
                {
                    Success = success,
                });
            }
            throw new NotSupportedException();
        }
    }
}
