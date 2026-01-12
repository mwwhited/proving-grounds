using System.Collections;
using System.Collections.Generic;

namespace WhitedUS.Web.Controls
{
    internal class DummyDataSource : List<string>
    {
        internal DummyDataSource(int itemCount)
        {
            for (int i = 0; i < itemCount; i++)
                Add(string.Format("Item{0}", i));
        }
    }
}
