using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.GPSTools;
using WhitedUS.GPSTools.GPX;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace WhitedUSGPSToolsTest
{
    /// <summary>
    /// Summary description for UnitTest1
    /// </summary>
    [TestClass]
    public class GPXTests
    {
        public GPXTests() { }

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext { get; set; }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void GPXDeseralize()
        {
            var file = @"C:\Users\Matthew Whited\Documents\CodeSets\whitedus20\WWW\TestProjects\WhitedUSGPSToolsTest\Johnstown_-_OSU_Newark.gpx";
            var xSer = new XmlSerializer(typeof(GPSExchange));
            using (var fs = File.OpenRead(file))
            {
                var obj = xSer.Deserialize(fs);
                var ret = obj as GPSExchange;

                var points = ret.Track.TrackSegment.Points;
                var min = new
                {
                    Latitude = points.Min(p => p.Latitude),
                    Longitude = points.Min(p => p.Longitude),
                    Elevation = points.Min(p => p.Elevation),
                };
                var max = new
                {
                    Latitude = points.Max(p => p.Latitude),
                    Longitude = points.Max(p => p.Longitude),
                    Elevation = points.Max(p => p.Elevation),
                };
                var diff = new
                {
                    Latitude = max.Latitude - min.Latitude,
                    Longitude = max.Longitude - min.Longitude,
                    Elevation = max.Elevation - min.Elevation,
                };
                var ten = new
                {
                    Latitude = diff.Latitude * .01,
                    Longitude = diff.Longitude * .01,
                };
                var getBounds = new
                {
                    MinLat = min.Latitude - ten.Latitude,
                    MinLon = min.Longitude - ten.Longitude,
                    MaxLat = max.Latitude + ten.Latitude,
                    MaxLon = max.Longitude + ten.Longitude,
                    MinEle = min.Elevation,
                    MaxEle = max.Elevation,
                };
                var aspect = diff.Latitude / diff.Longitude;

                int width = 2000;
                int height = (int)(width * aspect) + 1;

                using (var bmp = new Bitmap(width, height))
                using (var grph = Graphics.FromImage(bmp))
                {
                    float lastX = -1f;
                    float lastY = -1f;
                    float lastZ = -1f;
                    foreach (var point in points)
                    {
                        var pnt = new
                        {
                            x = (int)((point.Longitude - getBounds.MinLon) / (getBounds.MaxLon - getBounds.MinLon) * width),
                            y = height - (int)((point.Latitude - getBounds.MinLat) / (getBounds.MaxLat - getBounds.MinLat) * height),
                            z = ((point.Elevation - getBounds.MinEle) / (getBounds.MaxEle - getBounds.MinEle)),
                        };
                        if (lastX < 0) lastX = pnt.x;
                        if (lastY < 0) lastY = pnt.y;
                        var diffZ = ((pnt.z - lastZ + 1f) / 2f);
                        if (lastZ < 0) diffZ = 0;
                        var c = Color.FromArgb(
                            0, //(byte)(255 * pnt.z),
                            0, //(byte)(255 * (1 - pnt.z)),
                            (byte)(255 * diffZ)
                            );
                        //bmp.SetPixel(pnt.x, pnt.y, c);
                        grph.DrawLine(new Pen(c), pnt.x, pnt.y, lastX, lastY);

                        lastX = pnt.x;
                        lastY = pnt.y;
                        lastZ = pnt.z;
                    }
                    grph.Save();
                    bmp.Save(Path.ChangeExtension(file, ".jpg"), ImageFormat.Jpeg);
                    bmp.Save(Path.ChangeExtension(file, ".png"), ImageFormat.Png);
                }
            }
        }
    }
}
