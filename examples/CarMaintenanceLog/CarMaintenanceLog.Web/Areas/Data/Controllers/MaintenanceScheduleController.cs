using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Microsoft.AspNet.Identity;


namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
    [Authorize]
    public class MaintenanceScheduleController : ApiController
    {
        // GET api/<controller>
        public IQueryable<MaintenanceScheduleModel> Get(int carid)
        {
            var userid = Guid.Parse(this.RequestContext.Principal.Identity.GetUserId());
            var context = new CarMaintenanceLogEntities();
            var query = from item in context.MaintenanceSchedules
                        join miles in context.TotalMiles on item.CarID equals miles.CarID
                        where item.CarID == carid && item.Car.Driver.UserID == userid
                        select new MaintenanceScheduleModel
                        {
                            MaintenanceScheduleID = item.MaintenanceScheduleID,
                            CarID = item.CarID,
                            Miles = item.Miles,
                            WorkItems = item.WorkItems,
                            CompletedOn = item.CompletedOn,
                            IsComplete = item.IsComplete,
                            PastDue = item.Miles < miles.TotalMiles,
                        };
            return query;
        }

        /*
 		public IQueryable<MaintenanceScheduleModel> Get(int carid)
		{
			MaintenanceScheduleController.<>c__DisplayClass0_0 variable = null;
			Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities();
			DbSet<MaintenanceSchedule> maintenanceSchedules = carMaintenanceLogEntity.MaintenanceSchedules;
			DbSet<TotalMile> totalMiles = carMaintenanceLogEntity.TotalMiles;
			ParameterExpression parameterExpression = Expression.Parameter(typeof(MaintenanceSchedule), "item");
			Expression<Func<MaintenanceSchedule, int>> expression = Expression.Lambda<Func<MaintenanceSchedule, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_CarID").MethodHandle)), new ParameterExpression[] { parameterExpression });
			parameterExpression = Expression.Parameter(typeof(TotalMile), "miles");
			Expression<Func<TotalMile, int>> expression1 = Expression.Lambda<Func<TotalMile, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(TotalMile).GetMethod("get_CarID").MethodHandle)), new ParameterExpression[] { parameterExpression });
			parameterExpression = Expression.Parameter(typeof(MaintenanceSchedule), "item");
			ParameterExpression parameterExpression1 = Expression.Parameter(typeof(TotalMile), "miles");
			ConstructorInfo methodFromHandle = (ConstructorInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod(".ctor", new Type[] { typeof(u003citemu003ej__TPar), typeof(u003cmilesu003ej__TPar) }).MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle);
			Expression[] expressionArray = new Expression[] { parameterExpression, parameterExpression1 };
			MemberInfo[] memberInfoArray = new MemberInfo[] { (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_miles").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle) };
			var collection = maintenanceSchedules.Join(totalMiles, expression, expression1, Expression.Lambda(Expression.New(methodFromHandle, (IEnumerable<Expression>)expressionArray, memberInfoArray), new ParameterExpression[] { parameterExpression, parameterExpression1 }));
			parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>), "<>h__TransparentIdentifier0");
			var collection1 = collection.Where(Expression.Lambda(Expression.AndAlso(Expression.Equal(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_CarID").MethodHandle)), Expression.Field(Expression.Constant(variable, typeof(MaintenanceScheduleController.<>c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(MaintenanceScheduleController.<>c__DisplayClass0_0).GetField("carid").FieldHandle))), Expression.Equal(Expression.Property(Expression.Property(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_Car").MethodHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Driver").MethodHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Driver).GetMethod("get_UserID").MethodHandle)), Expression.Convert(Expression.Field(Expression.Constant(variable, typeof(MaintenanceScheduleController.<>c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(MaintenanceScheduleController.<>c__DisplayClass0_0).GetField("userid").FieldHandle)), typeof(Guid?)), false, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Guid).GetMethod("op_Equality", new Type[] { typeof(Guid), typeof(Guid) }).MethodHandle))), new ParameterExpression[] { parameterExpression1 }));
			parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>), "<>h__TransparentIdentifier0");
			return collection1.Select(Expression.Lambda(Expression.MemberInit(Expression.New(typeof(MaintenanceScheduleModel)), new MemberBinding[] { Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_MaintenanceScheduleID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_MaintenanceScheduleID").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_CarID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_CarID").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_Miles", new Type[] { typeof(decimal) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_Miles").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_WorkItems", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_WorkItems").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_CompletedOn", new Type[] { typeof(DateTime?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_CompletedOn").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_IsComplete", new Type[] { typeof(bool?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_IsComplete").MethodHandle))), Expression.Bind((MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceScheduleModel).GetMethod("set_PastDue", new Type[] { typeof(bool) }).MethodHandle), Expression.LessThan(Expression.Convert(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_item").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(MaintenanceSchedule).GetMethod("get_Miles").MethodHandle)), typeof(decimal?)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).GetMethod("get_miles").MethodHandle, typeof(<>f__AnonymousType6<MaintenanceSchedule, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(TotalMile).GetMethod("get_TotalMiles").MethodHandle)))) }), new ParameterExpression[] { parameterExpression1 }));
		}
        */

        // GET api/<controller>/5
        public MaintenanceScheduleModel Get(int carid, int id)
        {
            return this.Get(carid).SingleOrDefault(d => d.MaintenanceScheduleID == id);
        }

        // POST api/<controller>
        public void Post([FromBody]MaintenanceScheduleModel value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]MaintenanceScheduleModel value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}
