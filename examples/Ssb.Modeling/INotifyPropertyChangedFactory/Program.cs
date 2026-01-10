using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace INotifyPropertyChangedFactory
{
    class Program
    {
        static void Main(string[] args)
        {
            //var s = "s";
            //var t = new Test_Dynamic(s, s, s, s, s, s);
            //var t = (Test)new Rep();

            var t = ClassFactory.Create<Test>();

            t.Property1 = "1!";
            t.Property2 = "2!";
            t.Property3 = "3!";
            t.Property4 = "4!";
            Console.WriteLine(t.Property1);
            Console.WriteLine(t.Property2);
            Console.WriteLine(t.Property3);
            Console.WriteLine(t.Property4);

            (t as INotifyPropertyChanged).PropertyChanged += (s, e) => 
                Console.WriteLine("s:{0}, e:{1}->{2}", s, e, e.PropertyName);

            Console.WriteLine("1");
            t.Property1 = "!1";
            Console.WriteLine("2");
            t.Property2 = "!2";
            Console.WriteLine("3");
            t.Property3 = "!3";
            Console.WriteLine("4");
            t.Property4 = "!4";
            Console.WriteLine(t.Property1);
            Console.WriteLine(t.Property2);
            Console.WriteLine(t.Property3);
            Console.WriteLine(t.Property4);


            //Write out assembly
            // Note: SaveAssembly is not supported in .NET Core/.NET 5+
            // ClassFactory.SaveAssembly();

            Console.Read();
        }
    }
}
