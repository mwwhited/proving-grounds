using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Data.Photos;
using WhitedUS.Libs.Graphics.Exif;
using System.Diagnostics;

namespace WhitedUSDataTests
{


    /// <summary>
    ///This is a test class for PhotoTest and is intended
    ///to contain all PhotoTest Unit Tests
    ///</summary>
    [TestClass()]
    public class PhotoTest
    {
        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext { get; set; }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for ThumbNailBase64
        ///</summary>
        [TestMethod()]
        public void ThumbNailBase64Test()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.ThumbNailBase64;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ThumbNail
        ///</summary>
        [TestMethod()]
        public void ThumbNailTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = target.ThumbNail;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Tags
        ///</summary>
        [TestMethod()]
        public void TagsTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            IEnumerable<Tag> actual;
            actual = target.Tags;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for RelativePath
        ///</summary>
        [TestMethod()]
        public void RelativePathTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.RelativePath;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ImagePathHash
        ///</summary>
        [TestMethod()]
        public void ImagePathHashTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.ImagePathHash;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ImagePath
        ///</summary>
        [TestMethod()]
        public void ImagePathTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            target.ImagePath = expected;
            actual = target.ImagePath;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ImageFileName
        ///</summary>
        [TestMethod()]
        public void ImageFileNameTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.ImageFileName;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Image
        ///</summary>
        [TestMethod()]
        public void ImageTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = target.Image;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ID
        ///</summary>
        [TestMethod()]
        public void IDTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            Guid actual;
            actual = target.ID;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for EXIF
        ///</summary>
        [TestMethod()]
        public void EXIFTest()
        {
            var fn = @"\\trojan\photos\--------_BingOverlays\test1.jpg";
            var bmp = new Bitmap(fn);
            var exif = ExifData.CreateInstance(bmp);

            int x = 0;


            //Photo target = new Photo(); // TODO: Initialize to an appropriate value
            //ExifData actual;
            //actual = target.EXIF;
            //Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ToString
        ///</summary>
        [TestMethod()]
        public void ToStringTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = target.ToString();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Resize
        ///</summary>
        [TestMethod()]
        public void ResizeTest1()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            int maxWidth = 0; // TODO: Initialize to an appropriate value
            int maxHeight = 0; // TODO: Initialize to an appropriate value
            Stream stream = null; // TODO: Initialize to an appropriate value
            target.Resize(maxWidth, maxHeight, stream);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Resize
        ///</summary>
        [TestMethod()]
        public void ResizeTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            int maxWidth = 0; // TODO: Initialize to an appropriate value
            int maxHeight = 0; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = target.Resize(maxWidth, maxHeight);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for RemoveTag
        ///</summary>
        [TestMethod()]
        public void RemoveTagTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string tag = string.Empty; // TODO: Initialize to an appropriate value
            target.RemoveTag(tag);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for GetImages
        ///</summary>
        [TestMethod()]
        public void GetImagesTest1()
        {
            string relativePath = string.Empty; // TODO: Initialize to an appropriate value
            IEnumerable<Photo> expected = null; // TODO: Initialize to an appropriate value
            IEnumerable<Photo> actual;
            actual = Photo.GetImages(relativePath);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetImages
        ///</summary>
        [TestMethod()]
        public void GetImagesTest()
        {
            IEnumerable<Photo> expected = null; // TODO: Initialize to an appropriate value
            IEnumerable<Photo> actual;
            actual = Photo.GetImages();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetImage
        ///</summary>
        [TestMethod()]
        public void GetImageTest1()
        {
            string hashKey = string.Empty; // TODO: Initialize to an appropriate value
            string relativePath = string.Empty; // TODO: Initialize to an appropriate value
            Photo expected = null; // TODO: Initialize to an appropriate value
            Photo actual;
            actual = Photo.GetImage(hashKey, relativePath);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetImage
        ///</summary>
        [TestMethod()]
        public void GetImageTest()
        {
            string hashKey = string.Empty; // TODO: Initialize to an appropriate value
            Photo expected = null; // TODO: Initialize to an appropriate value
            Photo actual;
            actual = Photo.GetImage(hashKey);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ClearCache
        ///</summary>
        [TestMethod()]
        public void ClearCacheTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.ClearCache();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for AddTag
        ///</summary>
        [TestMethod()]
        public void AddTagTest()
        {
            Photo target = new Photo(); // TODO: Initialize to an appropriate value
            string tag = string.Empty; // TODO: Initialize to an appropriate value
            target.AddTag(tag);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Photo Constructor
        ///</summary>
        [TestMethod()]
        public void PhotoConstructorTest()
        {
            Photo target = new Photo();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        [TestMethod]
        public void ThumbNailerProblem()
        {
            //P9180010.JPG
            var path = @"\\trojan\Photos\2003\20030920_ga";
            var album = new PhotoAlbum(path);
            var photos = from p in album.Photos
                         let l = p.ImageFileName.ToUpperInvariant()
                         where l == "P9190070.JPG"
                         select p;
            var photo = photos.First();
            var exit = photo.EXIF;
            try
            {
                File.WriteAllBytes(@"C:\Users\Matthew Whited\Desktop\image.jpg", photo.ThumbNail);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.ToString());
            }

        }
    }
}
