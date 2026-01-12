using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class ExternalLoginConfirmationViewModel
	{
		[Display(Name = "Email")]
		[Required]
		public string Email
		{
			get;
			set;
		}

		public ExternalLoginConfirmationViewModel()
		{
		}
	}
}