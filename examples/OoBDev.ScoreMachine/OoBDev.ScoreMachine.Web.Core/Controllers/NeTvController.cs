//using Microsoft.AspNetCore.Mvc;
//using OoBDev.ScoreMachine.Web.Core.Providers.NeTv;
//using System.Threading.Tasks;

//namespace OoBDev.ScoreMachine.Web.Core.Controllers
//{
//    [Route("api/[controller]")]
//    [ApiController]
//    public class NeTvController : ControllerBase
//    {
//        public async Task<IActionResult> Start(string netv = null, string hub = null)
//        {
//            var provider = new NeTvProvider( $"http://{hub ?? "10.0.88.1"}",$"http://{hub ?? "10.0.88.4:5000"}", 100);
//            await provider.Start(new System.Threading.CancellationTokenSource());
//            return this.Ok();
//        }
//    }
//}