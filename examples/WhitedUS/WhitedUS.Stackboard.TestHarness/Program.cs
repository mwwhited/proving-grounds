using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Services;
using WhitedUS.StackBoard.Models;
using System.Transactions;
using System.Xml.Linq;

namespace WhitedUS.StackBoard.TestHarness
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var transaction = new TransactionScope())
            {
                //var stateService = new StateService();
                //stateService.Save(new StateModel
                //{
                //    Name = "State1",
                //    TaskTypeID = 2,
                //});

                var service = new TaskService();

                var list = from task in service.List().AsEnumerable()
                           select task.MetaDataXml.Root;

                var xml = new XElement("test", list);

                //var task = new TaskModel
                //{
                //    Subject = "Root2",
                //    Description = null,
                //    StateID = 1,
                //    TaskTypeID = 2,
                //    GroupID = 15,
                //    PriorityID = 2,
                //    MetaData = new XDocument(
                //        new XElement("root",
                //            from i in Enumerable.Range(0, 5)
                //            select new XElement("item",
                //                new XAttribute("id", i)
                //                )
                //            )
                //        ),
                //};
                //var taskId = service.Save(task);

                transaction.Complete();
            }
        }
    }
}
