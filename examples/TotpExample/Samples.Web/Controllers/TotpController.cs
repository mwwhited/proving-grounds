using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Samples.Libs;
using Samples.Web.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Samples.Web.Controllers
{
    // http://channel9.msdn.com/series/Building-Modern-Web-Apps/03 
    // http://www.asp.net/identity/overview/migrations/migrating-an-existing-website-from-sql-membership-to-aspnet-identity

    // http://beabigrockstar.com/blog/using-google-authenticator-asp-net-identity

    public class TotpController : Controller
    {

        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get { return _userManager ?? (_userManager = this.HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>()); }
            private set { _userManager = value; }
        }

        [Authorize]
        public ActionResult Index()
        {
            var user = this.UserManager.FindById(this.User.Identity.GetUserId());
            if (user == null)
            {
                return this.HttpNotFound("User Not Found!");
            }

            var model = new TotpEnabledModel
            {
                IsEnabled = user.TotpEnabled,
            };

            return this.PartialView(model);
        }

        [Authorize]
        public async Task<ActionResult> Register()
        {
            var user = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
            if (user == null)
            {
                return this.HttpNotFound("User Not Found!");
            }

            if (user.TotpEnabled)
            {
                this.ModelState.AddModelError("TotpEnabled", "TOTP Already Enabled/Registered for User.  Must Disable First");
                return this.RedirectToAction("Index");
            }

            var otp = new OneTimeCode();
            var secret = otp.GenerateSecret();
            var url = otp.GetUri(secret: secret, issuer: "TestSite", account: user.UserName);

            user.TotpSecret = secret;
            var result = await this.UserManager.UpdateAsync(user);
            if (!result.Succeeded)
            {
                foreach (var error in result.Errors)
                {
                    this.ModelState.AddModelError("UserUpdateError", error);
                }

                return View(new TotpShareModel { });
            }

            return View(new TotpShareModel
            {
                Secret = secret,
                Uri = url,
            });
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult> Register(string token)
        {
            if (!this.ModelState.IsValid)
            {
                return this.RedirectToAction("Index");
            }
            var user = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
            if (user == null)
            {
                return this.HttpNotFound("User Not Found!");
            }

            var otp = new OneTimeCode();
            var secret = !string.IsNullOrWhiteSpace(user.TotpSecret) ? user.TotpSecret : otp.GenerateSecret();

            var isValid = otp.IsValid(secret, token);
            if (isValid)
            {
                user.TotpEnabled = true;

                var result = await this.UserManager.UpdateAsync(user);
                if (!result.Succeeded)
                {
                    foreach (var error in result.Errors)
                    {
                        this.ModelState.AddModelError("UserUpdateError", error);
                    }

                    return this.View(new TotpShareModel { });
                }

                return this.RedirectToAction("", "Manage");
            }

            this.ModelState.AddModelError("token", "Invalid Token, Try Again.");

            var url = otp.GetUri(secret: secret, issuer: "TestSite", account: user.UserName);

            if (user.TotpSecret != secret)
            {
                user.TotpSecret = secret;
                var result = await this.UserManager.UpdateAsync(user);
                if (!result.Succeeded)
                {
                    foreach (var error in result.Errors)
                    {
                        this.ModelState.AddModelError("UserUpdateError", error);
                    }

                    return View(new TotpShareModel { });
                }
            }

            return View(new TotpShareModel
            {
                Secret = secret,
                Uri = url,
            });
        }

        [Authorize]
        public async Task<ActionResult> Unregister()
        {
            var user = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
            if (user == null)
            {
                return this.HttpNotFound("User Not Found!");
            }

            user.TotpEnabled = false;
            user.TotpSecret = null;

            var result = await this.UserManager.UpdateAsync(user);
            if (!result.Succeeded)
            {
                foreach (var error in result.Errors)
                {
                    this.ModelState.AddModelError("UserUpdateError", error);
                }
            }

            return this.RedirectToAction("", "Manage");
        }

        public ActionResult Qr(string url)
        {
            var encoder = new QrEncoder();
            var qrCode = encoder.Encode(url ?? "about:blank");
            using (var ms = new MemoryStream())
            {
                var render = new GraphicsRenderer(new FixedModuleSize(4, QuietZoneModules.Two));
                render.WriteToStream(qrCode.Matrix, ImageFormat.Png, ms);

                return this.File(ms.ToArray(), "image/png");
            }
        }

        public ActionResult Recover()
        {
            var otc = new OneTimeCode();
            var codes = new[] {
            new {issuer="", account="", secret="", type="TOTP"},
            };

            var q = from c in codes
                    where c.type == "TOTP"
                    select new KeyValuePair<string, string>(string.Format("{0} ({1})", c.issuer, c.account), otc.GetUri(c.secret, c.issuer, c.account));

            return this.View(q.ToList());

        }
    }

    public class TotpTokenProvider : IUserTokenProvider<ApplicationUser, string>
    {

        public Task<string> GenerateAsync(string purpose, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult<string>(null);
        }
        public Task NotifyAsync(string token, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult(false);
        }

        public Task<bool> IsValidProviderForUserAsync(UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult(user.TotpEnabled);
        }
        public Task<bool> ValidateAsync(string purpose, string token, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            if (!user.TotpEnabled)
                return Task.FromResult(true);

            var otp = new OneTimeCode();
            var isValid = otp.IsValid(user.TotpSecret, token, 3);

            return Task.FromResult(isValid);
        }
    }
}