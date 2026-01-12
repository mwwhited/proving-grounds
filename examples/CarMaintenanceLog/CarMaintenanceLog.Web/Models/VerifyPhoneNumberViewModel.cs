using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class VerifyPhoneNumberViewModel
	{
		[Display(Name = "Code")]
		[Required]
		public string Code
		{
			get;
			set;
		}

		[Display(Name = "Phone Number")]
		[Phone]
		[Required]
		public string PhoneNumber
		{
			get;
			set;
		}

		public VerifyPhoneNumberViewModel()
		{
		}
	}
}