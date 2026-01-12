using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class ForgotViewModel
	{
		[Display(Name = "Email")]
		[Required]
		public string Email
		{
			get;
			set;
		}

		public ForgotViewModel()
		{
		}
	}
}