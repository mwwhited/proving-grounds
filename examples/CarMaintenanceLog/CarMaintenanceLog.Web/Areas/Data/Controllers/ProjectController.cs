using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
    [Authorize]
    public class ProjectController : ApiController
    {
        // GET api/<controller>
        public IQueryable<ProjectModel> Get(int customerId)
        {
            var userid = Guid.Parse(this.RequestContext.Principal.Identity.GetUserId());
            var context = new CarMaintenanceLogEntities();
            var query = from p in context.Projects
                        from ep in p.EmployeeProjects
                        where ep.Employee.UserID == userid
                            && p.CustomerID == customerId
                        select new ProjectModel
                        {
                            ProjectID = p.ProjectID,
                            CustomerID = p.CustomerID,
                            Name = p.Name,
                            HourlyRate = p.HourlyRate,
                            DefaultMiles = p.DefaultMiles,
                        };
            return query;
        }

//        public IQueryable<ProjectModel> Get2(int customerId)
//        {
//            ProjectController.<> c__DisplayClass0_0 variable = null;
//            Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
//            DbSet<Project> projects = (new CarMaintenanceLogEntities()).Projects;
//            ParameterExpression parameterExpression = Expression.Parameter(typeof(Project), "p");
//            Expression<Func<Project, IEnumerable<EmployeeProject>>> expression = Expression.Lambda<Func<Project, IEnumerable<EmployeeProject>>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_EmployeeProjects").MethodHandle)), new ParameterExpression[] { parameterExpression });
//            parameterExpression = Expression.Parameter(typeof(Project), "p");
//            ParameterExpression parameterExpression1 = Expression.Parameter(typeof(EmployeeProject), "ep");
//            ConstructorInfo methodFromHandle = (ConstructorInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType5<Project, EmployeeProject>).GetMethod(".ctor", new Type[] { typeof(u003cpu003ej__TPar), typeof(u003cepu003ej__TPar) }).MethodHandle, typeof(<> f__AnonymousType5<Project, EmployeeProject>).TypeHandle);
//            Expression[] expressionArray = new Expression[] { parameterExpression, parameterExpression1 };
//            MemberInfo[] memberInfoArray = new MemberInfo[] { (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<> f__AnonymousType5<Project, EmployeeProject>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_ep").MethodHandle, typeof(<> f__AnonymousType5<Project, EmployeeProject>).TypeHandle) };
//        var collection = projects.SelectMany(expression, Expression.Lambda(Expression.New(methodFromHandle, (IEnumerable<Expression>)expressionArray, memberInfoArray), new ParameterExpression[] { parameterExpression, parameterExpression1 }));
//        parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType5<Project, EmployeeProject>), "<>h__TransparentIdentifier0");
//			var collection1 = collection.Where(Expression.Lambda(Expression.AndAlso(Expression.Equal(Expression.Property(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<> f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_ep").MethodHandle, typeof(<> f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(EmployeeProject).GetMethod("get_Employee").MethodHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Employee).GetMethod("get_UserID").MethodHandle)), Expression.Convert(Expression.Field(Expression.Constant(variable, typeof(ProjectController.<> c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(ProjectController.<> c__DisplayClass0_0).GetField("userid").FieldHandle)), typeof(Guid?)), false, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Guid).GetMethod("op_Equality", new Type[] { typeof(Guid), typeof(Guid)
//    }).MethodHandle)), Expression.Equal(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_CustomerID").MethodHandle)), Expression.Field(Expression.Constant(variable, typeof(ProjectController.<>c__DisplayClass0_0)), FieldInfo.GetFieldFromHandle(typeof(ProjectController.<>c__DisplayClass0_0).GetField("customerId").FieldHandle)))), new ParameterExpression[] { parameterExpression1
//}));
//			parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType5<Project, EmployeeProject>), "<>h__TransparentIdentifier0");
//			return collection1.Select(Expression.Lambda(Expression.MemberInit(Expression.New(typeof(ProjectModel)), new MemberBinding[] { Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(ProjectModel).GetMethod("set_ProjectID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_ProjectID").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(ProjectModel).GetMethod("set_CustomerID", new Type[] { typeof(int) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_CustomerID").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(ProjectModel).GetMethod("set_Name", new Type[] { typeof(string) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_Name").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(ProjectModel).GetMethod("set_HourlyRate", new Type[] { typeof(double?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_HourlyRate").MethodHandle))), Expression.Bind((MethodInfo) MethodBase.GetMethodFromHandle(typeof(ProjectModel).GetMethod("set_DefaultMiles", new Type[] { typeof(double?) }).MethodHandle), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo) MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType5<Project, EmployeeProject>).GetMethod("get_p").MethodHandle, typeof(<>f__AnonymousType5<Project, EmployeeProject>).TypeHandle)), (MethodInfo) MethodBase.GetMethodFromHandle(typeof(Project).GetMethod("get_DefaultMiles").MethodHandle))) }), new ParameterExpression[] { parameterExpression1 }));
//		}
    }
}