using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WhitedUS.Web.Areas.Administration.Models
{
    public class UserModel : UserSimpleModel
    {
        [DisplayName("User ID")]
        public Guid UserID { get; set; }
        [DisplayName("Is Locked out")]
        public bool IsLockedOut { get; set; }
        [DisplayName("Is Online")]
        public bool IsOnline { get; set; }
        [DisplayName("Last Activity Date")]
        public DateTime LastActivityDate { get; set; }
        [DisplayName("Last Lockout Date")]
        public DateTime LastLockoutDate { get; set; }
        [DisplayName("Last Login Date")]
        public DateTime LastLoginDate { get; set; }
        [DisplayName("Last Password Changed Date")]
        public DateTime LastPasswordChangedDate { get; set; }
        [DisplayName("Creation Date")]
        public DateTime CreationDate { get; set; }
    }
}