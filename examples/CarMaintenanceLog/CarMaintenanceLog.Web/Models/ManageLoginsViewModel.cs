using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Models
{
	public class ManageLoginsViewModel
	{
		public IList<UserLoginInfo> CurrentLogins
		{
			get;
			set;
		}

		public IList<AuthenticationDescription> OtherLogins
		{
			get;
			set;
		}

		public ManageLoginsViewModel()
		{
		}
	}
}