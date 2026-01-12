using System.IO;
using restClient.Linq;
using System.ServiceModel;

namespace restClient
{
    class Program
    {
        static void Main(string[] args)
        {
            //var client = new RestClient("http://www.whited.us/AlphaSite/services/photorest.svc/");
            //client.CreateClientProxy("temp", "PhotoRest");

            var clientM = new RestClient("http://www.whited.us/AlphaSite/services/mediarest.svc/");
            clientM.CreateClientProxy("temp", "MediaRest");

            //var photo = new temp.PhotoRest("http://www.whited.us/AlphaSite/services/photorest.svc/");
            //var res = photo.ListPhotos("2009", 0, 25, "get");

            //using (var buff = photo.GetPhoto("2009",
            //                                 "de7076bbce7e109c99f8546152370ec1",
            //                                 800,
            //                                 800))
            //    buff.SaveTo("outfile.jpg");
        }
    }
}
