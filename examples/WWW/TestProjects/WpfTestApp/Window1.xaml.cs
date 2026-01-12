using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Collections.ObjectModel;

namespace WpfTestApp
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        static public ObservableCollection<AnimalCategory> AnimalCategories = new ObservableCollection<AnimalCategory>();

        public Window1()
        {
            InitializeComponent();

            ObservableCollection<Animal> animals = new ObservableCollection<Animal>();
            animals.Add(new Animal("California Newt"));
            animals.Add(new Animal("Tomato Frog"));
            animals.Add(new Animal("Green Tree Frog"));
            AnimalCategories.Add(new AnimalCategory("Amphibians", animals));

            animals = new ObservableCollection<Animal>();
            animals.Add(new Animal("Golden Silk Spider"));
            animals.Add(new Animal("Black Widow Spider"));
            AnimalCategories.Add(new AnimalCategory("Spiders", animals));

        }
    }
}
