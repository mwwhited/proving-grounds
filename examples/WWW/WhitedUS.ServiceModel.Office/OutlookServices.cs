using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Xml.Linq;
using WhitedUS.ServiceModel.Linq;
using WhitedUS.ServiceModel.Office.Linq;
using Microsoft.Office.Interop.Outlook;

namespace WhitedUS.ServiceModel.Office
{
    [ServiceContract]
    [AspNetCompatibilityRequirements(
        RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class OutlookServices
    {
        [OperationContract()]
        [WebGet(UriTemplate = "/")]
        [Description("list all services under this service binding")]
        public XElement ListServices()
        {
            return this.GetWebGetServices();
        }

        public IQueryable<_AppointmentItem> GetAppointments(DateTime date)
        {
            var dayFlag = (OlDaysOfWeek)(int)Math.Pow(2, (int)date.DayOfWeek);
            return
                OlDefaultFolders.olFolderCalendar.GetItems<_AppointmentItem>()
                .Select(a => new
                {
                    Appointment = a,
                    RecurrencePattern = a.IsRecurring 
                                            ? a.GetRecurrencePattern() 
                                            : null
                })
                .Where(a =>
                    a.Appointment.Start.Date <= date &&
                    (
                        (a.RecurrencePattern == null && 
                            a.Appointment.End.Date >= date) ||
                        (
                            a.RecurrencePattern != null &&
                            (
                                (a.RecurrencePattern.DayOfMonth == 0 
                                    || a.RecurrencePattern.DayOfMonth == date.Day) &&
                                (a.RecurrencePattern.DayOfWeekMask == 0 
                                    || ((a.RecurrencePattern.DayOfWeekMask & dayFlag) != 0)) &&
                                (a.RecurrencePattern.MonthOfYear == 0 
                                    || a.RecurrencePattern.MonthOfYear == date.Month)
                            )
                        )
                    )
                )
                .Select(a => a.Appointment);
        }

        public IQueryable<_ContactItem> GetContacts()
        {
            return OlDefaultFolders.olFolderContacts.GetItems<_ContactItem>();
        }

        [OperationContract()]
        [WebGet(
            UriTemplate = "/appointments/{year}/{month}/{day}",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType("text/xml")]
        public XElement ListAppointments(string year, string month, string day)
        {
            try
            {
                int iYear, iMonth, iDay;
                int.TryParse(year, out iYear);
                int.TryParse(month, out iMonth);
                int.TryParse(day, out iDay);

                if (iYear == 0) iYear = DateTime.Now.Year;
                if (iMonth == 0) iMonth = DateTime.Now.Month;
                if (iDay == 0) iDay = DateTime.Now.Day;

                var now = new DateTime(iYear, iMonth, iDay).Date;
                return GetAppointments(now).ToXml();
            }
            catch (System.Exception ex)
            {
                return new XElement("exception", ex.ToString());
            }
        }

        [OperationContract()]
        [WebGet(
            UriTemplate = "/appointments/simple/{year}/{month}/{day}",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType("text/xml")]
        public XElement ListSimpleAppointments(string year, string month, string day)
        {
            try
            {
                int iYear, iMonth, iDay;
                int.TryParse(year, out iYear);
                int.TryParse(month, out iMonth);
                int.TryParse(day, out iDay);

                if (iYear == 0) iYear = DateTime.Now.Year;
                if (iMonth == 0) iMonth = DateTime.Now.Month;
                if (iDay == 0) iDay = DateTime.Now.Day;

                var now = new DateTime(iYear, iMonth, iDay).Date; 
                return new XElement("AppointmentItem",
                    GetAppointments(now).Select(a =>
                        new XElement("AppointmentItem",
                            new XAttribute("CreationTime", a.CreationTime),
                            new XAttribute("LastModificationTime", 
                                            a.LastModificationTime),
                            new XAttribute("End", a.End),
                            new XAttribute("Start", a.Start),
                            new XAttribute("Subject", a.Subject 
                                                        ?? string.Empty),
                            new XAttribute("Body", a.Body 
                                                        ?? string.Empty)
                        )));
            }
            catch (System.Exception ex)
            {
                return new XElement("exception", ex.ToString());
            }
        }

        [OperationContract()]
        [WebGet(
            UriTemplate = "/contacts",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType("text/xml")]
        public XElement ListContacts()
        {
            return this.GetContacts().ToXml();
        }

        [OperationContract()]
        [WebGet(
            UriTemplate = "/contacts/simple?take={take}&skip={skip}",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType("text/xml")]
        public XElement ListSimpleContacts(int take, int skip)
        {
            if (take == 0) take = 5;
            var contacts = this.GetContacts();
            var total = contacts.Count();
            if (skip < 0)
                skip = total - (total % skip);
            else if (skip >= contacts.Count()) 
                skip = 0;

            return new XElement("ContactItem",
                new XAttribute("take", take),
                new XAttribute("skip", skip),
                new XAttribute("total", total),
                contacts
                .Skip(skip)
                .Take(take)
                .Select(a =>
                        new XElement("ContactItem",
                            new XAttribute("FileAs", 
                                            a.FileAs ?? string.Empty),
                            new XAttribute("FullName", 
                                           a.FullName ?? string.Empty),
                            new XAttribute("MobileTelephoneNumber", 
                                           a.MobileTelephoneNumber ?? string.Empty),
                            new XAttribute("HomeTelephoneNumber", 
                                           a.HomeTelephoneNumber ?? string.Empty),
                            new XAttribute("BusinessTelephoneNumber", 
                                           a.BusinessTelephoneNumber ?? string.Empty)
                        )));
        }
    }
}
