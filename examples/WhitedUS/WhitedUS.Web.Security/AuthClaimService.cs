using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.AspNet.Data;
using System.Web.Security;

namespace WhitedUS.Web.Security
{
    public class AuthClaimService
    {
        public Guid GetUserIDForClaim(string loginClaim)
        {
            using (var context = new AspnetEntities())
            {
                return (from authClaim in context.AuthClaims
                        where authClaim.ClaimString == loginClaim
                        select authClaim.UserID).SingleOrDefault();
            }
        }

        public void AddClaimForUserID(Guid userID, string loginClaim)
        {
            using (var context = new AspnetEntities())
            {
                var authClaim = new AuthClaim
                {
                    UserID = userID,
                    ClaimString = loginClaim,
                };
                context.AuthClaims.AddObject(authClaim);
                context.SaveChanges();
            }
        }

        public void RemoveClaimForUserID(Guid userid, string loginClaim)
        {
            using (var context = new AspnetEntities())
            {
                var query = from ac in context.AuthClaims
                            where ac.UserID == userid
                                && ac.ClaimString == loginClaim
                            select ac;
                var authClaim = query.FirstOrDefault();
                if (authClaim != null)
                {
                    context.DeleteObject(authClaim);
                    context.SaveChanges();
                }
            }
        }

        public IQueryable<AuthClaimModel> ListAuthClaims(Guid userid)
        {
            var context = new AspnetEntities();
            var query = from ac in context.AuthClaims
                        where ac.UserID == userid
                        select new AuthClaimModel
                        {
                            UserID = ac.UserID,
                            ClaimString = ac.ClaimString,
                        };
            return query;
        }
    }
}
