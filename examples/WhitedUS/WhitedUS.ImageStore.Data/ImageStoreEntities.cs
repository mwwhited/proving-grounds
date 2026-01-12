using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web.Security;
using WhitedUS.Common.Data;
using System.Data;

namespace WhitedUS.ImageStore.Data
{
    partial class ImageStoreEntities
    {
        public static ImageStoreEntities Factory()
        {
            return new ImageStoreEntities();
        }

        [ThreadStatic]
        private static SessionContext _sessionContext;

        public SessionContext SessionContext
        {
            get { return _sessionContext; }
            private set { _sessionContext = value; }
        }

        partial void OnContextCreated()
        {
            //this.Connection.StateChange += Connection_StateChange;

            var connectionString = this.Connection.ConnectionString;
            var validatedConnectionString = connectionString.ValidateEdmxConnectionString();
            this.Connection.ConnectionString = validatedConnectionString;

            ValidateContextSession();
        }

        private static int _counter;
        private void Connection_StateChange(object sender, StateChangeEventArgs e)
        {
            Console.WriteLine("B:{0} A:{1} C:{2}", e.OriginalState, e.CurrentState, _counter++);
        }

        private void ValidateContextSession()
        {
            if (SessionContext == null)
            {
                var entryPoint = Assembly.GetEntryAssembly();
                var executing = Assembly.GetExecutingAssembly();

                var newContext = new SessionContext
                {
                    ASPNET_UserID = GetCurrentUserID(),
                    ApplicationName = entryPoint.FullName,
                    ExecutingAssembly = executing.FullName,
                };

                this.SessionContexts.AddObject(newContext);
                this.SaveChanges();

                this.SessionContext = newContext;
            }
            else
            {
                var context = this.SetSessionContext(SessionContext.Context);
            }
        }

        public static Guid GetCurrentUserID()
        {
            //if (Membership.Provider != null)
            //{
            //    var user = Membership.GetUser();
            //    var key = user.ProviderUserKey;
            //    return (Guid)key;
            //}
            return Guid.Empty;
        }
    }
}
