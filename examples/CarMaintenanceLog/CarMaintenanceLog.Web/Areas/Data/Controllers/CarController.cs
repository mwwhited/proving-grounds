using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security.Principal;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
    [Authorize]
    public class CarController : ApiController
    {
        public CarController()
        {
        }

        public void Delete(int id)
        {
        }

        // GET api/<controller>
        public IQueryable<CarModel> Get(int driverid)
        {
            var userid = Guid.Parse(this.RequestContext.Principal.Identity.GetUserId());
            var context = new CarMaintenanceLogEntities();
            var query = from car in context.Cars
                        join miles in context.TotalMiles on car.CarID equals miles.CarID
                        where car.DriverID == driverid
                            && car.Driver.UserID == userid
                            && !car.SoldDate.HasValue
                        select new CarModel
                        {
                            CarID = car.CarID,
                            DriverID = car.DriverID,

                            Make = car.Make,
                            Model = car.Model,
                            SubModel = car.SubModel,
                            Year = car.Year,

                            StartingMiles = car.StartingMiles,
                            Notes = car.Notes,
                            PurchasedDate = car.PurchasedDate,
                            TotalMiles = miles.TotalMiles,
                        };
            return query;
        }

        //        public IQueryable<CarModel> Get(int driverid)
        //        {
        //            CarController.<> c__DisplayClass0_0 variable = null;
        //            Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
        //            CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities();
        //            DbSet<Car> cars = carMaintenanceLogEntity.Cars;
        //            DbSet<TotalMile> totalMiles = carMaintenanceLogEntity.TotalMiles;
        //            ParameterExpression parameterExpression = Expression.Parameter(typeof(Car), "car");
        //            Expression<Func<Car, int>> expression = Expression.Lambda<Func<Car, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_CarID").MethodHandle)), new ParameterExpression[] { parameterExpression });
        //            parameterExpression = Expression.Parameter(typeof(TotalMile), "miles");
        //            Expression<Func<TotalMile, int>> expression1 = Expression.Lambda<Func<TotalMile, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(TotalMile).GetMethod("get_CarID").MethodHandle)), new ParameterExpression[] { parameterExpression });
        //            parameterExpression = Expression.Parameter(typeof(Car), "car");
        //            ParameterExpression parameterExpression1 = Expression.Parameter(typeof(TotalMile), "miles");
        //            ConstructorInfo methodFromHandle = (ConstructorInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType4<Car, TotalMile>).GetMethod(".ctor", new Type[] { typeof(u003ccaru003ej__TPar), typeof(u003cmilesu003ej__TPar) }).MethodHandle, typeof(<> f__AnonymousType4<Car, TotalMile>).TypeHandle);
        //            Expression[] expressionArray = new Expression[] { parameterExpression, parameterExpression1 };
        //            MemberInfo[] memberInfoArray = new MemberInfo[] { (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<> f__AnonymousType4<Car, TotalMile>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType4<Car, TotalMile>).GetMethod("get_miles").MethodHandle, typeof(<> f__AnonymousType4<Car, TotalMile>).TypeHandle) };
        //        var collection = cars.Join(totalMiles, expression, expression1, Expression.Lambda(Expression.New(methodFromHandle, (IEnumerable<Expression>)expressionArray, memberInfoArray), new ParameterExpression[] { parameterExpression, parameterExpression1 }));
        //        parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType4<Car, TotalMile>), "<>h__TransparentIdentifier0");
        //			var collection1 = collection.Where(Expression.Lambda(Expression.AndAlso(Expression.AndAlso(Expression.Equal(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<> f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_DriverID").MethodHandle)), Expression.Field(Expression.Constant(variable, typeof(CarController.<> c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(CarController.<> c__DisplayClass0_0).GetField("driverid").FieldHandle))), Expression.Equal(Expression.Property(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Driver").MethodHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Driver).GetMethod("get_UserID").MethodHandle)), Expression.Convert(Expression.Field(Expression.Constant(variable, typeof(CarController.<>c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(CarController.<>c__DisplayClass0_0).GetField("userid").FieldHandle)), typeof(Guid?)), false, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Guid).GetMethod("op_Equality", new Type[] { typeof(Guid), typeof(Guid)
        //    }).MethodHandle))), Expression.Not(Expression.Property(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_SoldDate").MethodHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(DateTime?).GetMethod("get_HasValue").MethodHandle, typeof(DateTime?).TypeHandle)))), new ParameterExpression[] { parameterExpression1
        //}));
        //			parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType4<Car, TotalMile>), "<>h__TransparentIdentifier0");
        //			return collection1.Select(Expression.Lambda(Expression.MemberInit(Expression.New(typeof(CarModel)), new MemberBinding[] { Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_CarID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_CarID").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_DriverID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_DriverID").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_Make", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Make").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_Model", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Model").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_SubModel", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_SubModel").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_Year", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Year").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_StartingMiles", new Type[] { typeof(decimal) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_StartingMiles").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_Notes", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_Notes").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_PurchasedDate", new Type[] { typeof(DateTime?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_car").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Car).GetMethod("get_PurchasedDate").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(CarModel).GetMethod("set_TotalMiles", new Type[] { typeof(decimal?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType4<Car, TotalMile>).GetMethod("get_miles").MethodHandle, typeof(<>f__AnonymousType4<Car, TotalMile>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(TotalMile).GetMethod("get_TotalMiles").MethodHandle))) }), new ParameterExpression[] { parameterExpression1 }));
        //		}

        // POST api/<controller>
        public CarModel Post([FromBody]CarModel value)
        {
            if (this.ModelState.IsValid)
            {
                if (value.PurchasedDate == DateTime.MinValue)
                    value.PurchasedDate = DateTime.Today;

                var userid = Guid.Parse(this.RequestContext.Principal.Identity.GetUserId());
                var username = this.RequestContext.Principal.Identity.Name;

                using (var context = new CarMaintenanceLogEntities())
                {
                    var driver = context.Drivers.SingleOrDefault(s => s.UserID == userid);
                    if (driver == null)
                    {
                        context.Drivers.Add(new Driver { UserID = userid, Name = username });
                    }

                    var update = context.Cars.SingleOrDefault(f => f.CarID == value.CarID) ?? new Car { DriverID = driver.DriverID, };

                    update.Make = value.Make;
                    update.Model = value.Model;
                    update.SubModel = value.SubModel;
                    update.Year = value.Year;
                    update.StartingMiles = value.StartingMiles;
                    update.PurchasedDate = value.PurchasedDate;
                    update.Notes = string.IsNullOrWhiteSpace(value.Notes) ? null : value.Notes;

                    if (value.CarID != update.CarID)
                        throw new InvalidOperationException();

                    if (value.CarID == 0)
                    {
                        var @new = context.Cars.Add(update);
                        value.CarID = @new.CarID;
                    }
                    context.SaveChanges();
                }

                return value;
            }

            throw new InvalidOperationException();
        }

        public void Put(int id, [FromBody] CarModel value)
        {
        }
    }
}