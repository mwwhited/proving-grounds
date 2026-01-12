using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class IndexViewModel
	{
		public bool BrowserRemembered
		{
			get;
			set;
		}

		public bool HasPassword
		{
			get;
			set;
		}

		public IList<UserLoginInfo> Logins
		{
			get;
			set;
		}

		public string PhoneNumber
		{
			get;
			set;
		}

		public bool TwoFactor
		{
			get;
			set;
		}

		public IndexViewModel()
		{
		}
	}
}