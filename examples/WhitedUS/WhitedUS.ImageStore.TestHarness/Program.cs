using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Transactions;
using WhitedUS.Drawing;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;
using WhitedUS.ImageStore.Services;

namespace WhitedUS.ImageStore.TestHarness
{
    class Program
    {
        static void Main(string[] args)
        {

            using (var db = new ImageStoreEntities())
            {
                var currentContext = db.SessionContext;

                Console.WriteLine("1_asp:     {0}", currentContext.ASPNET_UserID);
                Console.WriteLine("1_context: {0}", currentContext.ContextID);

                //db.get
            }
            //using (var transaction = new TransactionScope())
            //{
            using (var db = new ImageStoreEntities())
            {
                //var currentContext = db.SessionContext;

                //Console.WriteLine("2_asp:     {0}", currentContext.ASPNET_UserID);
                //Console.WriteLine("2_context: {0}", currentContext.ContextID);

                var context = db.GetCurrentContext().FirstOrDefault();
                if (context != null)
                {
                    Console.WriteLine("3_asp:     {0}", context.ASPNET_UserID);
                    Console.WriteLine("3_context: {0}", context.ContextID);
                }
                else
                {
                    Console.WriteLine("Context is Missing");
                }
            }
            //    transaction.Complete();
            //}
            Console.ReadLine();
        }

        private static void ExifTest()
        {
            using (var db = new ImageStoreEntities())
            {
                var test = from item in db.ContentItems
                           let exif = db.ExifDatas.FirstOrDefault(e => e.ContentItemID == item.ContentItemID)
                           where exif != null
                           select new
                           {
                               item,
                               exif,
                           };

                var result = test.Take(5).ToList();

            }
        }

        private static void DeepZoomProvider()
        {
            var tileProvider = new TileProvider();
            var dzi = tileProvider.GetDeepZoomImage(2);
            var dzc1 = tileProvider.GetDeepZoomCollection(634);
            var dzc2 = tileProvider.GetDeepZoomCollection(89, true);
            var dzc3 = tileProvider.GetDeepZoomCollection(89, false);

            dzi.Save("test.dzi.xml");
            dzc1.Save("test.dzc1.xml");
            dzc2.Save("test.dzc2.xml");
            dzc3.Save("test.dzc3.xml");
        }

