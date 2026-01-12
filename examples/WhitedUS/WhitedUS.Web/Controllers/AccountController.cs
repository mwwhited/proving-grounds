using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using DotNetOpenAuth.Messaging;
using DotNetOpenAuth.OpenId;
using DotNetOpenAuth.OpenId.Extensions.SimpleRegistration;
using DotNetOpenAuth.OpenId.RelyingParty;
using WhitedUS.Web.Models;
using WhitedUS.Web.Security;

namespace WhitedUS.Web.Controllers
{
    public class AccountController : Controller
    {
        private AuthClaimService AuthClaimService { get; set; }

        public AccountController()
        {
            this.AuthClaimService = new AuthClaimService();
        }

        //
        // GET: /Account/LogOn
        public ActionResult LogOn()
        {
            return View();
        }

        //
        // POST: /Account/LogOn
        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (Membership.ValidateUser(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);
                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                        && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }
            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/LogOff
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Register
        public ActionResult Register()
        {
            bool useOpenID = false;

            var claim = this.TempData["OpenID_Claim"] as Identifier;
            if (claim != null)
            {
                useOpenID = true;
            }
            else
            {
                var openid = new OpenIdRelyingParty();
                var response = openid.GetResponse();
                useOpenID = response != null;
                if (useOpenID)
                {
                    claim = response.ClaimedIdentifier;
                }
            }

            if (useOpenID)
            {
                this.ViewBag.OpenIDClaim = claim.ToString();
            }

            this.ViewBag.UseOpenID = useOpenID;
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        public ActionResult Register(RegisterModel model, string loginClaim)
        {
            bool useOpenID = false;

            var claim = this.TempData["OpenID_Claim"] as Identifier;
            if (claim != null)
            {
                useOpenID = true;
            }
            else
            {
                var openid = new OpenIdRelyingParty();
                var response = openid.GetResponse();
                useOpenID = response != null;
                if (useOpenID)
                {
                    claim = response.ClaimedIdentifier;
                }
            }

            if (ModelState.IsValid)
            {
                if (useOpenID)
                    model.Password = Guid.NewGuid().ToString();

                // Attempt to register the user
                MembershipCreateStatus createStatus;
                var user = Membership.CreateUser(model.UserName, model.Password, model.Email, null, null, true, null, out createStatus);

                if (createStatus == MembershipCreateStatus.Success)
                {
                    if (useOpenID)
                        this.AuthClaimService.AddClaimForUserID((Guid)user.ProviderUserKey, (string)claim);

                    FormsAuthentication.SetAuthCookie(model.UserName, false /* createPersistentCookie */);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", ErrorCodeToString(createStatus));
                }
            }

            if (useOpenID)
            {
                this.ViewBag.OpenIDClaim = claim.ToString();
            }
            // If we got this far, something failed, redisplay form
            this.ViewBag.UseOpenID = useOpenID;
            return View(model);
        }

        //
        // GET: /Account/ChangePassword
        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        //
        // POST: /Account/ChangePassword
        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {

                // ChangePassword will throw an exception rather
                // than return false in certain failure scenarios.
                bool changePasswordSucceeded;
                try
                {
                    MembershipUser currentUser = Membership.GetUser(User.Identity.Name, true /* userIsOnline */);
                    changePasswordSucceeded = currentUser.ChangePassword(model.OldPassword, model.NewPassword);
                }
                catch (Exception)
                {
                    changePasswordSucceeded = false;
                }

                if (changePasswordSucceeded)
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePasswordSuccess
        public ActionResult ChangePasswordSuccess()
        {
            return View();
        }

        #region Status Codes
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion

        public ActionResult OpenIDLogin()
        {
            var openid = new OpenIdRelyingParty();
            var response = openid.GetResponse();
            if (response != null)
            {
                switch (response.Status)
                {
                    case AuthenticationStatus.Authenticated:

                        var userid = this.AuthClaimService.GetUserIDForClaim(response.ClaimedIdentifier);
                        if (userid == Guid.Empty)
                        {
                            this.TempData.Add("OpenID_Claim", response.ClaimedIdentifier);
                            return this.RedirectToAction("Register");
                        }
                        else
                        {
                            //Note: Login user
                            var user = Membership.GetUser((object)userid);
                            FormsAuthentication.SetAuthCookie(user.UserName, false);
                            return this.RedirectToAction("Index", "Home", new { Area = "" });
                        }

                        break;

                    case AuthenticationStatus.Canceled:
                        this.ModelState.AddModelError(
                            "loginIdentifier",
                            "Login was cancelled at the provider"
                            );
                        break;

                    case AuthenticationStatus.Failed:
                        ModelState.AddModelError(
                            "loginIdentifier",
                            "Login failed using the provided OpenID identifier"
                            );
                        break;

                    case AuthenticationStatus.ExtensionsOnly:
                    case AuthenticationStatus.SetupRequired:
                    default:
                        break;
                }
            }


            return View();
        }

        [HttpPost]
        public ActionResult OpenIDLogin(string loginIdentifier)
        {
            if (!Identifier.IsValid(loginIdentifier))
            {
                this.ModelState.AddModelError(
                    "loginIdentifier",
                    "The specified login identifier is invalid");
                return View();
            }
            else
            {
                var openid = new OpenIdRelyingParty();
                var request = openid.CreateRequest(
                    Identifier.Parse(loginIdentifier)
                    );
                // Require some additional data    
                request.AddExtension(new ClaimsRequest
                {
                    BirthDate = DemandLevel.NoRequest,
                    Email = DemandLevel.Require,
                    FullName = DemandLevel.Require
                });
                return request.RedirectingResponse.AsActionResult();
            }
        }

        [Authorize]
        public ActionResult OpenIDClaims()
        {
            var user = Membership.GetUser();
            var query = this.AuthClaimService.ListAuthClaims((Guid)user.ProviderUserKey);
            return this.View(query);
        }
    }
}
