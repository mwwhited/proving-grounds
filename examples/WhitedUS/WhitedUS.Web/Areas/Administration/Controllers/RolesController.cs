using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WhitedUS.Web.Areas.Administration.Models;

namespace WhitedUS.Web.Areas.Administration.Controllers
{
    [Authorize(Roles = "Administrators")]
    public class RolesController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult List()
        {
            var roles = Roles.Provider.GetAllRoles();
            var query = from role in roles
                        select new RoleModel
                        {
                            RoleName = role,
                        };

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(query);
            }
            throw new NotSupportedException();
        }

        [HttpPut]
        public ActionResult Create(RoleModel model)
        {
            Roles.Provider.CreateRole(model.RoleName);

            if (this.Request.IsAjaxRequest())
            {
                return this.List();
            }

            throw new NotSupportedException();
        }

        [HttpDelete]
        public ActionResult Delete(RoleModel model)
        {
            var success = Roles.Provider.DeleteRole(model.RoleName, true);

            if (success && this.Request.IsAjaxRequest())
            {
                return this.List();
            }

            throw new NotSupportedException();
        }

        [HttpPost]
        public ActionResult ForUser(string username)
        {
            var query = from role in Roles.Provider.GetRolesForUser(username)
                        select new RoleModel
                        {
                            RoleName = role,
                        };

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(query);
            }
            throw new NotSupportedException();
        }
        [HttpPost]
        public ActionResult ExceptForUser(string username)
        {
            var query = from role in Roles.Provider.GetAllRoles().Except(Roles.Provider.GetRolesForUser(username))
                        select new RoleModel
                        {
                            RoleName = role,
                        };

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(query);
            }
            throw new NotSupportedException();
        }

        [HttpPut]
        public ActionResult Assign(List<string> users, List<string> roles)
        {
            Roles.Provider.AddUsersToRoles(users.ToArray(), roles.ToArray());

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(new
                {
                    Success = true,
                    Users = users,
                    Roles = roles,
                });
            }
            throw new NotSupportedException();
        }

        [HttpDelete]
        public ActionResult Unassign(List<string> users, List<string> roles)
        {
            Roles.Provider.RemoveUsersFromRoles(users.ToArray(), roles.ToArray());

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(new
                {
                    Success = true,
                    Users = users,
                    Roles = roles,
                });
            }
            throw new NotSupportedException();
        }
    }
}
