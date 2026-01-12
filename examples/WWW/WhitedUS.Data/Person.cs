using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace WhitedUS.Data
{
    [DataObject(true)]
    [DefaultValue("PersonId")]
    public class Person
    {
        private Guid _personId;
        public Person() { _personId = Guid.NewGuid(); }

        [DataObjectField(true, true, false)]
        public Guid PersonId { get { return _personId; } }

        [DataObjectField(false)]
        public string FirstName { get; set; }

        [DataObjectField(false)]
        public string LastName { get; set; }

        public override string ToString()
        {
            return string.Format("{0} {1}", FirstName, LastName);
        }

        private static List<Person> Persons = new List<Person>()
        {
            new Person(){ FirstName="Matthew", LastName="Whited"},
            new Person(){ FirstName="Greg", LastName="Whited"},
            new Person(){ FirstName="Kevin", LastName="Whited"}
        };

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static IEnumerable<Person> GetPersons()
        {
            return Persons;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static Person GetPerson(Guid id)
        {
            return Persons.Where(p => p.PersonId == id).FirstOrDefault();
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public static void DeletePerson(Person person)
        {
            if (person != null)
                DeletePerson(person.PersonId);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public static void DeletePerson(Guid id)
        {
            var person = Persons.Where(p => p.PersonId == id).FirstOrDefault();
            if (person != null)
                Persons.Remove(person);
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static void InsertPerson(Person person)
        {
            var innerPerson = Persons.Where(p => p.PersonId == person.PersonId)
                                     .FirstOrDefault();
            if (innerPerson == null)
                Persons.Add(person);
            else
                throw new InvalidOperationException(
                    "You can not have duplicate IDs");
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public static void InsertPerson(string firstName, string lastName)
        {
            InsertPerson(new Person()
            {
                FirstName = firstName,
                LastName = lastName
            });
        }

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public static void UpdatePerson(Person person)
        {
            UpdatePerson(person.PersonId, person.FirstName, person.LastName);
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public static void UpdatePerson(Guid personId, 
                                        string firstName, 
                                        string lastName)
        {
            var innerPerson = Persons.Where(p => p.PersonId == personId)
                                     .FirstOrDefault();
            if (innerPerson != null)
            {
                innerPerson.FirstName = firstName;
                innerPerson.LastName = lastName;
            }
            else
                throw new IndexOutOfRangeException(
                    "PersonId not found in collection");
        }
    }
}
