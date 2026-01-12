using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data;
using System.Reflection;
using System.Web;
using System.Web.Security;

namespace WhitedUS.Shared.Data
{
    partial class SharedEntities
    {
        public static SharedEntities Factory(string connectionString = null, Guid? userid = null)
        {
            var result = string.IsNullOrWhiteSpace(connectionString)
                                ? new SharedEntities()
                                : new SharedEntities(connectionString);
            result._currentUserId = userid ?? Guid.Empty;
            return result;
        }

        [ThreadStatic]
        private static byte[] _contextInfo;
        private Guid _currentUserId;

        partial void OnContextCreated()
        {
            this.Connection.StateChange += Connection_StateChange;
            ValidateContextSession();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (this.Connection != null)
                    this.Connection.StateChange -= Connection_StateChange;
                _currentUserId = Guid.Empty;
                _contextInfo = null;
            }
            base.Dispose(disposing);
        }

        void Connection_StateChange(object sender, StateChangeEventArgs e)
        {
            if (_currentUserId != Guid.Empty)
                if (e.OriginalState != ConnectionState.Open && e.CurrentState == ConnectionState.Open)
                    ValidateContextSession();
        }

        //public override int SaveChanges(SaveOptions options)
        //{
        //    return base.SaveChanges(options);
        //}

        private void ValidateContextSession()
        {
            var userid = _currentUserId;
            if (userid != Guid.Empty)
            {
                if (_contextInfo == null)
                {
                    var contextId = Guid.NewGuid();

                    _contextInfo = userid.ToByteArray()
                                         .Concat(contextId.ToByteArray())
                                         .Concat(new byte[128 - 16 - 16])
                                         .ToArray();

                    var entryPoint = Assembly.GetEntryAssembly();
                    var executing = Assembly.GetExecutingAssembly();

                    var timeStamp = DateTime.UtcNow;
                    var session = new Session
                    {
                        UserID = userid,
                        ContextInfo = _contextInfo,

                        EntryPoint = entryPoint == null ? null : entryPoint.FullName,
                        EntryPointVersion = entryPoint == null ? null : entryPoint.ImageRuntimeVersion,

                        Executing = executing == null ? null : executing.FullName,
                        ExecutingVersion = executing == null ? null : executing.ImageRuntimeVersion,

                        StartedTime = timeStamp,
                        LastUsedTime = timeStamp,
                    };
                    this.Sessions.AddObject(session);
                    this.SaveChanges();
                }

                var binary = _contextInfo.Aggregate(new StringBuilder().Append("0x"), (sb, v) => sb.AppendFormat("{0:x2}", v)).ToString();
                this.ExecuteStoreCommand("SET CONTEXT_INFO " + binary);
                //this.SaveChanges();
            }
        }
    }
}
