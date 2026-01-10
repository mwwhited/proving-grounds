using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Tools
{
    public static class CollectionEx
    {
        public static ICollection<T> Add<T>(this ICollection<T> collection, IEnumerable<T> items)
        {
            foreach (var item in items)
                collection.Add(item);
            return collection;
        }

        public static TModel AddTo<TModel, T>(this TModel model, Func<TModel, ICollection<T>> collectionGetter, IEnumerable<T> items)
        {
            var collection = collectionGetter(model);
            collection.Add(items);
            return model;
        }
    }
}
