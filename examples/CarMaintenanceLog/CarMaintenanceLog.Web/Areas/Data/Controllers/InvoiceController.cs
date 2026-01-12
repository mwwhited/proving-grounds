using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Microsoft.AspNet.Identity;
using System.IO;
using System.Net.Http.Headers;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
    [Authorize]
    public class InvoiceController : ApiController
    {
        // GET api/<controller>
        public IQueryable<InvoiceModel> Get(int customerId)
        {
            //var userid = Guid.Parse(this.RequestContext.Principal.Identity.GetUserId());
            var context = new CarMaintenanceLogEntities();
            var query = from c in context.Invoices
                        where c.CustomerID == customerId
                        select new InvoiceModel
                        {
                            InvoiceID = c.InvoiceID,
                            CustomerID = c.CustomerID,
                            Notes = c.Notes,
                            InvoiceDate = c.InvoiceDate,
                            DueDate = c.DueDate,
                            TermsID = c.TermsID,
                            TermsAndConditions = c.TermsAndConditions,
                            InvoiceStatusCode = c.InvoiceStatusCode,
                            //RenderedInvoiceMime = c.RenderedInvoiceMime,
                            //RenderedInvoice = c.RenderedInvoice,
                            InvoiceNumber = c.InvoiceNumber,
                            PaidDate = c.PaidDate,
                            Comment = c.Comment,
                            HasRenderedInvoice = c.HasRenderedInvoice,
                        };
            return query;
        }

        public HttpResponseMessage Get(int customerId, int invoiceId)
        {
            var context = new CarMaintenanceLogEntities();
            var query = from c in context.Invoices
                        join cu in context.Customers on c.CustomerID equals cu.CustomerID
                        where c.CustomerID == customerId
                            && c.InvoiceID == invoiceId
                        select new
                        {
                            InvoiceDate = c.InvoiceDate,
                            DueDate = c.DueDate,
                            RenderedInvoiceMime = c.RenderedInvoiceMime,
                            RenderedInvoice = c.RenderedInvoice,
                            InvoiceNumber = c.InvoiceNumber,
                            PaidDate = c.PaidDate,
                            HasRenderedInvoice = c.HasRenderedInvoice,

                            CompanyName = cu.CompanyName,
                            FirstName = cu.FirstName,
                            LastName = cu.LastName,
                        };
            var invoice = query.FirstOrDefault();

            if (invoice == null)
            {
                var response = this.Request.CreateResponse(HttpStatusCode.NotFound);
                return response;
            }

            if (invoice.HasRenderedInvoice != 1)
            {
                //TODO: Render Invoice Here
            }

            {
                var stream = new MemoryStream(invoice.RenderedInvoice);
                var response = new HttpResponseMessage(HttpStatusCode.OK)
                {
                    Content = new StreamContent(stream),
                };
                var recomendedFilename = $"Invoice_{(invoice.CompanyName ?? $"{invoice.FirstName + " " + invoice.LastName}").Trim().Replace(" ", "_")}_{invoice.InvoiceDate:yyyyMMdd}.pdf";
                response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
                {
                    FileName = recomendedFilename,
                    ModificationDate = invoice.InvoiceDate,
                };
                response.Content.Headers.ContentType = new MediaTypeHeaderValue(invoice.RenderedInvoiceMime ?? "application/octet-stream");
                return response;
            }
        }

        /*
   public HttpResponseMessage Get(int customerId, int invoiceId)
           {
               InvoiceController.<>c__DisplayClass1_0 variable = null;
               DateTimeOffset? nullable;
               CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities();
               DbSet<Invoice> invoices = carMaintenanceLogEntity.Invoices;
               DbSet<Customer> customers = carMaintenanceLogEntity.Customers;
               ParameterExpression parameterExpression = Expression.Parameter(typeof(Invoice), "c");
               Expression<Func<Invoice, int>> expression = Expression.Lambda<Func<Invoice, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_CustomerID").MethodHandle)), new ParameterExpression[] { parameterExpression });
               parameterExpression = Expression.Parameter(typeof(Customer), "cu");
               Expression<Func<Customer, int>> expression1 = Expression.Lambda<Func<Customer, int>>(Expression.Property(parameterExpression, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Customer).GetMethod("get_CustomerID").MethodHandle)), new ParameterExpression[] { parameterExpression });
               parameterExpression = Expression.Parameter(typeof(Invoice), "c");
               ParameterExpression parameterExpression1 = Expression.Parameter(typeof(Customer), "cu");
               ConstructorInfo methodFromHandle = (ConstructorInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod(".ctor", new Type[] { typeof(u003ccu003ej__TPar), typeof(u003ccuu003ej__TPar) }).MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle);
               Expression[] expressionArray = new Expression[] { parameterExpression, parameterExpression1 };
               MemberInfo[] memberInfoArray = new MemberInfo[] { (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_cu").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle) };
               var collection = invoices.Join(customers, expression, expression1, Expression.Lambda(Expression.New(methodFromHandle, (IEnumerable<Expression>)expressionArray, memberInfoArray), new ParameterExpression[] { parameterExpression, parameterExpression1 }));
               parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType2<Invoice, Customer>), "<>h__TransparentIdentifier0");
               var collection1 = collection.Where(Expression.Lambda(Expression.AndAlso(Expression.Equal(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_CustomerID").MethodHandle)), Expression.Field(Expression.Constant(variable, typeof(InvoiceController.<>c__DisplayClass1_0)), FieldInfo.GetFieldFromHandle(typeof(InvoiceController.<>c__DisplayClass1_0).GetField("customerId").FieldHandle))), Expression.Equal(Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_InvoiceID").MethodHandle)), Expression.Field(Expression.Constant(variable, typeof(InvoiceController.<>c__DisplayClass1_0)), FieldInfo.GetFieldFromHandle(typeof(InvoiceController.<>c__DisplayClass1_0).GetField("invoiceId").FieldHandle)))), new ParameterExpression[] { parameterExpression1 }));
               parameterExpression1 = Expression.Parameter(typeof(<>f__AnonymousType2<Invoice, Customer>), "<>h__TransparentIdentifier0");
               ConstructorInfo constructorInfo = (ConstructorInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod(".ctor", new Type[] { typeof(u003cInvoiceDateu003ej__TPar), typeof(u003cDueDateu003ej__TPar), typeof(u003cRenderedInvoiceMimeu003ej__TPar), typeof(u003cRenderedInvoiceu003ej__TPar), typeof(u003cInvoiceNumberu003ej__TPar), typeof(u003cPaidDateu003ej__TPar), typeof(u003cHasRenderedInvoiceu003ej__TPar), typeof(u003cCompanyNameu003ej__TPar), typeof(u003cFirstNameu003ej__TPar), typeof(u003cLastNameu003ej__TPar) }).MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle);
               Expression[] expressionArray1 = new Expression[] { Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_InvoiceDate").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_DueDate").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_RenderedInvoiceMime").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_RenderedInvoice").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_InvoiceNumber").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_PaidDate").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_c").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Invoice).GetMethod("get_HasRenderedInvoice").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_cu").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Customer).GetMethod("get_CompanyName").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_cu").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Customer).GetMethod("get_FirstName").MethodHandle)), Expression.Property(Expression.Property(parameterExpression1, (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType2<Invoice, Customer>).GetMethod("get_cu").MethodHandle, typeof(<>f__AnonymousType2<Invoice, Customer>).TypeHandle)), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(Customer).GetMethod("get_LastName").MethodHandle)) };
               MemberInfo[] methodFromHandle1 = new MemberInfo[] { (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_InvoiceDate").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_DueDate").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_RenderedInvoiceMime").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_RenderedInvoice").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_InvoiceNumber").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_PaidDate").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_HasRenderedInvoice").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_CompanyName").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_FirstName").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle), (MethodInfo)MethodBase.GetMethodFromHandle(typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).GetMethod("get_LastName").MethodHandle, typeof(<>f__AnonymousType3<DateTime?, DateTime?, string, byte[], int?, DateTime?, int, string, string, string>).TypeHandle) };
               var variable1 = collection1.Select(Expression.Lambda(Expression.New(constructorInfo, (IEnumerable<Expression>)expressionArray1, methodFromHandle1), new ParameterExpression[] { parameterExpression1 })).FirstOrDefault();
               if (variable1 == null)
               {
                   return base.Request.CreateResponse(HttpStatusCode.NotFound);
               }
               int hasRenderedInvoice = variable1.HasRenderedInvoice;
               MemoryStream memoryStream = new MemoryStream(variable1.RenderedInvoice);
               HttpResponseMessage httpResponseMessage = new HttpResponseMessage(HttpStatusCode.OK)
               {
                   Content = new StreamContent(memoryStream)
               };
               string str = string.Format("Invoice_{0}_{1:yyyyMMdd}.pdf", (variable1.CompanyName ?? string.Format("{0}", string.Concat(variable1.FirstName, " ", variable1.LastName))).Trim().Replace(" ", "_"), variable1.InvoiceDate);
               HttpContentHeaders headers = httpResponseMessage.Content.Headers;
               ContentDispositionHeaderValue contentDispositionHeaderValue = new ContentDispositionHeaderValue("attachment")
               {
                   FileName = str
               };
               DateTime? invoiceDate = variable1.InvoiceDate;
               if (invoiceDate.HasValue)
               {
                   nullable = new DateTimeOffset?(invoiceDate.GetValueOrDefault());
               }
               else
               {
                   nullable = null;
               }
               contentDispositionHeaderValue.ModificationDate = nullable;
               headers.ContentDisposition = contentDispositionHeaderValue;
               httpResponseMessage.Content.Headers.ContentType = new MediaTypeHeaderValue(variable1.RenderedInvoiceMime ?? "application/octet-stream");
               return httpResponseMessage;
           }
         */
    }
}