using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Web.Mvc;

namespace CarMaintenanceLog.Web.Models
{
	public class ConfigureTwoFactorViewModel
	{
		public ICollection<SelectListItem> Providers
		{
			get;
			set;
		}

		public string SelectedProvider
		{
			get;
			set;
		}

		public ConfigureTwoFactorViewModel()
		{
		}
	}
}