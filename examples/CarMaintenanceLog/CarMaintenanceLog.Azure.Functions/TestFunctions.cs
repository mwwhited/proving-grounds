using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using System.Linq;
using System.Security.Claims;

namespace CarMaintenanceLog.Azure.Functions
{
    public static class TestFunctions
    {
        [FunctionName("GetUserClaims")]
        public static IActionResult Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log, ClaimsPrincipal principal)
        {
            log.LogInformation("Test function!");

            var result = new
            {
                IdentityCount = principal?.Identities.Count(),
                principal?.Identity?.Name,
                principal?.Identity?.IsAuthenticated,
                principal?.Identity?.AuthenticationType,
                claims = from c in principal?.Claims
                         select new
                         {
                             c.Type,
                             c.Value,
                             // c.ValueType,
                             c.Issuer,
                             // OriginalIssuer = c.Issuer == c.OriginalIssuer ? null : c.OriginalIssuer,
                             //c.Subject, <= parent identity
                             properties = c.Properties.Any() ? from p in c.Properties
                                                               select new
                                                               {
                                                                   p.Key,
                                                                   p.Value,
                                                               } : null
                         },
            };
            return new OkObjectResult(result);
        }
    }
}
