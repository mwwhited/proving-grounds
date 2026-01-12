using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class ForgotPasswordViewModel
	{
		[Display(Name = "Email")]
		[EmailAddress]
		[Required]
		public string Email
		{
			get;
			set;
		}

		public ForgotPasswordViewModel()
		{
		}
	}
}