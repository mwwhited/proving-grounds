using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WhitedUS.Web.Areas.Administration.Models
{
    public class UserSimpleModel
    {
        [Required]
        [DisplayName("User Name")]
        public string UserName { get; set; }
        public string Comment { get; set; }
        [Required]
        public string Email { get; set; }

        [DisplayName("Is Approved")]
        public bool IsApproved { get; set; }        
    }
}