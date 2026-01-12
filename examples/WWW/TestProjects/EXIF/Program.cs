using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.IO;
using System.Reflection;
using WhitedUS.Libs.Converters;
using System.Reflection.Emit;
using WhitedUS.Libs.Graphics.Exif;
using WhitedUS.Data;
using WhitedUS.Data.Photos;

namespace EXIF
{
    class Program
    {
        //@"\\trojan\Photos\2008\07122008_Kathys55Bday\DSC_0001.JPG";
        //@"\\trojan\Photos\2003\First_Good_Snow_At_Condo.JPG"; 
        //@"\\trojan\Photos\2003\PB130004.JPG";
        const string FILE_NAME = @"\\trojan\Photos\2003\PB130004.JPG";

        static void Main(string[] args)
        {
            #region tests

            //var _ascii = ExifType.ASCII.GetData("test");
            //var _byte = ExifType.BYTE.GetData((byte)254);
            //var _long = ExifType.LONG.GetData((uint)65570);
            //var _slong = ExifType.SLONG.GetData((int)-65537);
            //var _short = ExifType.SHORT.GetData((short)3456);
            //var _undef = ExifType.UNDEFINED.GetData(new byte[] { 1, 2, 3, 4, 5 });
            //var _sratPI = ExifType.SRATIONAL.GetData(Math.PI);
            //var _sratPI3 = ExifType.SRATIONAL.GetData(Math.PI - 3);
            //var _srat300 = ExifType.SRATIONAL.GetData(300d);
            //var _srat5_6 = ExifType.SRATIONAL.GetData(5.6d);
            //var _srat1_60 = ExifType.SRATIONAL.GetData(0.0166666666666666666666666666d);
            //var _srat0 = ExifType.SRATIONAL.GetData(0d);
            //var _ratPI = ExifType.SRATIONAL.GetData(Math.PI);
            //var _ratPI3 = ExifType.SRATIONAL.GetData(Math.PI - 3);
            //var _rat300 = ExifType.SRATIONAL.GetData(300d);
            //var _rat5_6 = ExifType.SRATIONAL.GetData(5.6d);
            //var _rat1_60 = ExifType.SRATIONAL.GetData(0.0166666666666666666666666666d);
            //var _rat0 = ExifType.SRATIONAL.GetData(0d);

            //var _ascii_ = ExifType.ASCII.GetValue(_ascii);
            //var _byte_ = ExifType.BYTE.GetValue(_byte);
            //var _long_ = ExifType.LONG.GetValue(_long);
            //var _slong_ = ExifType.SLONG.GetValue(_slong);
            //var _short_ = ExifType.SHORT.GetValue(_short);
            //var _undef_ = ExifType.UNDEFINED.GetValue(_undef);
            //var _sratPI_ = ExifType.SRATIONAL.GetValue(_sratPI);
            //var _sratPI3_ = ExifType.SRATIONAL.GetValue(_sratPI3);
            //var _srat300_ = ExifType.SRATIONAL.GetValue(_srat300);
            //var _srat5_6_ = ExifType.SRATIONAL.GetValue(_srat5_6);
            //var _srat1_60_ = ExifType.SRATIONAL.GetValue(_srat1_60);
            //var _srat0_ = ExifType.SRATIONAL.GetValue(_srat0);
            //var _ratPI_ = ExifType.SRATIONAL.GetValue(_ratPI);
            //var _ratPI3_ = ExifType.SRATIONAL.GetValue(_ratPI3);
            //var _rat300_ = ExifType.SRATIONAL.GetValue(_rat300);
            //var _rat5_6_ = ExifType.SRATIONAL.GetValue(_rat5_6);
            //var _rat1_60_ = ExifType.SRATIONAL.GetValue(_rat1_60);
            //var _rat0_ = ExifType.SRATIONAL.GetValue(_rat0);

            //double[] d = new double[] {
            //    1d,
            //    5.6d,
            //    300d,
            //    0d,
            //    0.01666666666666666666666666d,
            //    Math.PI,
            //    Math.PI-3
            //};

            //foreach (var item in d)
            //{
            //    object[] objs = new object[4];
            //    objs[0] = item;
            //    int[] results = item.ToInt32s();
            //    objs[3] = (double)((double)(results[0]) / (double)(results[1]));
            //    Array.Copy(results, 0, objs, 1, 2);

            //    Console.WriteLine(string.Format("d:{0} | p1:{1} / p2:{2} | res: {3}", objs));
            //}

            //object test1 = GenericParser.ConvertTo(typeof(OrientationType), 1);

            #endregion

            #region test3

            //DateTime testdate = new DateTime();
            //string testDateValue = "2003-12-14 08:35:03";
            //bool testReturn = DateTime.TryParse(testDateValue, out testdate);

            #endregion

            #region test2

            //FlashType flashType0 = ((short)0);
            //FlashType flashType31 = (FlashType)((short)31);

            //FlashType? flashType255n = ((short)255);
            //FlashType? flashType0n = ((short)0);
            //FlashType? flashType31n = (FlashType)((short)31);
            //FlashType? flashTypeInt32 = 242;

            #endregion

            Photo photo = new Photo();
            photo.ImagePath = FILE_NAME;

            var imgBytes = File.ReadAllBytes(FILE_NAME);
            var ms = new MemoryStream(imgBytes);
            Bitmap bmp = new Bitmap(ms);

            StringBuilder sb = new StringBuilder();

            ExifData exifData = ExifData.CreateInstance(bmp);

            #region hide This
            sb.Append(
                string.Join(
                    "\r\n========\r\n",
                    bmp.PropertyItems
                        .OrderBy(p => p.Id)
                        //.Where(p=>ExifData.PropertyExists(p.Id))
                        //.Where(p => exifData.GetExifProperty(p.Id) == null)
                        .Select(p =>
                            string.Format(
                                "ID: {0} ({1})\r\nType: {2} ({3})\r\nData: {4}\r\nValue: {5}\r\nExists: {6}",
                                ((ExifIdType)p.Id).ToString(),
                                p.Id,
                                ((ExifType)p.Type).ToString(),
                                p.Type,
                                Convert.ToBase64String(p.Value),
                                //ASCIIEncoding.ASCII.GetString(p.Value),
                                exifData.GetExifProperty(p.Id) ?? " === NOT FOUND === ",
                                ExifData.PropertyExists(p.Id)
                                )
                            ).ToArray()
                        )
                    );

            File.WriteAllText(string.Format(@"c:\users\matthew whited\desktop\{0}.txt", Path.GetFileName(FILE_NAME)), sb.ToString());

            #endregion
            //Console.ReadKey();
        }

        public static bool _TryParse(string input, out object result)
        {
            DateTime returnVal;
            if (DateTime.TryParse(input, out returnVal))
            {
                result = returnVal;
                return true;
            }
            else
            {
                result = null;
                return false;
            }
        }

        public static bool _TryParse(string input, out DateTime result)
        {
            return DateTime.TryParse(input, out result);
        }

        public static object _ConvertArray(object input)
        {
            return (short[])input;
        }
    }
}
