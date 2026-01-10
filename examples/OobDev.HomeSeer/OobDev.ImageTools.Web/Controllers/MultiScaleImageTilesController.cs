using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using OobDev.ImageTools.MultiScaleImages;
using System.Net.Http.Headers;
using System.Drawing;
using Newtonsoft.Json.Linq;
using System.Text;
using Newtonsoft.Json;

namespace OobDev.ImageTools.Web.Controllers
{
    [RoutePrefix("api/msit")]
    public class MultiScaleImageTilesController : ApiController
    {
        private static object _cacheGenLock = new object();

        // http://stackoverflow.com/questions/9541351/ 

        [Route("{image}/{level:int}/{x:int}/{y:int}")]
        public HttpResponseMessage GetTile(string image, int level, int x, int y)
        {
            var fileName = $"{image}.jpg"; // image + ".jpg";
            var path = Path.Combine(HttpContext.Current.Server.MapPath("~/Content"), fileName);
            var cachePath = Path.Combine(HttpContext.Current.Server.MapPath("~/Cached"), fileName, level.ToString(), $"{x:0000}_{y:0000}");

            if (!File.Exists(cachePath))
            {
                lock (_cacheGenLock)
                {
                    if (!File.Exists(cachePath))
                    {
                        var dir = Path.GetDirectoryName(cachePath);
                        if (!Directory.Exists(dir))
                            Directory.CreateDirectory(dir);

                        using (var bitmap = new Bitmap(path))
                        {
                            var maxLevel = bitmap.GetMaxLevel();

                            for (var l = 0; l <= maxLevel; l++)
                            {
                                var tileCounts = bitmap.GetTileCount(level);

                                for (var gx = 0; gx < tileCounts.Width; gx++)
                                    for (var gy = 0; gy < tileCounts.Height; gy++)
                                    {
                                        var file = Path.Combine(dir, $"{gx:0000}_{gy:0000}");
                                        if (!File.Exists(file))
                                        {
                                            var buffer = bitmap.GetTileAsBytes(level, gx, gy);
                                            File.WriteAllBytes(file, buffer);
                                        }
                                    }
                            }
                        }

                        var bytes = path.GetTileAsBytes(level, x, y);
                        File.WriteAllBytes(cachePath, bytes);
                    }
                }
            }

            var result = new HttpResponseMessage(HttpStatusCode.OK);
            var stream = new FileStream(cachePath, FileMode.Open);
            result.Content = new StreamContent(stream);
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");
            return result;
        }

        [Route("{image}")]
        public HttpResponseMessage GetMeta(string image)
        {
            var fileName = image + ".jpg";
            var path = Path.Combine(HttpContext.Current.Server.MapPath("~/Content"), fileName);
            var cachePath = Path.Combine(HttpContext.Current.Server.MapPath("~/Cached"), fileName, "metadata.json");

            if (!File.Exists(cachePath))
            {
                using (var bitmap = new Bitmap(path))
                {
                    var maxLevel = bitmap.GetMaxLevel();
                    var obj = new
                    {
                        FileName = fileName,
                        Size = new { Width = bitmap.Width, Height = bitmap.Height, },
                        MaxLevel = (int)maxLevel,
                        Levels = from level in Enumerable.Range(0, (int)maxLevel + 1)
                                 let tileCount = bitmap.GetTileCount(level)
                                 select new
                                 {
                                     Level = level,
                                     Tiles = new { X = tileCount.Width, Y = tileCount.Height, }
                                 }
                    };

                    var json = JsonConvert.SerializeObject(obj, Formatting.Indented);

                    var dir = Path.GetDirectoryName(cachePath);
                    if (!Directory.Exists(dir))
                        Directory.CreateDirectory(dir);

                    File.WriteAllText(cachePath, json.ToString(), Encoding.UTF8);
                }
            }

            var result = new HttpResponseMessage(HttpStatusCode.OK);
            var stream = new FileStream(cachePath, FileMode.Open);
            result.Content = new StreamContent(stream);
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            return result;

        }

        //var sourceFile = "DSC_4668.JPG";

        //using (var bitmap = new Bitmap(sourceFile))
        //{
        //    var maxLevel = bitmap.GetMaxLevel();

        //    for (var level = 0; level <= maxLevel; level++)
        //    {
        //        var dir = level.ToString();
        //        if (!Directory.Exists(dir))
        //            Directory.CreateDirectory(dir);

        //        var tileCounts = bitmap.GetTileCount(level);

        //        for (var x = 0; x < tileCounts.Width; x++)
        //            for (var y = 0; y < tileCounts.Height; y++)
        //            {
        //                var file = Path.Combine(dir, $"{x:0000}_{y:0000}.jpg");
        //                Console.Write(file);

        //                if (!File.Exists(file))
        //                {
        //                    Console.WriteLine(" Create");
        //                    var buffer = bitmap.GetTileAsBytes(level, x, y);
        //                    File.WriteAllBytes(file, buffer);
        //                }
        //                else
        //                {
        //                    Console.WriteLine(" Skip");
        //                }
        //            }
        //    }
        //}
    }
}
