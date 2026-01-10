namespace OoBDev.SqlServer.Sys
{
    public class ServiceToServiceContract
    {
        public int ServiceContractId { get; set; }
        public int ServiceId { get; set; }
        public Service Service { get; set; }
        public ServiceContract ServiceContract { get; set; }
    }
}