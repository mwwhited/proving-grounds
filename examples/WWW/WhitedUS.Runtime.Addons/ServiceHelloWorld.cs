using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Runtime.Definitions;
using System.Threading;

//WhitedUS.Runtime.Addons.ServiceHelloWorld,WhitedUS.Runtime.Addons
namespace WhitedUS.Runtime.Addons
{
    public class ServiceHelloWorld : IRuntimeModule
    {
        #region IRuntimeModule Members

        public void Start()
        {
            while (true)
            {
                Console.WriteLine("Hello World!!!");
                Thread.Sleep(10000);
            }
        }

        #endregion
    }
}
