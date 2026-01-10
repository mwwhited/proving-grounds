using OoBDev.ScoreMachine.Common;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Client.Core
{
    public interface IScoreMachinePublisher
    {
        Task Publish(IScoreMachineState next);
    }
}