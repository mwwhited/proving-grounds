using CarMaintenanceLog.Web;
using CarMaintenanceLog.Web.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.CSharp.RuntimeBinder;
using Microsoft.Owin;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Principal;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace CarMaintenanceLog.Web.Controllers
{
	[Authorize]
	public class AccountController : Controller
	{
		private ApplicationSignInManager _signInManager;

		private ApplicationUserManager _userManager;

		private const string XsrfKey = "XsrfId";

		private IAuthenticationManager AuthenticationManager
		{
			get
			{
				return base.HttpContext.GetOwinContext().Authentication;
			}
		}

		public ApplicationSignInManager SignInManager
		{
			get
			{
				return this._signInManager ?? base.HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
			}
			private set
			{
				this._signInManager = value;
			}
		}

		public ApplicationUserManager UserManager
		{
			get
			{
				return this._userManager ?? base.HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
			}
			private set
			{
				this._userManager = value;
			}
		}

		public AccountController()
		{
		}

		public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
		{
			this.UserManager = userManager;
			this.SignInManager = signInManager;
		}

		private void AddErrors(IdentityResult result)
		{
			foreach (string error in result.Errors)
			{
				base.ModelState.AddModelError("", error);
			}
		}

		[AllowAnonymous]
		public async Task<ActionResult> ConfirmEmail(string userId, string code)
		{
			ActionResult actionResult;
			string str;
			if (userId == null || code == null)
			{
				actionResult = this.View("Error");
			}
			else
			{
				IdentityResult identityResult = await this.UserManager.ConfirmEmailAsync(userId, code);
				AccountController accountController = this;
				str = (identityResult.Succeeded ? "ConfirmEmail" : "Error");
				actionResult = accountController.View(str);
			}
			return actionResult;
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				if (this._userManager != null)
				{
					this._userManager.Dispose();
					this._userManager = null;
				}
				if (this._signInManager != null)
				{
					this._signInManager.Dispose();
					this._signInManager = null;
				}
			}
			base.Dispose(disposing);
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult ExternalLogin(string provider, string returnUrl)
		{
			return new AccountController.ChallengeResult(provider, base.Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
		}

		[AllowAnonymous]
		public async Task<ActionResult> ExternalLoginCallback(string returnUrl)
		{
			ActionResult local;
			ExternalLoginInfo externalLoginInfoAsync = await AuthenticationManagerExtensions.GetExternalLoginInfoAsync(this.AuthenticationManager);
			if (externalLoginInfoAsync != null)
			{
				switch (await this.SignInManager.ExternalSignInAsync(externalLoginInfoAsync, false))
				{
					case SignInStatus.Success:
						{
							local = this.RedirectToLocal(returnUrl);
							break;
						}
					case SignInStatus.LockedOut:
						{
							local = this.View("Lockout");
							break;
						}
					case SignInStatus.RequiresVerification:
						{
							local = this.RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = false });
							break;
						}
					default:
					case SignInStatus.Failure:
						{
							((dynamic)this.ViewBag).ReturnUrl = returnUrl;
							((dynamic)this.ViewBag).LoginProvider = externalLoginInfoAsync.Login.LoginProvider;
							AccountController accountController = this;
							ExternalLoginConfirmationViewModel externalLoginConfirmationViewModel = new ExternalLoginConfirmationViewModel()
							{
								Email = externalLoginInfoAsync.Email
							};
							local = accountController.View("ExternalLoginConfirmation", externalLoginConfirmationViewModel);
							break;
						}
				}
			}
			else
			{
				local = this.RedirectToAction("Login");
			}
			return local;
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl)
		{
			ActionResult local;
			if (!this.User.Identity.IsAuthenticated)
			{
				if (this.ModelState.IsValid)
				{
					ExternalLoginInfo externalLoginInfoAsync = await AuthenticationManagerExtensions.GetExternalLoginInfoAsync(this.AuthenticationManager);
					if (externalLoginInfoAsync != null)
					{
						ApplicationUser applicationUser = new ApplicationUser()
						{
							UserName = model.Email,
							Email = model.Email
						};
						ApplicationUser applicationUser1 = applicationUser;
						IdentityResult identityResult = await this.UserManager.CreateAsync(applicationUser1);
						if (identityResult.Succeeded)
						{
							IdentityResult identityResult1 = await this.UserManager.AddLoginAsync(applicationUser1.Id, externalLoginInfoAsync.Login);
							identityResult = identityResult1;
							if (identityResult.Succeeded)
							{
								await this.SignInManager.SignInAsync(applicationUser1, false, false);
								local = this.RedirectToLocal(returnUrl);
								return local;
							}
						}
						this.AddErrors(identityResult);
						externalLoginInfoAsync = null;
						applicationUser1 = null;
						identityResult = null;
					}
					else
					{
						local = this.View("ExternalLoginFailure");
						return local;
					}
				}
				((dynamic)this.ViewBag).ReturnUrl = returnUrl;
				local = this.View(model);
			}
			else
			{
				local = this.RedirectToAction("Index", "Manage");
			}
			return local;
		}

		[AllowAnonymous]
		public ActionResult ExternalLoginFailure()
		{
			return base.View();
		}

		[AllowAnonymous]
		public ActionResult ForgotPassword()
		{
			return base.View();
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
		{
			ActionResult actionResult;
			if (this.ModelState.IsValid)
			{
				ApplicationUser applicationUser = await this.UserManager.FindByNameAsync(model.Email);
				bool flag = applicationUser == null;
				if (!flag)
				{
					bool flag1 = await this.UserManager.IsEmailConfirmedAsync(applicationUser.Id);
					flag = !flag1;
				}
				if (flag)
				{
					actionResult = this.View("ForgotPasswordConfirmation");
					return actionResult;
				}
			}
			actionResult = this.View(model);
			return actionResult;
		}

		[AllowAnonymous]
		public ActionResult ForgotPasswordConfirmation()
		{
			return base.View();
		}

		[AllowAnonymous]
		public ActionResult Login(string returnUrl)
		{
			((dynamic)base.ViewBag).ReturnUrl = returnUrl;
			return base.View();
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
		{
			ActionResult local;
			if (this.ModelState.IsValid)
			{
				SignInStatus signInStatu = await this.SignInManager.PasswordSignInAsync(model.Email, model.Password, model.RememberMe, false);
				switch (signInStatu)
				{
					case SignInStatus.Success:
						{
							local = this.RedirectToLocal(returnUrl);
							break;
						}
					case SignInStatus.LockedOut:
						{
							local = this.View("Lockout");
							break;
						}
					case SignInStatus.RequiresVerification:
						{
							local = this.RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = model.RememberMe });
							break;
						}
					case SignInStatus.Failure:
						{
							this.ModelState.AddModelError("", "Invalid login attempt.");
							local = this.View(model);
							break;
						}
					default:
						{
							goto case SignInStatus.Failure;
						}
				}
			}
			else
			{
				local = this.View(model);
			}
			return local;
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult LogOff()
		{
			this.AuthenticationManager.SignOut(new string[] { "ApplicationCookie" });
			return base.RedirectToAction("Index", "Home");
		}

		private ActionResult RedirectToLocal(string returnUrl)
		{
			if (base.Url.IsLocalUrl(returnUrl))
			{
				return this.Redirect(returnUrl);
			}
			return base.RedirectToAction("Index", "Home");
		}

		[AllowAnonymous]
		public ActionResult Register()
		{
			return base.View();
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> Register(RegisterViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				ApplicationUser applicationUser = new ApplicationUser()
				{
					UserName = model.Email,
					Email = model.Email
				};
				ApplicationUser applicationUser1 = applicationUser;
				IdentityResult identityResult = await this.UserManager.CreateAsync(applicationUser1, model.Password);
				IdentityResult identityResult1 = identityResult;
				if (!identityResult1.Succeeded)
				{
					this.AddErrors(identityResult1);
					applicationUser1 = null;
					identityResult1 = null;
				}
				else
				{
					await this.SignInManager.SignInAsync(applicationUser1, false, false);
					action = this.RedirectToAction("Index", "Home");
					return action;
				}
			}
			action = this.View(model);
			return action;
		}

		[AllowAnonymous]
		public ActionResult ResetPassword(string code)
		{
			if (code != null)
			{
				return base.View();
			}
			return base.View("Error");
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				ApplicationUser applicationUser = await this.UserManager.FindByNameAsync(model.Email);
				if (applicationUser != null)
				{
					IdentityResult identityResult = await this.UserManager.ResetPasswordAsync(applicationUser.Id, model.Code, model.Password);
					IdentityResult identityResult1 = identityResult;
					if (!identityResult1.Succeeded)
					{
						this.AddErrors(identityResult1);
						action = this.View();
					}
					else
					{
						action = this.RedirectToAction("ResetPasswordConfirmation", "Account");
					}
				}
				else
				{
					action = this.RedirectToAction("ResetPasswordConfirmation", "Account");
				}
			}
			else
			{
				action = this.View(model);
			}
			return action;
		}

		[AllowAnonymous]
		public ActionResult ResetPasswordConfirmation()
		{
			return base.View();
		}

		[AllowAnonymous]
		public async Task<ActionResult> SendCode(string returnUrl, bool rememberMe)
		{
			ActionResult actionResult;
			string verifiedUserIdAsync = await this.SignInManager.GetVerifiedUserIdAsync();
			if (verifiedUserIdAsync != null)
			{
				IList<string> validTwoFactorProvidersAsync = await this.UserManager.GetValidTwoFactorProvidersAsync(verifiedUserIdAsync);
				List<SelectListItem> list = (
					from purpose in validTwoFactorProvidersAsync
					select new SelectListItem()
					{
						Text = purpose,
						Value = purpose
					}).ToList<SelectListItem>();
				AccountController accountController = this;
				SendCodeViewModel sendCodeViewModel = new SendCodeViewModel()
				{
					Providers = list,
					ReturnUrl = returnUrl,
					RememberMe = rememberMe
				};
				actionResult = accountController.View(sendCodeViewModel);
			}
			else
			{
				actionResult = this.View("Error");
			}
			return actionResult;
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> SendCode(SendCodeViewModel model)
		{
			ActionResult action;
			if (!this.ModelState.IsValid)
			{
				action = this.View();
			}
			else if (await this.SignInManager.SendTwoFactorCodeAsync(model.SelectedProvider))
			{
				action = this.RedirectToAction("VerifyCode", new { Provider = model.SelectedProvider, ReturnUrl = model.ReturnUrl, RememberMe = model.RememberMe });
			}
			else
			{
				action = this.View("Error");
			}
			return action;
		}

		[AllowAnonymous]
		public async Task<ActionResult> VerifyCode(string provider, string returnUrl, bool rememberMe)
		{
			ActionResult actionResult;
			if (await this.SignInManager.HasBeenVerifiedAsync())
			{
				AccountController accountController = this;
				VerifyCodeViewModel verifyCodeViewModel = new VerifyCodeViewModel()
				{
					Provider = provider,
					ReturnUrl = returnUrl,
					RememberMe = rememberMe
				};
				actionResult = accountController.View(verifyCodeViewModel);
			}
			else
			{
				actionResult = this.View("Error");
			}
			return actionResult;
		}

		[AllowAnonymous]
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> VerifyCode(VerifyCodeViewModel model)
		{
			ActionResult local;
			if (this.ModelState.IsValid)
			{
				SignInStatus signInStatu = await this.SignInManager.TwoFactorSignInAsync(model.Provider, model.Code, model.RememberMe, model.RememberBrowser);
				switch (signInStatu)
				{
					case SignInStatus.Success:
						{
							local = this.RedirectToLocal(model.ReturnUrl);
							break;
						}
					case SignInStatus.LockedOut:
						{
							local = this.View("Lockout");
							break;
						}
					case SignInStatus.RequiresVerification:
					case SignInStatus.Failure:
						{
							this.ModelState.AddModelError("", "Invalid code.");
							local = this.View(model);
							break;
						}
					default:
						{
							goto case SignInStatus.Failure;
						}
				}
			}
			else
			{
				local = this.View(model);
			}
			return local;
		}

		internal class ChallengeResult : HttpUnauthorizedResult
		{
			public string LoginProvider
			{
				get;
				set;
			}

			public string RedirectUri
			{
				get;
				set;
			}

			public string UserId
			{
				get;
				set;
			}

			public ChallengeResult(string provider, string redirectUri) : this(provider, redirectUri, null)
			{
			}

			public ChallengeResult(string provider, string redirectUri, string userId)
			{
				this.LoginProvider = provider;
				this.RedirectUri = redirectUri;
				this.UserId = userId;
			}

			public override void ExecuteResult(System.Web.Mvc.ControllerContext context)
			{
				AuthenticationProperties authenticationProperty = new AuthenticationProperties()
				{
					RedirectUri = this.RedirectUri
				};
				if (this.UserId != null)
				{
					authenticationProperty.Dictionary["XsrfId"] = this.UserId;
				}
				context.HttpContext.GetOwinContext().Authentication.Challenge(authenticationProperty, new string[] { this.LoginProvider });
			}
		}
	}
}