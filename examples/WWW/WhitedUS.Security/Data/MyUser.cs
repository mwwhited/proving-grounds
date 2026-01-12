using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security.Data
{
    public partial class MyUser
    {
        partial void OnCreated()
        {
            UniqueID = Guid.NewGuid();
            DateCreated = DateTime.UtcNow;
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnChangePasswordAnswerHashChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnChangePasswordQuestionChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnCommentChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnEmailAddressChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnIsDisabledChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }

        partial void OnIsLockedChanged()
        {
            DateLastActivity = DateTime.UtcNow;
            if (IsLocked)
                DateLastLocked = DateTime.UtcNow;
        }

        partial void OnPasswordHashChanged()
        {
            DateLastActivity = DateTime.UtcNow;
            DateLastPasswordChange = DateTime.UtcNow;
        }

        partial void OnUserNameChanged()
        {
            DateLastActivity = DateTime.UtcNow;
        }
    }
}
