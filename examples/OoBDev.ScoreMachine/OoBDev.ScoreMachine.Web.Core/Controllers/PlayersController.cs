using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using OoBDev.ScoreMachine.Web.Core.Models;

namespace OoBDev.ScoreMachine.Web.Core.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class PlayersController : ControllerBase
    {
        public IActionResult UpdatePlayers(UpdatePlayersModel model)
        {
            return null;
        }
    }
}