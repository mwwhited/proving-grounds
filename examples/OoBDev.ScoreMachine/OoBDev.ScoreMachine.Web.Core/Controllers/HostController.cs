using Microsoft.AspNetCore.Mvc;
using OoBDev.ScoreMachine.Web.Core.Providers;
using System.Linq;
using System.Net.NetworkInformation;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HostController : ControllerBase
    {
        public async Task<IActionResult> Addresses()
        {
            var query = from ni in NetworkInterface.GetAllNetworkInterfaces()
                        let isIpV4 = ni.Supports(NetworkInterfaceComponent.IPv4)
                        select new
                        {
                            ni.Description,
                            ni.Name,
                            Addresses = from ua in ni.GetIPProperties().UnicastAddresses
                                        select new
                                        {
                                            Address = ua.Address?.ToString(),
                                            AddressFamily = ua.Address?.AddressFamily.ToString(),
                                        },
                            MacAddress = ni.GetPhysicalAddress()?.GetAddressBytes().ToHexString("-"),
                            ni.NetworkInterfaceType,
                            ni.Speed,
                            ni.OperationalStatus,
                            ni.Id,
                        };

            var results = await Task.FromResult(query);
            return this.Ok(results);
        }
    }
}