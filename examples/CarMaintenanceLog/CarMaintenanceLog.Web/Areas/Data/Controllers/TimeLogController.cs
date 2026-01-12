using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class TimeLogController : ApiController
	{
		public TimeLogController()
		{
		}

		public IQueryable<TimeLogModel> Get(int projectId)
		{
			return
				from t in (new CarMaintenanceLogEntities()).TimeLogs
				where t.ProjectID == projectId
				select new TimeLogModel()
				{
					TimeLogID = t.TimeLogID,
					Date = t.Date,
					StartTime = t.StartTime,
					StartBreak = t.StartBreak,
					EndBreak = t.EndBreak,
					EndTime = t.EndTIme,
					Note = t.Note,
					InvoiceID = t.InvoiceID,
					ProjectId = t.ProjectID,
					Miles = t.Miles,
					Hours = t.Hours,
					CarID = t.CarID,
					ReportedTimeLogID = t.ReportedTimeLogID
				};
		}
	}
}