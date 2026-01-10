using Microsoft.AspNet.Identity;
using OobDev.Common.Security.Cryptography;
using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.AspNet.Identity
{
    public class TotpTokenProvider<TUser> : TotpTokenProvider<TUser, string>
        where TUser : class, IUser<string>
    {
        public TotpTokenProvider(
                Func<TUser, Task<bool>> getTotpSecretConfirmed,
                Func<TUser, bool, Task> setTotpSecretConfirmed,
                Func<TUser, Task<string>> getTotpSecret,
                Func<TUser, string, Task> setTotpSecret,
                Func<TUser, Task<bool>> getTwoFactorEnabled,
                int checkIntervals = 10
            )
            : base(
                getTotpSecretConfirmed,
                setTotpSecretConfirmed,
                getTotpSecret,
                setTotpSecret,
                getTwoFactorEnabled
            )
        {
            Contract.Requires(getTotpSecretConfirmed != null);
            Contract.Requires(setTotpSecretConfirmed != null);
            Contract.Requires(getTotpSecret != null);
            Contract.Requires(setTotpSecret != null);
            Contract.Requires(getTwoFactorEnabled != null);
        }
    }
    public class TotpTokenProvider<TUser, TKey> : IUserTokenProvider<TUser, TKey>
        where TUser : class, IUser<TKey>
        where TKey : IEquatable<TKey>
    {
        public int CheckIntervals { get; private set; }
        public Func<TUser, Task<bool>> GetTotpSecretConfirmed { get; private set; }
        public Func<TUser, bool, Task> SetTotpSecretConfirmed { get; private set; }
        public Func<TUser, Task<string>> GetTotpSecret { get; private set; }
        public Func<TUser, string, Task> SetTotpSecret { get; private set; }
        public Func<TUser, Task<bool>> GetTwoFactorEnabled { get; private set; }

        public TotpTokenProvider(
                Func<TUser, Task<bool>> getTotpSecretConfirmed,
                Func<TUser, bool, Task> setTotpSecretConfirmed,
                Func<TUser, Task<string>> getTotpSecret,
                Func<TUser, string, Task> setTotpSecret,
                Func<TUser, Task<bool>> getTwoFactorEnabled,
                int checkIntervals = 10
            )
        {
            Contract.Requires(getTotpSecretConfirmed != null);
            Contract.Requires(setTotpSecretConfirmed != null);
            Contract.Requires(getTotpSecret != null);
            Contract.Requires(setTotpSecret != null);
            Contract.Requires(getTwoFactorEnabled != null);

            this.GetTotpSecretConfirmed = getTotpSecretConfirmed;
            this.SetTotpSecretConfirmed = setTotpSecretConfirmed;
            this.GetTotpSecret = getTotpSecret;
            this.SetTotpSecret = setTotpSecret;
            this.GetTwoFactorEnabled = getTwoFactorEnabled;
        }

        public Task<string> GenerateAsync(string purpose, UserManager<TUser, TKey> manager, TUser user)
        {
            return Task.FromResult<string>(null);
        }
        public Task NotifyAsync(string token, UserManager<TUser, TKey> manager, TUser user)
        {
            return Task.FromResult(false);
        }

        public async Task<bool> IsValidProviderForUserAsync(UserManager<TUser, TKey> manager, TUser user)
        {
            return await this.GetTotpSecretConfirmed(user) && !string.IsNullOrWhiteSpace(await this.GetTotpSecret(user));
        }
        public async Task<bool> ValidateAsync(string purpose, string token, UserManager<TUser, TKey> manager, TUser user)
        {
            if (!await this.GetTwoFactorEnabled(user))
                return false;

            var isValid = OneTimeCode.IsValid(await this.GetTotpSecret(user), token, this.CheckIntervals);
            return isValid;
        }

        public async Task GenerateSecretAsync(string purpose, UserManager<TUser, TKey> manager, TUser user, bool updateUser = true)
        {
            var newSecret = OneTimeCode.GenerateSecret();
            await this.SetTotpSecret(user, newSecret);
            await this.SetTotpSecretConfirmed(user, false);

            if (updateUser)
                manager.Update(user);
        }

        public async Task<bool> ConfirmSecretAsync(string purpose, string token, UserManager<TUser, TKey> manager, TUser user, bool updateUser = true)
        {
            var isValidated = await this.ValidateAsync(purpose, token, manager, user);

            if (!isValidated)
                return false;

            await this.SetTotpSecretConfirmed(user, true);

            if (updateUser)
                manager.Update(user);

            return true;
        }

        public async Task<string> GetSecretUriAsync(string issuer, string purpose, UserManager<TUser, TKey> manager, TUser user)
        {
            var secret = await this.GetTotpSecret(user);
            var uri = OneTimeCode.GetUri(secret, issuer, purpose);
            return uri;
        }
    }
}
