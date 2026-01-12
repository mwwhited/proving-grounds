using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class ChangePasswordViewModel
	{
		[Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
		[DataType(DataType.Password)]
		[Display(Name = "Confirm new password")]
		public string ConfirmPassword
		{
			get;
			set;
		}

		[DataType(DataType.Password)]
		[Display(Name = "New password")]
		[Required]
		[StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
		public string NewPassword
		{
			get;
			set;
		}

		[DataType(DataType.Password)]
		[Display(Name = "Current password")]
		[Required]
		public string OldPassword
		{
			get;
			set;
		}

		public ChangePasswordViewModel()
		{
		}
	}
}