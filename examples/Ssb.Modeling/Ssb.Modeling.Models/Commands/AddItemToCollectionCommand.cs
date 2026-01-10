using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Ssb.Modeling.Models.Commands
{
    public class AddItemToCollectionCommand<T> : CommandBase
    {
        public AddItemToCollectionCommand(ICollection<T> collection, Func<T> itemFactory, bool addAlways = false)
            : this(collection, itemFactory != null ? new Func<object, T>(x => itemFactory()) : null, addAlways)
        {
        }
        public AddItemToCollectionCommand(ICollection<T> collection, Func<object, T> itemFactory = null, bool addAlways = false)
        {
            this.Collection = collection;
            this.ItemFactory = itemFactory;
            this.AddAlways = AddAlways;
        }

        private ICollection<T> Collection { get; set; }
        private Func<object, T> ItemFactory { get; set; }
        private bool AddAlways { get; set; }

        protected async override void OnExecute(object parameter)
        {
            await Task.Yield();

            T item = default(T);
            if (this.ItemFactory != null)
            {
                item = this.ItemFactory(parameter);
            }
            else if (parameter != null)
            {
                item = (T)parameter;
            }

            if (this.AddAlways || !this.Collection.Contains(item))
            {
                this.Collection.Add(item);
            }
        }
    }
}
