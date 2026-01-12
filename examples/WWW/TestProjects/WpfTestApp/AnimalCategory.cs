using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;

namespace WpfTestApp
{
    public class AnimalCategory
    {
        private string _category;
        public string Category
        {
            get { return _category; }
            set { _category = value; }
        }

        private ObservableCollection<Animal> _animals;
        public ObservableCollection<Animal> Animals
        {

            get
            {
                if (_animals == null)
                    _animals = new ObservableCollection<Animal>();
                return _animals;
            }
        }

        public AnimalCategory()
        {
        }

        public AnimalCategory(
                    string category,
                    ObservableCollection<Animal> animals)
        {
            _category = category;
            _animals = animals;
        }
    }
}
