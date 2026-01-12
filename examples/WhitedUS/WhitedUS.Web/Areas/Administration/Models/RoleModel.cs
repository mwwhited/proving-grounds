using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WhitedUS.Web.Areas.Administration.Models
{
    public class RoleModel
    {
        [Required]
        [StringLength(128, MinimumLength = 1)]
        public string RoleName { get; set; }
    }
}