using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Commands
{
    public class RemoveItemFromCollection<T> : CommandBase
    {
        public RemoveItemFromCollection(ICollection<T> collection)
        {
            this.Collection = collection;
        }

        private ICollection<T> Collection { get; set; }

        protected override void OnExecute(object parameter)
        {
            T item = default(T);
            if (parameter != null)
            {
                item = (T)parameter;
            }

            if (this.Collection.Contains(item))
            {
                this.Collection.Remove(item);
            }
        }
    }
}
