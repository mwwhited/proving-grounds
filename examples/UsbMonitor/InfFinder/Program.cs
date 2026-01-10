using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InfFinder
{
    class Program
    {
        static void Main(string[] args)
        {
            var path = @"C:\Windows\Inf";
            var items = from file in Directory.GetFiles(path, "*.inf", SearchOption.AllDirectories)
                        let lines = File.ReadAllLines(file)
                        where lines.Any(l => l.Contains("Prolific"))
                        select new
                        {
                            file,
                            lines,
                        };

            foreach (var item in items)
            {
                Console.WriteLine(item.file);

                foreach (var line in item.lines)
                {
                    //3.3.2.102  9/24/2008
                    Console.WriteLine("\t{0}", line);
                }
            }

            Console.WriteLine("fin!");
            Console.Read();

        }
    }
}
