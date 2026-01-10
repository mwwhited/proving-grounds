using OoBDev.ScoreMachine.Common;

namespace OoBDev.ScoreMachine.Client.Core
{
    public class SerialScoreMachineReader: ScoreMachineReader
    {
        protected string PortName { get; }
        protected int BaudRate { get; }

        public SerialScoreMachineReader(
            IScoreMachineDecoder decoder,
            IScoreMachinePublisher publisher, 
            string portName, 
            int baudRate)
            :base(decoder, publisher)
        {
            this.PortName = portName;
            this.BaudRate = baudRate;

        }

        /*
            var portName = serial ? ConfigurationManager.AppSettings["ScoreMachine.Serial.PortName"] : null;
            var baudRate = serial ? int.Parse(ConfigurationManager.AppSettings["ScoreMachine.Serial.BaudRate"] ?? "9600") : 9600;
        */
    }
}
