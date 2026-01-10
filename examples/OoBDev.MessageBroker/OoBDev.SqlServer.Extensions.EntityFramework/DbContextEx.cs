using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    public static class DbContextEx
    {
        public static void SetContextInfo(this DbContext context, byte[] data)
        {
            if (data == null) return;

            if (context.Database.GetDbConnection().State != ConnectionState.Open)
            {
                context.Database.OpenConnection();
            }

            context.Database.ExecuteSqlCommand($"SET CONTEXT_INFO {data}");
        }

        public static void SetContextInfo(this DbContext context, string message)
        {
            if (string.IsNullOrWhiteSpace(message)) throw new ArgumentNullException(nameof(message));
            if (message.Length > 64) throw new ArgumentOutOfRangeException(nameof(message));

            var data = Encoding.Unicode.GetBytes(message);
            context.SetContextInfo(data);
        }

        public static byte[] GetContextInfo(this DbContext context)
        {
            if (context == null) return null;
            var connection = context?.Database?.GetDbConnection();
            if (connection == null) return null;
            if (connection.State != ConnectionState.Open) return null;

            var cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT CONTEXT_INFO()";
            cmd.CommandType = CommandType.Text;
            var result = cmd.ExecuteScalar();
            if (result == DBNull.Value) return null;
            var converted = (byte[])result;
            return converted;
        }

        public static void SetSessionContext(this DbContext context, string key, object value)
        {
            if (string.IsNullOrWhiteSpace(key)) throw new ArgumentNullException(nameof(key));

            if (context.Database.GetDbConnection().State != ConnectionState.Open)
            {
                context.Database.OpenConnection();
            }

            context.Database.ExecuteSqlCommand($"EXEC sp_set_session_context {key}, {value}");
        }

        public static TResult GetSessionContext<TResult>(this DbContext context, string key)
        {
            if (string.IsNullOrWhiteSpace(key)) throw new ArgumentNullException(nameof(key));
            if (context == null) throw new ArgumentNullException(nameof(context));

            var connection = context?.Database?.GetDbConnection();
            if (connection == null) throw new ArgumentNullException(nameof(context));
            if (connection.State != ConnectionState.Open) throw new InvalidOperationException();

            var cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT SESSION_CONTEXT(@key)";
            cmd.Parameters.Add(new SqlParameter("key", key));
            cmd.CommandType = CommandType.Text;
            var result = cmd.ExecuteScalar();
            if (result == DBNull.Value) return default(TResult);
            var converted = (TResult)result;
            return converted;
        }

        public static string AsString(this byte[] data)
        {
            if (data == null) return null;
            var message = Encoding.Unicode.GetString(data);
            return message;
        }
    }
}
