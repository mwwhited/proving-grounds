using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;

namespace WhitedUS.Common.Data
{
    public static class ConnectionStringTools
    {
        public static string ValidateConnectionString(this string connectionString)
        {
            var connectionStringBuilder = new SqlConnectionStringBuilder(connectionString);

            if (HttpContext.Current != null 
                && HttpContext.Current.Request.IsAuthenticated
                && Membership.Provider != null)
            {
                var user = Membership.GetUser();
                if (user != null)
                    connectionStringBuilder.WorkstationID = user.ProviderUserKey.ToString();
            }

            //if (ControllerContext.RouteData != null)
            //{
            //    var area = (string)ControllerContext.RouteData.DataTokens["area"];
            //    if (!string.IsNullOrWhiteSpace(area))
            //    {
            //        var initialCatalog = connectionStringBuilder.InitialCatalog;
            //        connectionStringBuilder.InitialCatalog = string.Format("{0}-{1}", area, initialCatalog);
            //    }
            //}

            return connectionStringBuilder.ConnectionString;
        }

        public static string ValidateEdmxConnectionString(this string connectionString)
        {
            if (connectionString.ToUpper().StartsWith("NAME="))
            {
                var connectionStringName = connectionString.Split('=')[1];
                connectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            }

            var match = Regex.Match(connectionString,
                                    "provider connection string=\"(?<connectionString>.*)\"",
                                    RegexOptions.Compiled
                                    );

            var orgConnectionString = match.Groups["connectionString"].Value;

            var newConnectionString = orgConnectionString.ValidateConnectionString();

            var result = connectionString.Replace(orgConnectionString, newConnectionString);

            return result;
        }
    }
}