        private static void LoadMetaData()
        {
            var contentService = new ContentItemService();
            var frameService = new ContentFrameService();
            var metaService = new ContentMetaService();

            foreach (var item in contentService.List())
            {
                Console.Write("{0}-{1} \"{2}\"", item.FolderID, item.ContentItemID, item.Name);

                var frame = frameService.List().SingleOrDefault(c => c.ContentItemID == item.ContentItemID);
                if (frame != null)
                {
                    Console.WriteLine(":Skip");
                    continue;
                }

                Console.WriteLine(":Write");

                var content = contentService.Get(item.ContentItemID);

                using (var transaction = new TransactionScope())
                using (var ms = new MemoryStream(content.Data))
                using (var bmp = new Bitmap(ms))
                {
                    var model = new ContentFrameModel
                    {
                        ContentItemID = content.ContentItemID,
                        ContentTypeID = content.ContentTypeID,
                        Data = new byte[0],
                        Index = 0,
                        Height = bmp.Height,
                        Width = bmp.Width,
                    };
                    frameService.Save(model);

                    //SELECT TOP 5
                    //    '#' + CAST([Frames].ContentFrameID AS NVARCHAR)					"@Img"
                    //    ,[Frames].ContentFrameID										"@Id"
                    //    ,[Items].Name + ' (' + CAST([Frames].[Index] AS NVARCHAR) + ')'	"@Name"
                    //    ,CAST((SELECT 
                    //        Name														"@Name"
                    //        ,Value														"String/@Value"
                    //        FROM ContentMetaData [Data]
                    //        WHERE [Data].[ContentItemID] = [Items].[ContentItemID]
                    //        FOR XML PATH('Facet')
                    //    )AS XML)														"Facets"
                    //FROM ContentFrames	AS [Frames]
                    //JOIN ContentItems	AS [Items]
                    //    ON [Frames].[ContentItemID] = [Items].[ContentItemID]
                    //FOR XML PATH('Item')

                    var exif = content.Data.GetExifData();
                    if (exif != null)
                    {
                        if (exif.Flash != null)
                        {
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Flash.Fired", Value = exif.Flash.Fired.ToString() });
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Flash.Function", Value = exif.Flash.Function.ToString() });
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Flash.Mode", Value = exif.Flash.Mode.ToString() });
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Flash.RedEyeReductionSupport", Value = exif.Flash.RedEyeReductionSupport.ToString() });
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Flash.Return", Value = exif.Flash.Return.ToString() });
                        }

                        if (!string.IsNullOrWhiteSpace(exif.ExifVersion))
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExifVersion", Value = exif.ExifVersion });
                        if (!string.IsNullOrWhiteSpace(exif.FlashpixVersion))
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FlashpixVersion", Value = exif.FlashpixVersion });
                        if (!string.IsNullOrWhiteSpace(exif.Make))
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Make", Value = exif.Make });
                        if (!string.IsNullOrWhiteSpace(exif.Model))
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Model", Value = exif.Model });


                        if (exif.ShutterSpeedValue != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ShutterSpeedValue", Value = exif.ShutterSpeedValue.ToString() });
                        if (exif.SubjectDistance != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.SubjectDistance", Value = exif.SubjectDistance.ToString() });
                        if (exif.MaxApertureValue != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.MaxApertureValue", Value = exif.MaxApertureValue.ToString() });
                        if (exif.FNumber != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FNumber", Value = exif.FNumber.ToString() });
                        if (exif.FocalLength != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FocalLength", Value = exif.FocalLength.ToString() });
                        if (exif.FlashEnergy != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FlashEnergy", Value = exif.FlashEnergy.ToString() });
                        if (exif.ExposureBiasValue != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExposureBiasValue", Value = exif.ExposureBiasValue.ToString() });
                        if (exif.ExposureIndex != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExposureIndex", Value = exif.ExposureIndex.ToString() });
                        if (exif.ExposureTime != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExposureTime", Value = exif.ExposureTime.ToString() });
                        if (exif.DigitalZoomRatio != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.DigitalZoomRatio", Value = exif.DigitalZoomRatio.ToString() });
                        if (exif.ApertureValue != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ApertureValue", Value = exif.ApertureValue.ToString() });
                        if (exif.BrightnessValue != null)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.BrightnessValue", Value = exif.BrightnessValue.ToString() });

                        if (exif.Orientation.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Orientation", Value = exif.Orientation.ToString() });
                        if (exif.PlanarConfiguration.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.PlanarConfiguration", Value = exif.PlanarConfiguration.ToString() });
                        if (exif.Saturation.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Saturation", Value = exif.Saturation.ToString() });
                        if (exif.SceneCaptureType.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.SceneCaptureType", Value = exif.SceneCaptureType.ToString() });
                        if (exif.SceneType.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.SceneType", Value = exif.SceneType.ToString() });
                        if (exif.SensingMethod.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.SensingMethod", Value = exif.SensingMethod.ToString() });
                        if (exif.Sharpness.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Sharpness", Value = exif.Sharpness.ToString() });
                        if (exif.WhiteBalance.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.WhiteBalance", Value = exif.WhiteBalance.ToString() });
                        if (exif.MeteringMode.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.MeteringMode", Value = exif.MeteringMode.ToString() });
                        if (exif.FocalLengthIn35mmFilm.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FocalLengthIn35mmFilm", Value = exif.FocalLengthIn35mmFilm.ToString() });
                        if (exif.GainControl.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.GainControl", Value = exif.GainControl.ToString() });
                        if (exif.ISOSpeedRatings.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ISOSpeedRatings", Value = exif.ISOSpeedRatings.ToString() });
                        if (exif.LightSource.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.LightSource", Value = exif.LightSource.ToString() });
                        if (exif.FileSource.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.FileSource", Value = exif.FileSource.ToString() });
                        if (exif.ExposureProgram.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExposureProgram", Value = exif.ExposureProgram.ToString() });
                        if (exif.ExposureMode.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ExposureMode", Value = exif.ExposureMode.ToString() });
                        if (exif.ColorSpace.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.ColorSpace", Value = exif.ColorSpace.ToString() });
                        if (exif.Contrast.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.Contrast", Value = exif.Contrast.ToString() });
                        if (exif.DateTimeDigitized.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.DateTimeDigitized", Value = exif.DateTimeDigitized.ToString() });
                        if (exif.DateTimeOriginal.HasValue)
                            metaService.Save(new ContentMetaModel { ContentItemID = item.ContentItemID, Name = "EXIF.DateTimeOriginal", Value = exif.DateTimeOriginal.ToString() });
                    }

                    transaction.Complete();
                }
            }
        }

        private static void ScanFiles()
        {
            var service = new FolderService();
            var folders = service.List();

            foreach (var folder in folders)
            {
                Console.WriteLine("Folder: \"{0}\"", folder.MappedPath);
                ScanFiles(folder);
            }
        }

        private static void ScanFiles(FolderModel model)
        {
            var searchPattern = "*.jpg";

            var service = new ContentItemService();
            var scanner = new FileScanner(model.MappedPath, searchPattern);
            scanner.ScanTo(service, model.FolderID);
        }

        private static void ImportFolders()
        {
            var basePath = @"\\homeserver\photos";
            var searchPattern = "20??";

            var folderService = new FolderService();
            var folderScanner = new FolderScanner(basePath, searchPattern);
            folderScanner.ScanTo(folderService);
        }

        private static void AddJpeg()
        {
            var contentTypeService = new ContentTypeService();
            contentTypeService.Save(new Models.ContentTypeModel
            {
                Name = "Joint Photographic Experts Group",
                Extension = "jpg",
                IsSingleFrame = true,
                MimeType = "image/jpeg",
            });
        }
    }
}
