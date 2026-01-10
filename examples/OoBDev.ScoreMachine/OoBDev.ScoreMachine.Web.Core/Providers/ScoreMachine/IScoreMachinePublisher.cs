using Newtonsoft.Json.Linq;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    public interface IScoreMachinePublisher
    {
        JObject Translate(IScoreMachineState next);
        Task Publish(IScoreMachineState state);
    }
}