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
	public class ManageController : Controller
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

		public ManageController()
		{
		}

		public ManageController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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

		public ActionResult AddPhoneNumber()
		{
			return base.View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> AddPhoneNumber(AddPhoneNumberViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				string str = await this.UserManager.GenerateChangePhoneNumberTokenAsync(this.User.Identity.GetUserId(), model.Number);
				string str1 = str;
				if (this.UserManager.SmsService != null)
				{
					IdentityMessage identityMessage = new IdentityMessage()
					{
						Destination = model.Number,
						Body = string.Concat("Your security code is: ", str1)
					};
					await this.UserManager.SmsService.SendAsync(identityMessage);
				}
				action = this.RedirectToAction("VerifyPhoneNumber", new { PhoneNumber = model.Number });
			}
			else
			{
				action = this.View(model);
			}
			return action;
		}

		public ActionResult ChangePassword()
		{
			return base.View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> ChangePassword(ChangePasswordViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				IdentityResult identityResult = await this.UserManager.ChangePasswordAsync(this.User.Identity.GetUserId(), model.OldPassword, model.NewPassword);
				IdentityResult identityResult1 = identityResult;
				if (!identityResult1.Succeeded)
				{
					this.AddErrors(identityResult1);
					action = this.View(model);
				}
				else
				{
					ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
					ApplicationUser applicationUser1 = applicationUser;
					if (applicationUser1 != null)
					{
						await this.SignInManager.SignInAsync(applicationUser1, false, false);
					}
					action = this.RedirectToAction("Index", new { Message = ManageController.ManageMessageId.ChangePasswordSuccess });
				}
			}
			else
			{
				action = this.View(model);
			}
			return action;
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> DisableTwoFactorAuthentication()
		{
			await this.UserManager.SetTwoFactorEnabledAsync(this.User.Identity.GetUserId(), false);
			ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
			ApplicationUser applicationUser1 = applicationUser;
			if (applicationUser1 != null)
			{
				await this.SignInManager.SignInAsync(applicationUser1, false, false);
			}
			return this.RedirectToAction("Index", "Manage");
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && this._userManager != null)
			{
				this._userManager.Dispose();
				this._userManager = null;
			}
			base.Dispose(disposing);
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> EnableTwoFactorAuthentication()
		{
			await this.UserManager.SetTwoFactorEnabledAsync(this.User.Identity.GetUserId(), true);
			ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
			ApplicationUser applicationUser1 = applicationUser;
			if (applicationUser1 != null)
			{
				await this.SignInManager.SignInAsync(applicationUser1, false, false);
			}
			return this.RedirectToAction("Index", "Manage");
		}

		private bool HasPassword()
		{
			ApplicationUser applicationUser = this.UserManager.FindById<ApplicationUser, string>(base.User.Identity.GetUserId());
			if (applicationUser == null)
			{
				return false;
			}
			return applicationUser.PasswordHash != null;
		}

		private bool HasPhoneNumber()
		{
			ApplicationUser applicationUser = this.UserManager.FindById<ApplicationUser, string>(base.User.Identity.GetUserId());
			if (applicationUser == null)
			{
				return false;
			}
			return applicationUser.PhoneNumber != null;
		}

		public async Task<ActionResult> Index(ManageController.ManageMessageId? message)
		{
			bool flag;
			string str;
			bool flag1;
			bool flag2;
			bool flag3;
			bool flag4;
			bool flag5;
			dynamic viewBag = this.ViewBag;
			ManageController.ManageMessageId? nullable = message;
			flag = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.ChangePasswordSuccess ? nullable.HasValue : false);
			if (flag)
			{
				str = "Your password has been changed.";
			}
			else
			{
				nullable = message;
				flag1 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.SetPasswordSuccess ? nullable.HasValue : false);
				if (flag1)
				{
					str = "Your password has been set.";
				}
				else
				{
					nullable = message;
					flag2 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.SetTwoFactorSuccess ? nullable.HasValue : false);
					if (flag2)
					{
						str = "Your two-factor authentication provider has been set.";
					}
					else
					{
						nullable = message;
						flag3 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.Error ? nullable.HasValue : false);
						if (flag3)
						{
							str = "An error has occurred.";
						}
						else
						{
							nullable = message;
							flag4 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.AddPhoneSuccess ? nullable.HasValue : false);
							if (flag4)
							{
								str = "Your phone number was added.";
							}
							else
							{
								nullable = message;
								flag5 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.RemovePhoneSuccess ? nullable.HasValue : false);
								str = (flag5 ? "Your phone number was removed." : "");
							}
						}
					}
				}
			}
			viewBag.StatusMessage = str;
			string userId = this.User.Identity.GetUserId();
			IndexViewModel indexViewModel = new IndexViewModel()
			{
				HasPassword = this.HasPassword()
			};
			IndexViewModel phoneNumberAsync = indexViewModel;
			phoneNumberAsync.PhoneNumber = await this.UserManager.GetPhoneNumberAsync(userId);
			IndexViewModel twoFactorEnabledAsync = indexViewModel;
			twoFactorEnabledAsync.TwoFactor = await this.UserManager.GetTwoFactorEnabledAsync(userId);
			IndexViewModel loginsAsync = indexViewModel;
			loginsAsync.Logins = await this.UserManager.GetLoginsAsync(userId);
			IndexViewModel indexViewModel1 = indexViewModel;
			bool flag6 = await AuthenticationManagerExtensions.TwoFactorBrowserRememberedAsync(this.AuthenticationManager, userId);
			indexViewModel1.BrowserRemembered = flag6;
			IndexViewModel indexViewModel2 = indexViewModel;
			phoneNumberAsync = null;
			twoFactorEnabledAsync = null;
			loginsAsync = null;
			indexViewModel1 = null;
			indexViewModel = null;
			return this.View(indexViewModel2);
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult LinkLogin(string provider)
		{
			return new AccountController.ChallengeResult(provider, base.Url.Action("LinkLoginCallback", "Manage"), base.User.Identity.GetUserId());
		}

		public async Task<ActionResult> LinkLoginCallback()
		{
			ActionResult action;
			ActionResult actionResult;
			ExternalLoginInfo externalLoginInfoAsync = await AuthenticationManagerExtensions.GetExternalLoginInfoAsync(this.AuthenticationManager, "XsrfId", this.User.Identity.GetUserId());
			ExternalLoginInfo externalLoginInfo = externalLoginInfoAsync;
			if (externalLoginInfo != null)
			{
				IdentityResult identityResult = await this.UserManager.AddLoginAsync(this.User.Identity.GetUserId(), externalLoginInfo.Login);
				actionResult = (identityResult.Succeeded ? this.RedirectToAction("ManageLogins") : this.RedirectToAction("ManageLogins", new { Message = ManageController.ManageMessageId.Error }));
				action = actionResult;
			}
			else
			{
				action = this.RedirectToAction("ManageLogins", new { Message = ManageController.ManageMessageId.Error });
			}
			return action;
		}

		public async Task<ActionResult> ManageLogins(ManageController.ManageMessageId? message)
		{
			ActionResult actionResult;
			bool flag;
			string str;
			bool flag1;
			bool flag2;
			dynamic viewBag = this.ViewBag;
			ManageController.ManageMessageId? nullable = message;
			flag = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.RemoveLoginSuccess ? nullable.HasValue : false);
			if (flag)
			{
				str = "The external login was removed.";
			}
			else
			{
				nullable = message;
				flag2 = (nullable.GetValueOrDefault() == ManageController.ManageMessageId.Error ? nullable.HasValue : false);
				str = (flag2 ? "An error has occurred." : "");
			}
			viewBag.StatusMessage = str;
			ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
			ApplicationUser applicationUser1 = applicationUser;
			if (applicationUser1 != null)
			{
				IList<UserLoginInfo> loginsAsync = await this.UserManager.GetLoginsAsync(this.User.Identity.GetUserId());
				IList<UserLoginInfo> userLoginInfos = loginsAsync;
				List<AuthenticationDescription> list = (
					from auth in this.AuthenticationManager.GetExternalAuthenticationTypes()
					where userLoginInfos.All<UserLoginInfo>((UserLoginInfo ul) => auth.AuthenticationType != ul.LoginProvider)
					select auth).ToList<AuthenticationDescription>();
				dynamic obj = this.ViewBag;
				flag1 = (applicationUser1.PasswordHash != null ? true : userLoginInfos.Count > 1);
				obj.ShowRemoveButton = flag1;
				ManageController manageController = this;
				ManageLoginsViewModel manageLoginsViewModel = new ManageLoginsViewModel()
				{
					CurrentLogins = userLoginInfos,
					OtherLogins = list
				};
				actionResult = manageController.View(manageLoginsViewModel);
			}
			else
			{
				actionResult = this.View("Error");
			}
			return actionResult;
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> RemoveLogin(string loginProvider, string providerKey)
		{
			ManageController.ManageMessageId? nullable;
			IdentityResult identityResult = await this.UserManager.RemoveLoginAsync(this.User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
			if (!identityResult.Succeeded)
			{
				nullable = new ManageController.ManageMessageId?(ManageController.ManageMessageId.Error);
			}
			else
			{
				ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
				ApplicationUser applicationUser1 = applicationUser;
				if (applicationUser1 != null)
				{
					await this.SignInManager.SignInAsync(applicationUser1, false, false);
				}
				nullable = new ManageController.ManageMessageId?(ManageController.ManageMessageId.RemoveLoginSuccess);
			}
			ActionResult action = this.RedirectToAction("ManageLogins", new { Message = nullable });
			return action;
		}

		public async Task<ActionResult> RemovePhoneNumber()
		{
			ActionResult action;
			IdentityResult identityResult = await this.UserManager.SetPhoneNumberAsync(this.User.Identity.GetUserId(), null);
			if (identityResult.Succeeded)
			{
				ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
				ApplicationUser applicationUser1 = applicationUser;
				if (applicationUser1 != null)
				{
					await this.SignInManager.SignInAsync(applicationUser1, false, false);
				}
				action = this.RedirectToAction("Index", new { Message = ManageController.ManageMessageId.RemovePhoneSuccess });
			}
			else
			{
				action = this.RedirectToAction("Index", new { Message = ManageController.ManageMessageId.Error });
			}
			return action;
		}

		public ActionResult SetPassword()
		{
			return base.View();
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> SetPassword(SetPasswordViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				IdentityResult identityResult = await this.UserManager.AddPasswordAsync(this.User.Identity.GetUserId(), model.NewPassword);
				IdentityResult identityResult1 = identityResult;
				if (!identityResult1.Succeeded)
				{
					this.AddErrors(identityResult1);
					identityResult1 = null;
				}
				else
				{
					ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
					ApplicationUser applicationUser1 = applicationUser;
					if (applicationUser1 != null)
					{
						await this.SignInManager.SignInAsync(applicationUser1, false, false);
					}
					action = this.RedirectToAction("Index", new { Message = ManageController.ManageMessageId.SetPasswordSuccess });
					return action;
				}
			}
			action = this.View(model);
			return action;
		}

		public async Task<ActionResult> VerifyPhoneNumber(string phoneNumber)
		{
			ActionResult actionResult;
			string str = await this.UserManager.GenerateChangePhoneNumberTokenAsync(this.User.Identity.GetUserId(), phoneNumber);
			if (phoneNumber == null)
			{
				actionResult = this.View("Error");
			}
			else
			{
				ManageController manageController = this;
				VerifyPhoneNumberViewModel verifyPhoneNumberViewModel = new VerifyPhoneNumberViewModel()
				{
					PhoneNumber = phoneNumber
				};
				actionResult = manageController.View(verifyPhoneNumberViewModel);
			}
			return actionResult;
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<ActionResult> VerifyPhoneNumber(VerifyPhoneNumberViewModel model)
		{
			ActionResult action;
			if (this.ModelState.IsValid)
			{
				IdentityResult identityResult = await this.UserManager.ChangePhoneNumberAsync(this.User.Identity.GetUserId(), model.PhoneNumber, model.Code);
				if (!identityResult.Succeeded)
				{
					this.ModelState.AddModelError("", "Failed to verify phone");
					action = this.View(model);
				}
				else
				{
					ApplicationUser applicationUser = await this.UserManager.FindByIdAsync(this.User.Identity.GetUserId());
					ApplicationUser applicationUser1 = applicationUser;
					if (applicationUser1 != null)
					{
						await this.SignInManager.SignInAsync(applicationUser1, false, false);
					}
					action = this.RedirectToAction("Index", new { Message = ManageController.ManageMessageId.AddPhoneSuccess });
				}
			}
			else
			{
				action = this.View(model);
			}
			return action;
		}

		public enum ManageMessageId
		{
			AddPhoneSuccess,
			ChangePasswordSuccess,
			SetTwoFactorSuccess,
			SetPasswordSuccess,
			RemoveLoginSuccess,
			RemovePhoneSuccess,
			Error
		}
	}
}