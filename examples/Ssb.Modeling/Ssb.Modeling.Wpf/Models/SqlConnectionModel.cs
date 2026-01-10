using Ssb.Modeling.Models;
using Ssb.Modeling.Models.Commands;
using Ssb.Modeling.Wpf.Dialogs;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Ssb.Modeling.Wpf.Models
{
    public class SqlConnectionModel : ViewModelBase
    {
        private string _username = "sa";
        private string _password = "password";
        private string _database = "master";
        private string _servername = "127.0.0.1";
        private bool _useSqlAuthentication = false;
        private string _status = null;

        public SqlConnectionModel()
        {
            this.RefreshInstances = new DoActionCommand(this.OnRefreshInstances);
            this.RefreshDatabases = new DoActionCommand(this.OnRefreshDatabase);
            this.Okay = new DoActionCommand(this.OnOkay);
            this.Cancel = new DoActionCommand(this.OnCancel);
            this.Test = new DoActionCommand(this.OnTest);

            this.Instances = new ObservableCollection<string>();
            this.Databases = new ObservableCollection<string>();
        }

        private async void OnRefreshInstances(object obj)
        {
            var sqlDialog = obj as SqlConnectionDialog;
            sqlDialog.Dispatcher.Invoke(() =>
            {
                this.Status = "Refreshing Instance names";
            });
            await Task.Run(() =>
            {
                try
                {
                    // TODO: SqlDataSourceEnumerator.Instance was removed in .NET Core/.NET 5+
                    // Need to implement alternative SQL Server instance discovery for .NET 9.0
                    // Options:
                    // 1. Use SQL Browser service directly via UDP broadcast (port 1434)
                    // 2. Use WMI queries (Windows only)
                    // 3. Use SQL Management Objects (SMO) NuGet package
                    // 4. Remove feature and require manual server name entry
                    // Original code below (commented out):

                    /*
                    using (var datasources = SqlDataSourceEnumerator.Instance.GetDataSources())
                    {
                        var sources = from row in datasources.Rows.OfType<DataRow>()
                                      let serverName = row[0] //["ServerName"]
                                      let instanceName = row[1] //["InstanceName"]
                                      where serverName != DBNull.Value
                                      select instanceName == DBNull.Value ? serverName.ToString() : string.Format(@"{0}\{1}", serverName, instanceName);

                        sqlDialog.Dispatcher.Invoke(() =>
                        {
                            this.Instances.Clear();
                            foreach (var source in sources)
                                this.Instances.Add(source);
                            this.Status = "Refreshed Instance names";
                        });
                    }
                    */

                    sqlDialog.Dispatcher.Invoke(() =>
                    {
                        this.Status = "SQL Server instance discovery not implemented for .NET 9.0 - enter server name manually";
                    });
                }
                catch (Exception ex)
                {
                    sqlDialog.Dispatcher.Invoke(() =>
                    {
                        this.Status = string.Format("Instance Name Refresh Failed: {0}", ex.Message);
                    });
                }
            }).ConfigureAwait(false);
        }
        private async void OnRefreshDatabase(object obj)
        {
            var sqlDialog = obj as SqlConnectionDialog;
            sqlDialog.Dispatcher.Invoke(() =>
            {
                this.Status = "Refreshing Database names";
            });
            await Task.Run(() =>
            {
                try
                {
                    using (var sqlConnection = new SqlConnection(this.ConnectionString))
                    {
                        sqlConnection.Open();

                        using (var databases = sqlConnection.GetSchema("Databases"))
                        {
                            var databaseNames = databases.Rows.OfType<DataRow>().Select(row => (string)row[0]); //["database_name"];
                            sqlDialog.Dispatcher.Invoke(() =>
                            {
                                this.Databases.Clear();
                                foreach (var database in databaseNames)
                                    this.Databases.Add(database);
                                this.Status = "Refreshed Database names";
                            });
                        }

                    }
                }
                catch (Exception ex)
                {
                    sqlDialog.Dispatcher.Invoke(() =>
                    {
                        this.Status = string.Format("Database Name Refresh Failed: {0}", ex.Message);
                    });
                }
            }).ConfigureAwait(false);
        }

        private void OnOkay(object obj)
        {
            var sqlDialog = obj as SqlConnectionDialog;
            sqlDialog.DialogResult = true;
        }

        private void OnCancel(object obj)
        {
            var sqlDialog = obj as SqlConnectionDialog;
            sqlDialog.DialogResult = false;
        }

        private async void OnTest(object obj)
        {
            var sqlDialog = obj as SqlConnectionDialog;
            sqlDialog.Dispatcher.Invoke(() =>
            {
                this.Status = "Testing SQL Connection";
            });
            await Task.Run(() =>
            {
                using (var sqlConnection = new SqlConnection(this.ConnectionString))
                {
                    try
                    {
                        sqlConnection.Open();
                        sqlDialog.Dispatcher.Invoke(() =>
                        {
                            this.Status = "SQL Connection Succeeded";
                        });
                    }
                    catch (Exception ex)
                    {
                        sqlDialog.Dispatcher.Invoke(() =>
                        {
                            this.Status = string.Format("SQL Connection Failed: {0}", ex.Message);
                        });
                    }
                }
            });
        }

        public string ConnectionString
        {
            get
            {
                var scsb = new SqlConnectionStringBuilder();
                scsb.ApplicationName = Assembly.GetEntryAssembly().FullName.Split(',').First();
                scsb.DataSource = this.ServerName;
                scsb.InitialCatalog = this.Database;
                if (this.UseSqlAuthentication)
                {
                    scsb.UserID = this.UserName;
                    scsb.Password = this.Password;
                }
                else
                {
                    scsb.IntegratedSecurity = true;
                }

                return scsb.ToString();
            }
        }

        public string ServerName
        {
            get { return this._servername; }
            set
            {
                this._servername = value;
                this.OnPropertyChanged("ServerName");
                this.OnPropertyChanged("ConnectionString");
            }
        }
        public string UserName
        {
            get { return this._username; }
            set
            {
                this._username = value;
                this.OnPropertyChanged("Username");
                this.OnPropertyChanged("ConnectionString");
            }
        }
        public string Password
        {
            get { return this._password; }
            set
            {
                this._password = value;
                this.OnPropertyChanged("Password");
                this.OnPropertyChanged("ConnectionString");
            }
        }
        public string Database
        {
            get { return this._database; }
            set
            {
                this._database = value;
                this.OnPropertyChanged("Database");
                this.OnPropertyChanged("ConnectionString");
            }
        }
        public string Status
        {
            get { return this._status; }
            set
            {
                this._status = value;
                this.OnPropertyChanged("Status");
            }
        }
        public bool UseSqlAuthentication
        {
            get { return this._useSqlAuthentication; }
            set
            {
                this._useSqlAuthentication = value;
                this.OnPropertyChanged("UseSqlAuthentication");
                this.OnPropertyChanged("ConnectionString");
            }
        }

        public ObservableCollection<string> Instances { get; private set; }
        public ObservableCollection<string> Databases { get; private set; }

        public ICommand RefreshInstances { get; private set; }
        public ICommand RefreshDatabases { get; private set; }
        public ICommand Okay { get; private set; }
        public ICommand Cancel { get; private set; }
        public ICommand Test { get; private set; }
    }
}
