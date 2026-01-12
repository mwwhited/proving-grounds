using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class AddPhoneNumberViewModel
	{
		[Display(Name = "Phone Number")]
		[Phone]
		[Required]
		public string Number
		{
			get;
			set;
		}

		public AddPhoneNumberViewModel()
		{
		}
	}
}