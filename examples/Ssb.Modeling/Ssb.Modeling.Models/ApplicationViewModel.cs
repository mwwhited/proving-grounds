using Ssb.Modeling.Models.Commands;
using Ssb.Modeling.Models.Providers;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class ApplicationViewModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        public ApplicationViewModel()
        {
            //throw new InvalidOperationException();
        }
        public ApplicationViewModel(
            Func<Task<XElement>> loadAction,
            Func<XElement, Task> saveAction,
            Func<Task<bool>> newAction,
            Action<Stream> presentSqlCreate,
            Func<Task<XElement>> importSql,
            IXslTransform transformer,
            IResourceLoader resourceLoader
            )
        {
            this.LoadCommand = new ProjectLoadCommand(loadAction, m => this.Project = m);
            this.NewCommand = new ProjectNewCommand(newAction, m => this.Project = m);
            this.SaveCommand = new ProjectSaveCommand(() => this.Project, saveAction);
            this.GetSqlCreate = new TransformCommand(transformer, resourceLoader,
                                                     "Ssb.Modeling.Models.CodeGenerators.ProjectToSql.xslt",
                                                     m => Task.Run(() => ProjectProvider.ToXml(this.Project)),
                                                     presentSqlCreate);
            this.SqlImport = new ProjectLoadCommand(importSql, m => this.Project = m);

            this.NewCommand.Execute(null);
        }
        public ICommand LoadCommand { get; private set; }
        public ICommand SaveCommand { get; private set; }
        public ICommand NewCommand { get; private set; }
        public ICommand GetSqlCreate { get; private set; }
        public ICommand SqlImport { get; private set; }

        private ProjectModel _project;
        public ProjectModel Project
        {
            get { return this._project; }
            set
            {
                Debug.WriteLine("!!!!!ApplicationViewModel:Project!!!!!");
                this._project = value;
                this.OnPropertyChanged("Project");
                this.SyncEnumerable();
            }
        }

        public event NotifyCollectionChangedEventHandler CollectionChanged;
        private void SyncEnumerable()
        {
            if (this.CollectionChanged != null)
                this.CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }
        private void _CollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            this.SyncEnumerable();
        }

        public IEnumerator GetEnumerator()
        {
            if (this.Project != null)
                yield return this.Project;
        }
    }
}
