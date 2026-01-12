using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace WhitedUS.Shared.Models.Security
{
    public class ApplicationModel
    {
        [StringLength(200)]
        public string Name { get; set; }
        public string Description { get; set; }

        public bool EnablePasswordReset { get; set; }
        public int MaxInvalidPasswordAttempts { get; set; }
        public int MinRequiredNonAlphanumericCharacters { get; set; }
        public int MinRequiredPasswordLength { get; set; }
        public int PasswordAttemptWindow { get; set; }
        public string PasswordStrengthRegularExpression { get; set; }
        public bool RequiresQuestionAndAnswer { get; set; }
        public bool RequiresUniqueEmail { get; set; }

        public DateTime InvalidPasswordWindow { get; set; }
    }
}
