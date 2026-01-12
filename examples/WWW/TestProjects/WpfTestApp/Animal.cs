using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WpfTestApp
{
    public class Animal
    {
        private string _name;
        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public Animal()
        {
        }

        public Animal(string name)
        {
            _name = name;
        }
    }
}
