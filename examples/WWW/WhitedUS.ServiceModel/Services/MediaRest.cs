using System.ComponentModel;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Xml.Linq;
using WhitedUS.Data.MediaCollection;
using WhitedUS.ServiceModel.Linq;

//WhitedUS.ServiceModel.Services.MediaRest
namespace WhitedUS.ServiceModel.Services
{
    /// <summary>
    /// WCF RESTful services for use with my Media Collection
    /// </summary>
    [ServiceContract]
    [AspNetCompatibilityRequirements(
        RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class MediaRest
    {
        /// <remarks />
        [OperationContract()]
        [WebGet(UriTemplate = "/")]
        [Description("list all services under this service binding")]
        public XElement ListServices()
        {
            return this.GetWebGetServices();
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(UriTemplate = "/list?codeTypeId={codeTypeId}" +
                              "&mediaTypeId={mediaTypeId}")]
        [Description("list all media")]
        public XElement ListMedia(int codeTypeId, int mediaTypeId)
        {
            var media = MediaCollectionDataDataContext.Instance;
            if (media == null)
                return null;

            return new XElement("media",
                from c in media.CodeTypes
                where codeTypeId == 0 || c.CodeTypeID == codeTypeId
                orderby c.Name
                select new XElement("codeType",
                    new XAttribute("name", c.Name ?? string.Empty),
                    new XAttribute("longName", c.LongName ?? string.Empty),
                    new XAttribute("baseUrl", c.BaseUrl ?? string.Empty),
                    new XAttribute("codeTypeID", c.CodeTypeID),
                    from mt in media.MediaTypes
                    where mt.CodeTypeID == c.CodeTypeID  &&
                        (mediaTypeId == 0 || mt.MediaTypeID == mediaTypeId)
                    orderby mt.Name 
                    select new XElement("mediaType",
                        new XAttribute("mediaTypeID", mt.MediaTypeID),
                        new XAttribute("name", mt.Name),
                        new XAttribute("codeTypeID", mt.CodeTypeID),
                        from m in media.Medias
                        where m.MediaTypeID == mt.MediaTypeID 
                        orderby m.Title, m.Year
                        select new XElement("medium",
                            new XAttribute("title", m.Title ?? string.Empty),
                            new XAttribute("boxTitle", 
                                            m.BoxTitle ?? string.Empty),
                            new XAttribute("code", m.Code ?? string.Empty),
                            new XAttribute("diskNumber", 
                                            m.DiskNumber ?? string.Empty),
                            new XAttribute("format", m.Format ?? string.Empty),
                            new XAttribute("have", m.Have),
                            new XAttribute("mediaID", m.ID),
                            new XAttribute("mediaTypeID", m.MediaTypeID),
                            new XAttribute("length", m.Length ?? string.Empty),
                            new XAttribute("notes", m.Notes ?? string.Empty),
                            new XAttribute("rating", m.Rating ?? string.Empty),
                            new XAttribute("year", m.Year ?? string.Empty)
                            )
                        )
                    )
                );
        }

    }
}
