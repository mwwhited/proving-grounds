using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class LoginViewModel
	{
		[Display(Name = "Email")]
		[EmailAddress]
		[Required]
		public string Email
		{
			get;
			set;
		}

		[DataType(DataType.Password)]
		[Display(Name = "Password")]
		[Required]
		public string Password
		{
			get;
			set;
		}

		[Display(Name = "Remember me?")]
		public bool RememberMe
		{
			get;
			set;
		}

		public LoginViewModel()
		{
		}
	}
}