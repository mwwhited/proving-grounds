using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Security.Configuration;

//WhitedUS.Security.MyPasswordGenerator,WhitedUS.Security
namespace WhitedUS.Security
{
    public class MyPasswordGenerator
    {
        private static Random _rand = new Random((int)DateTime.UtcNow.Ticks);
        private static object _randLock = new object();

        internal static readonly char[] NonAlphanumericCharacters = "`-=~!@#$%^&*()_+[]\\{}|;':\",./<>?".ToCharArray();
        internal static readonly char[] PasswordCharacters = "`1234567890-=~!@#$%^&*()_+[]\\{}|;':\",./<>?qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM".ToCharArray();

        public static string GeneratePassword()
        {
            int minRequiredNonAlphanumericCharacters = MyMembershipProviderConfiguration.CurrentConfig.MinRequiredNonAlphanumericCharacters;
            int minRequiredPasswordLength = MyMembershipProviderConfiguration.CurrentConfig.MinRequiredPasswordLength;
            char[] password = new char[Math.Max(Math.Max(minRequiredNonAlphanumericCharacters, minRequiredPasswordLength), 5)];
            int lastPos = 0;
            lock (_randLock)
            {
                for (; lastPos < Math.Max(1, minRequiredNonAlphanumericCharacters); lastPos++)
                    password[lastPos] = NonAlphanumericCharacters[_rand.Next(NonAlphanumericCharacters.Length)];
                for (; lastPos < password.Length; lastPos++)
                    password[lastPos] = PasswordCharacters[_rand.Next(PasswordCharacters.Length)];
            }
            return new string(password);
        }
    }
}
