using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Security
{
    public static class PasswordTools
    {
        public static readonly string PasswordCharacters = 
            "ABCDEFGHJKMNOPQRSTUVWXYZ" +
            "abcdefghjkmnopqrstuvwxyz" +
            "23456789";

        public static string GeneratePassword(int passwordLength)
        {
            var random = new Random();
            return new string(Enumerable.Range(0, passwordLength)
                                        .Select(i => PasswordCharacters[random.Next(PasswordCharacters.Length)])
                                        .ToArray());
        }
    }
}
