using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing.Imaging;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Reflection;
using WhitedUS.Common.Converters;
using System.Drawing;
using System.IO;

namespace WhitedUS.Drawing.Exif
{
    public class ExifData
    {
        public static bool PropertyExists(int id)
        {
            return typeof(ExifData)
                    .GetProperties()
                    .Where(p =>
                        (
                            (p.GetCustomAttributes(typeof(ExifTypeIdAttribute), false).FirstOrDefault() as ExifTypeIdAttribute) ??
                            new ExifTypeIdAttribute(0)
                        ).ID == (ExifIdType)id)
                    .FirstOrDefault() != null;
        }

        public object GetExifProperty(int id)
        {
            return GetExifProperty((ExifIdType)id);
        }

        public object GetExifProperty(ExifIdType exifIdType)
        {
            return this.GetType()
                .GetProperties()
                .Where(p =>
                    (
                        (p.GetCustomAttributes(typeof(ExifTypeIdAttribute), false).FirstOrDefault() as ExifTypeIdAttribute) ??
                        new ExifTypeIdAttribute(0)
                    ).ID == exifIdType)
                .Select(p => (p.GetValue(this, null) ?? "(NULL)"))
                .FirstOrDefault();
        }

        public ExifData()
        {
        }

        private OtherExifDataList _exifData = new OtherExifDataList();
        public OtherExifDataList OtherProperties
        {
            get
            {
                return _exifData;
            }
        }

        public static ExifData CreateInstance(Bitmap bitmap)
        {
            if (bitmap == null)
                return null;

            return CreateInstance(bitmap.PropertyItems);
        }

        public static ExifData CreateInstance(PropertyItem[] items)
        {
            if (items == null || items.Length < 1)
                return null;

            ExifData data = new ExifData();
            var newProps = from p in typeof(ExifData).GetProperties()
                           let ip = p.GetCustomAttributes(typeof(ExifTypeIdAttribute), false).OfType<ExifTypeIdAttribute>().FirstOrDefault()
                           where ip != null
                           select new { PropertyInfo = p, ID = ip.ID };

            var newItems = from i in items
                           select new { ID = (ExifIdType)i.Id, Value = ((ExifType)i.Type).GetValue(i.Value), Type = (ExifType)i.Type };

            var joinedProps = from p in newProps
                              join ii in newItems on p.ID equals ii.ID
                              select new { Prop = p.PropertyInfo, Item = ii };

            var unknownItems =
                from i in items
                join u in newItems.Select(i => i.ID).Except(newProps.Select(p => p.ID)) on ((ExifIdType)i.Id) equals u
                select i;
            data._exifData.AddRange(unknownItems.Select(i => new OtherExifData()
            {
                ID = (ExifIdType)i.Id,
                Type = (ExifType)i.Type,
                Data = i.Value
            }));

            foreach (var prop in joinedProps)
            {
                try
                {
                    object setValue = prop.Item.Value;
                    if (setValue == null)
                        continue;

                    Type propType = prop.Prop.PropertyType;
                    if (propType == null)
                        continue;

                    if (propType == typeof(DateTime) || propType == typeof(DateTime?))
                        setValue = string.Format("{0}-{1}-{2} {3}:{4}:{5}", ((string)setValue).Split(' ', ':'));

                    setValue = GenericParser.ConvertTo(propType, setValue);
                    GenericParser.SetProperty(prop.Prop, data, setValue);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                    //Debug.Assert(false);
                }
            }

            return data;
        }

        #region TIFF Rev. 6.0 Attribute Information Used in Exif

        #region Tags relating to image data structure

        /// <summary>
        /// Image Width
        /// </summary>
        /// <remarks>
        /// ImageWidth
        /// The number of columns of image data, equal to the number of pixels per row. In JPEG compressed data a JPEG
        /// marker is used instead of this tag.
        /// Tag = 256 (100.H)
        /// Type = SHORT or LONG
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ImageWidth)]
        public int? ImageWidth { get; set; }

        /// <summary>
        /// Image Height
        /// </summary>
        /// <remarks>
        /// ImageLength
        /// The number of rows of image data. In JPEG compressed data a JPEG marker is used instead of this tag.
        /// Tag = 257 (101.H)
        /// Type = SHORT or LONG
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ImageLength)]
        public int? ImageLength { get; set; }

        /// <summary>
        /// Number of bits per component
        /// </summary>
        /// <remarks>
        /// BitsPerSample
        /// The number of bits per image component. In this standard each component of the image is 8 bits, so the value for
        /// this tag is 8. See also SamplesPerPixel. In JPEG compressed data a JPEG marker is used instead of this tag.
        /// Tag = 258 (102.H)
        /// Type = SHORT
        /// Count = 3
        /// Default = 8 8 8
        /// </remarks>
        [ExifTypeId(ExifIdType.BitsPerSample)]
        public short[] BitsPerSample { get; set; }

        /// <summary>
        /// Compression Scheme
        /// </summary>
        /// <remarks>
        /// Compression
        /// The compression scheme used for the image data. When a primary image is JPEG compressed, this designation is
        /// not necessary and is omitted. When thumbnails use JPEG compression, this tag value is set to 6.
        /// Tag = 259 (103.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 1 = uncompressed
        /// 6 = JPEG compression (thumbnails only)
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.Compression)]
        public CompressionType? Compression { get; set; }

        /// <summary>
        /// Pixel composition
        /// </summary>
        /// <remarks>
        /// PhotometricInterpretation
        /// The pixel composition. In JPEG compressed data a JPEG marker is used instead of this tag.
        /// Tag = 262 (106.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 2 = RGB
        /// 6 = YCbCr
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.PhotoMetricInterpertation)]
        public PhotoMetricInterpertationType? PhotoMetricInterpertation { get; set; }

        /// <summary>
        /// Orientation of image
        /// </summary>
        /// <remarks>
        /// Orientation
        /// The image orientation viewed in terms of rows and columns.
        /// Tag = 274 (112.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 1
        /// 1 = The 0th row is at the visual top of the image, and the 0th column is the visual left-hand side.
        /// 2 = The 0th row is at the visual top of the image, and the 0th column is the visual right-hand side.
        /// 3 = The 0th row is at the visual bottom of the image, and the 0th column is the visual right-hand side.
        /// 4 = The 0th row is at the visual bottom of the image, and the 0th column is the visual left-hand side.
        /// 5 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual top.
        /// 6 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual top.
        /// 7 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual bottom.
        /// 8 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual bottom.
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.Orientation)]
        public OrientationType? Orientation { get; set; }

        /// <summary>
        /// Number of components
        /// </summary>
        /// <remarks>
        /// SamplesPerPixel
        /// The number of components per pixel. Since this standard applies to RGB and YCbCr images, the value set for this
        /// tag is 3. In JPEG compressed data a JPEG marker is used instead of this tag.
        /// Tag = 277 (115.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 3
        /// </remarks>
        [ExifTypeId(ExifIdType.SamplesPerPixel)]
        public short? SamplesPerPixel { get; set; }

        /// <summary>
        /// Image data arrangement
        /// </summary>
        /// <remarks>
        /// PlanarConfiguration
        /// Indicates whether pixel components are recorded in chunky or planar format. In JPEG compressed files a JPEG
        /// marker is used instead of this tag. If this field does not exist, the TIFF default of 1 (chunky) is assumed.
        /// Tag = 284 (11C.H)
        /// Type = SHORT
        /// Count = 1
        /// 1 = chunky format
        /// 2 = planar format
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.PlanarConfiguration)]
        public PlanarConfigurationType? PlanarConfiguration { get; set; }

        /// <summary>
        /// Subsampling ration of Y to C
        /// </summary>
        /// <remarks>
        /// YCbCrSubSampling
        /// The sampling ratio of chrominance components in relation to the luminance component. In JPEG compressed data
        /// a JPEG marker is used instead of this tag.
        /// Tag = 530 (212.H)
        /// Type = SHORT
        /// Count = 2
        /// [2, 1] = YCbCr4:2:2
        /// [2, 2] = YCbCr4:2:0
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.YCbCrSubsampling)]
        public YCbCrSubsamplingType? YCbCrSubsampling { get; set; }

        /// <summary>
        /// Y and C positioning
        /// </summary>
        /// <remarks>
        /// YCbCrPositioning
        /// The position of chrominance components in relation to the luminance component. This field is designated only for
        /// JPEG compressed data or uncompressed YCbCr data. The TIFF default is 1 (centered); but when Y:Cb:Cr = 4:2:2
        /// it is recommended in this standard that 2 (co-sited) be used to record data, in order to improve the image quality
        /// when viewed on TV systems. When this field does not exist, the reader shall assume the TIFF default. In the case
        /// of Y:Cb:Cr = 4:2:0, the TIFF default (centered) is recommended. If the reader does not have the capability of
        /// supporting both kinds of YCbCrPositioning, it shall follow the TIFF default regardless of the value in this field. It is
        /// preferable that readers be able to support both centered and co-sited positioning.
        /// Tag = 531 (213.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 1
        /// 1 = centered
        /// 2 = co-sited
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.YCbCrPositioning)]
        public YCbCrPositioningType? YCbCrPositioning { get; set; }

        /// <summary>
        /// Image resolution in width direction
        /// </summary>
        /// <remarks>
        /// XResolution
        /// The number of pixels per ResolutionUnit in the ImageWidth direction. When the image resolution is unknown, 72
        /// [dpi] is designated.
        /// Tag = 282 (11A.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = 72
        /// </remarks>
        [ExifTypeId(ExifIdType.XResolution)]
        public ExifRational XResolution { get; set; }

        /// <summary>
        /// Image resolution in height direction
        /// </summary>
        /// <remarks>
        /// YResolution
        /// The number of pixels per ResolutionUnit in the ImageLength direction. The same value as XResolution is
        /// designated.
        /// Tag = 283 (11B.H)
        /// Type = RATIONAL
        /// Count = 1
        /// </remarks>
        [ExifTypeId(ExifIdType.YResolution)]
        public ExifRational YResolution { get; set; }

        /// <summary>
        /// Unit of X and Y resolution
        /// </summary>
        /// <remarks>
        /// 128
        /// </remarks>
        [ExifTypeId(ExifIdType.ResolutionUnit)]
        public short? ResolutionUnit { get; set; }

        #endregion

        #region Tags relating to recoding offset

        /// <summary>
        /// Image data Location
        /// </summary>
        /// <remarks>
        /// 0x111
        /// *S
        /// </remarks>
        [ExifTypeId(ExifIdType.StripOffset)]
        public int? StripOffset { get; set; }

        /// <summary>
        /// Number of rows per strip
        /// </summary>
        /// <remarks>
        /// 0x116
        /// </remarks>
        [ExifTypeId(ExifIdType.RowsPerStrip)]
        public int? RowsPerStrip { get; set; }

        /// <summary>
        /// Bytes per compressed strip
        /// </summary>
        /// <remarks>
        /// 0x117
        /// S*
        /// </remarks>
        [ExifTypeId(ExifIdType.StripBytesCount)]
        public int? StripBytesCount { get; set; }

        /// <summary>
        /// Offset to JPEG SOI
        /// </summary>
        /// <remarks>
        /// 0x201
        /// </remarks>
        [ExifTypeId(ExifIdType.JPEGInterchangeFormat)]
        public int? JPEGInterchangeFormat { get; set; }

        /// <summary>
        /// Bytes of JPEG data
        /// </summary>
        /// <remarks>
        /// JPEGInterchangeFormatLength
        /// The number of bytes of JPEG compressed thumbnail data. This is not used for primary image JPEG data. JPEG
        /// thumbnails are not divided but are recorded as a continuous JPEG bitstream from SOI to EOI. APPn and COM
        /// markers should not be recorded. Compressed thumbnails shall be recorded in no more than 64 Kbytes, including
        /// all other data to be recorded in APP1.
        /// Tag = 514 (202.H)
        /// Type = LONG
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.JPEGInterchangeFormatLength)]
        public int? JPEGInterchangeFormatLength { get; set; }

        #endregion

        #region Tags relating to image data characteristics

        /// <summary>
        /// Transfer function
        /// </summary>
        /// <remarks>
        /// TransferFunction
        /// A transfer function for the image, described in tabular style. Normally this tag is not necessary, since color space is
        /// specified in the color space information tag (ColorSpace).
        /// Tag = 301 (12D.H)
        /// Type = SHORT
        /// Count = 3 * 256
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.TransferFunction)]
        public short[] TransferFunction { get; set; }

        /// <summary>
        /// White point chromaticity
        /// </summary>
        /// <remarks>
        /// WhitePoint
        /// The chromaticity of the white point of the image. Normally this tag is not necessary, since color space is specified in
        /// the color space information tag (ColorSpace).
        /// Tag = 318 (13E.H)
        /// Type = RATIONAL
        /// Count = 2
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.WhitePoint)]
        public float[] WhitePoint { get; set; }

        /// <summary>
        /// Chromaticities of primaries
        /// </summary>
        /// <remarks>
        /// PrimaryChromaticities
        /// The chromaticity of the three primary colors of the image. Normally this tag is not necessary, since color space is
        /// specified in the color space information tag (ColorSpace).
        /// Tag = 319 (13F.H)
        /// Type = RATIONAL
        /// Count = 6
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.PrimaryChromaticities)]
        public float[] PrimaryChromaticities { get; set; }

        /// <summary>
        /// Color spae transformation matrix coefficients
        /// </summary>
        /// <remarks>
        /// YCbCrCoefficients
        /// The matrix coefficients for transformation from RGB to YCbCr image data. No default is given in TIFF; but here the
        /// characteristics given in Annex E, "Color Space Guidelines," is used as the default.
        /// Tag = 529 (211.H)
        /// Type = RATIONAL
        /// Count = 3
        /// Default = See Annex E
        /// </remarks>
        [ExifTypeId(ExifIdType.YCbCrCoefficients)]
        public float[] YCbCrCoefficients { get; set; }

        /// <summary>
        /// Pair of black and white reference values
        /// </summary>
        /// <remarks>
        /// ReferenceBlackWhite
        /// The reference black point value and reference white point value. No defaults are given in TIFF, but the values
        /// below are given as defaults here. The color space is declared in a color space information tag, with the default
        /// being the value that gives the optimal image characteristics Interoperability these conditions.
        /// Tag = 532 (214.H)
        /// Type = RATIONAL
        /// Count = 6
        /// Default = [0, 255, 0, 255, 0, 255] (when PhotometricInterpretation is RGB)
        ///           [0, 255, 0, 128, 0, 128] (when PhotometricInterpretation is YCbCr)
        /// </remarks>
        [ExifTypeId(ExifIdType.ReferenceBlackWhite)]
        public float[] ReferenceBlackWhite { get; set; }

        #endregion

        #region Other tags

        /// <summary>
        /// File change date and time
        /// </summary>
        /// <remarks>
        /// DateTime
        /// The date and time of image creation. In this standard it is the date and time the file was changed. The format is
        /// "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format, and the date and time separated by one blank
        /// character [20.H]. When the date and time are unknown, all the character spaces except colons (":") may be filled
        /// with blank characters, or else the Interoperability field may be filled with blank characters. The character string
        /// length is 20 bytes including NULL for termination. When the field is left blank, it is treated as unknown.
        /// Tag = 306 (132.H)
        /// Type = ASCII
        /// Count = 20
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.DateTime)]
        public DateTime? DateTimeValue { get; set; }

        /// <summary>
        /// Image title
        /// </summary>
        /// <remarks>
        /// ImageDescription
        /// A character string giving the title of the image. It may be a comment such as "1988 company picnic" or the like.
        /// Two-byte character codes cannot be used. When a 2-byte code is necessary, the Exif Private tag UserComment is
        /// to be used.
        /// Tag = 270 (10E.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ImageDescription)]
        public string ImageDescription { get; set; }

        /// <summary>
        /// Image input equipment manufacturer
        /// </summary>
        /// <remarks>
        /// Make
        /// The manufacturer of the recording equipment. This is the manufacturer of the DSC, scanner, video digitizer or other
        /// equipment that generated the image. When the field is left blank, it is treated as unknown.
        /// Tag = 271 (10F.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.Make)]
        public string Make { get; set; }

        /// <summary>
        /// Image input equipment model
        /// </summary>
        /// <remarks>
        /// Model
        /// The model name or model number of the equipment. This is the model name of number of the DSC, scanner, video
        /// digitizer or other equipment that generated the image. When the field is left blank, it is treated as unknown.
        /// Tag = 272 (110.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.Model)]
        public string Model { get; set; }

        /// <summary>
        /// Software used
        /// </summary>
        /// <remarks>
        /// Software
        /// This tag records the name and version of the software or firmware of the camera or image input device used to
        /// generate the image. The detailed format is not specified, but it is recommended that the example shown below be
        /// followed. When the field is left blank, it is treated as unknown.
        /// Ex.) "Exif Software Version 1.00a"
        /// Tag = 305 (131h)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.Software)]
        public string Software { get; set; }

        /// <summary>
        /// Person who created the image
        /// </summary>
        /// <remarks>
        /// Artist
        /// This tag records the name of the camera owner, photographer or image creator. The detailed format is not specified,
        /// but it is recommended that the information be written as in the example below for ease of Interoperability. When the
        /// field is left blank, it is treated as unknown.
        /// Ex.) "Camera owner, John Smith; Photographer, Michael Brown; Image creator, Ken James"
        /// Tag = 315 (13Bh)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.Artist)]
        public string Artist { get; set; }

        /// <summary>
        /// Copyright holder
        /// </summary>
        /// <remarks>
        /// Copyright
        /// Copyright information. In this standard the tag is used to indicate both the photographer and editor copyrights. It is
        /// the copyright notice of the person or organization claiming rights to the image. The Interoperability copyright
        /// statement including date and rights should be written in this field; e.g., "Copyright, John Smith, 19xx. All rights
        /// reserved." In this standard the field records both the photographer and editor copyrights, with each recorded in a
        /// separate part of the statement. When there is a clear distinction between the photographer and editor copyrights,
        /// these are to be written in the order of photographer followed by editor copyright, separated by NULL (in this case,
        /// since the statement also ends with a NULL, there are two NULL codes) (see example 1). When only the
        /// photographer copyright is given, it is terminated by one NULL code (see example 2). When only the editor
        /// copyright is given, the photographer copyright part consists of one space followed by a terminating NULL code,
        /// then the editor copyright is given (see example 3). When the field is left blank, it is treated as unknown.
        /// Ex. 1) When both the photographer copyright and editor copyright are given.
        /// Photographer copyright + NULL[00.H] + editor copyright + NULL[00.H]
        /// Ex. 2) When only the photographer copyright is given.
        /// Photographer copyright + NULL[00.H]
        /// Ex. 3) When only the editor copyright is given.
        /// Space[20.H]+ NULL[00.H] + editor copyright + NULL[00.H]
        /// Tag = 33432 (8298.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.Copyright)]
        public string Copyright { get; set; }

        #endregion

        #endregion

        #region Exif IFD Attribute Information

        #region Tags relating to version

        /// <summary>
        /// Exif Version
        /// </summary>
        /// <remarks>
        /// ExifVersion
        /// The version of this standard supported. Nonexistence of this field is taken to mean nonconformance to the standard
        /// (see section 4.2). Conformance to this standard is indicated by recording "0220" as 4-byte ASCII. Since the type is
        /// UNDEFINED, there is no NULL for termination.
        /// Tag = 36864 (9000.H)
        /// Type = UNDEFINED
        /// Count = 4
        /// Default = "0220"
        /// </remarks>
        [ExifTypeId(ExifIdType.ExifVersion)]
        public string ExifVersion { get; set; }

        /// <summary>
        /// Supported Flashpix version
        /// </summary>
        /// <remarks>
        /// FlashpixVersion
        /// The Flashpix format version supported by a FPXR file. If the FPXR function supports Flashpix format Ver. 1.0, this
        /// is indicated similarly to ExifVersion by recording "0100" as 4-byte ASCII. Since the type is UNDEFINED, there is no
        /// NULL for termination.
        /// Tag = 40960(A000.H)
        /// Type = UNDEFINED
        /// Count = 4
        /// Default = "0100"
        /// 0100 = Flashpix Format Version 1.0
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.FlashpixVersion)]
        public string FlashpixVersion { get; set; }

        #endregion

        #region Tag Relating to Image Data Characteristics

        /// <summary>
        /// Color space information
        /// </summary>
        /// <remarks>
        /// ColorSpace
        /// The color space information tag (ColorSpace) is always recorded as the color space specifier.
        /// Normally sRGB (=1) is used to define the color space based on the PC monitor conditions and environment. If a
        /// color space other than sRGB is used, Uncalibrated (=FFFF.H) is set. Image data recorded as Uncalibrated can be
        /// treated as sRGB when it is converted to Flashpix. On sRGB see Annex E.
        /// Tag = 40961 (A001.H)
        /// Type = SHORT
        /// Count = 1
        /// 1 = sRGB
        /// FFFF.H = Uncalibrated
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.ColorSpace)]
        public ColorSpaceType? ColorSpace { get; set; }

        #endregion

        #region Tags relating to Image Configuration

        /// <summary>
        /// Meaning of each component
        /// </summary>
        /// <remarks>
        /// ComponentsConfiguration
        /// Information specific to compressed data. The channels of each component are arranged in order from the 1st
        /// component to the 4th. For uncompressed data the data arrangement is given in the PhotometricInterpretation tag.
        /// However, since PhotometricInterpretation can only express the order of Y,Cb and Cr, this tag is provided for cases
        /// when compressed data uses components other than Y, Cb, and Cr and to enable support of other sequences.
        /// Tag = 37121 (9101.H)
        /// Type = UNDEFINED
        /// Count = 4
        /// Default = 4 5 6 0 (if RGB uncompressed)
        /// 1 2 3 0 (other cases)
        /// 0 = does not exist
        /// 1 = Y
        /// 2 = Cb
        /// 3 = Cr
        /// 4 = R
        /// 5 = G
        /// 6 = B
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.ComponentsConfiguration)]
        public byte[] ComponentsConfiguration { get; set; }

        /// <summary>
        /// Image compression mode
        /// </summary>
        /// <remarks>
        /// CompressedBitsPerPixel
        /// Information specific to compressed data. The compression mode used for a compressed image is indicated in unit
        /// bits per pixel.
        /// Tag = 37122 (9102.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.CompressedBitsPerPixel)]
        public ExifRational CompressedBitsPerPixel { get; set; }

        /// <summary>
        /// Valid Image Width
        /// </summary>
        /// <remarks>
        /// PixelXDimension
        /// Information specific to compressed data. When a compressed file is recorded, the valid width of the meaningful
        /// image shall be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not
        /// exist in an uncompressed file. For details see section 2.8.1 and Annex F.
        /// Tag = 40962 (A002.H)
        /// Type = SHORT or LONG
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.PixelXDimension)]
        public int? PixelXDimension { get; set; }

        /// <summary>
        /// Valid image height
        /// </summary>
        /// <remarks>
        /// PixelYDimension
        /// Information specific to compressed data. When a compressed file is recorded, the valid height of the meaningful
        /// image shall be recorded in this tag, whether or not there is padding data or a restart marker. This tag should not
        /// exist in an uncompressed file. For details see section 2.8.1 and Annex F. Since data padding is unnecessary in the
        /// vertical direction, the number of lines recorded in this valid image height tag will in fact be the same as that
        /// recorded in the SOF.
        /// Tag = 40963 (A003.H)
        /// Type = SHORT of LONG
        /// Count = 1
        /// </remarks>
        [ExifTypeId(ExifIdType.PixelYDimension)]
        public int? PixelYDimension { get; set; }

        #endregion

        #region Tags relating to user information

        /// <summary>
        /// Manufacturer notes
        /// </summary>
        /// <remarks>
        /// MakerNote
        /// A tag for manufacturers of Exif writers to record any desired information. The contents are up to the manufacturer,
        /// but this tag should not be used for any other than its intended purpose.
        /// Tag = 37500 (927C.H)
        /// Type = UNDEFINED
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.MakerNote)]
        public byte[] MakerNote { get; set; }

        /// <summary>
        /// User Comments
        /// </summary>
        /// <remarks>
        /// UserComment
        /// A tag for Exif users to write keywords or comments on the image besides those in ImageDescription, and without
        /// the character code limitations of the ImageDescription tag.
        /// Tag = 37510 (9286.H)
        /// Type = UNDEFINED
        /// Count = Any
        /// Default = none
        /// 
        /// The character code used in the UserComment tag is identified based on an ID code in a fixed 8-byte area at the
        /// start of the tag data area. The unused portion of the area is padded with NULL ("00.H"). ID codes are assigned by
        /// means of registration. The designation method and references for each character code are given in Table 6 . The
        /// value of Count N is determined based on the 8 bytes in the character code area and the number of bytes in the
        /// user comment part. Since the TYPE is not ASCII, NULL termination is not necessary (see Figure 9).
        /// Table 6 Character Codes and their Designation
        /// Character Code Code Designation (8 Bytes) References
        /// ASCII 41.H, 53.H, 43.H, 49.H, 49.H, 00.H, 00.H, 00.H ITU-T T.50 IA5
        /// JIS 4A.H, 49.H, 53.H, 00.H, 00.H, 00.H, 00.H, 00.H JIS X208-1990
        /// Unicode 55.H, 4E.H, 49.H, 43.H, 4F.H, 44.H, 45.H, 00.H Unicode Standard
        /// Undefined 00.H, 00.H, 00.H, 00.H, 00.H, 00.H, 00.H, 00.H Undefined
        /// 
        /// The ID code for the UserComment area may be a Defined code such as JIS or ASCII, or may be Undefined. The
        /// Undefined name is UndefinedText, and the ID code is filled with 8 bytes of all "NULL" ("00.H"). An Exif reader that
        /// reads the UserComment tag shall have a function for determining the ID code. This function is not required in Exif
        /// readers that do not use the UserComment tag (see Table 7).
        /// 
        /// ID Code Exif Reader Implementation
        /// Defined
        /// (JIS, ASCII, etc.) Determines the ID code and displays it in accord with the reader capability.
        /// Undefined
        /// (all NULL)
        /// Depends on the localized PC in each country. (If a character code is used for
        /// which there is no clear specification like Shift-JIS in Japan, Undefined is used.)
        /// Although the possibility of unreadable characters exists, display of these
        /// characters is left as a matter of reader implementation.
        /// When a UserComment area is set aside, it is recommended that the ID code be ASCII and that the following user
        /// comment part be filled with blank characters [20.H].
        /// </remarks>
        [ExifTypeId(ExifIdType.UserComment)]
        public byte[] UserCommentData { get; set; }

        public string UserComment
        {
            get
            {
                if (UserCommentData != null && UserCommentData.Length >= 8)
                {
                    Encoding encoding;
                    switch (ASCIIEncoding.ASCII.GetString(UserCommentData, 0, 8))
                    {
                        case "ASCII\0\0\0":
                            encoding = ASCIIEncoding.ASCII;
                            break;

                        case "UNICODE\0":
                            encoding = UTF8Encoding.Unicode;
                            break;

                        case "JIS\0\0\0\0\0":
                        default:
                            encoding = UTF32Encoding.Default;
                            break;
                    }

                    if (encoding != null)
                        return encoding.GetString(UserCommentData, 8, UserCommentData.Length - 8).Trim();
                }
                return null;
            }
            set
            {
                Encoding encoding = null;
                string header = null;
                if (UserCommentData != null && UserCommentData.Length >= 8)
                {
                    header = ASCIIEncoding.ASCII.GetString(UserCommentData, 0, 8);
                    switch (header)
                    {
                        case "ASCII\0\0\0":
                            encoding = ASCIIEncoding.ASCII;
                            break;

                        case "UNICODE\0":
                            encoding = UTF8Encoding.Unicode;
                            break;

                        case "JIS\0\0\0\0\0":
                        default:
                            encoding = UTF32Encoding.Default;
                            break;
                    }
                }
                if (encoding == null || string.IsNullOrEmpty(header) || header.Length < 8)
                {
                    header = "ASCII\0\0\0";
                    encoding = ASCIIEncoding.ASCII;
                }
                byte[] body = null;
                if (!string.IsNullOrEmpty(value))
                    body = encoding.GetBytes(value);
                byte[] comment = new byte[(body ?? new byte[0]).Length + 8];
                Array.Copy(ASCIIEncoding.ASCII.GetBytes(header), 0, comment, 0, 8);

                if (body != null && body.Length > 0)
                    Array.Copy(body, 0, comment, 8, body.Length);

                UserCommentData = comment;
            }
        }

        #endregion

        #region Tag relating to related file information

        /// <summary>
        /// Related audio file
        /// </summary>
        /// <remarks>
        /// RelatedSoundFile
        /// This tag is used to record the name of an audio file related to the image data. The only relational information
        /// recorded here is the Exif audio file name and extension (an ASCII string consisting of 8 characters + '.' + 3
        /// characters). The path is not recorded. Stipulations on audio are given in section 0. File naming conventions are
        /// given in section 0.
        /// When using this tag, audio files shall be recorded in conformance to the Exif audio format. Writers are also allowed
        /// to store the data such as Audio within APP2 as Flashpix extension stream data.
        /// Audio files shall be recorded in conformance to the Exif audio format.
        /// The mapping of Exif image files and audio files is done in any of the three ways shown in Table 8. If multiple files
        /// are mapped to one file as in [2] or [3] of this table, the above format is used to record just one audio file name. If
        /// there are multiple audio files, the first recorded file is given.
        /// In the case of [3] in Table 8, for example, for the Exif image file "DSC00001.JPG" only "SND00001.WAV" is given
        /// as the related Exif audio file.
        /// When there are three Exif audio files "SND00001.WAV", "SND00002.WAV" and "SND00003.WAV", the Exif image
        /// file name for each of them, "DSC00001.JPG," is indicated. By combining multiple relational information, a variety of
        /// playback possibilities can be supported. The method of using relational information is left to the implementation on
        /// the playback side. Since this information is an ASCII character string, it is terminated by NULL.
        /// 
        /// When this tag is used to map audio files, the relation of the audio file to image data shall also be indicated on the
        /// audio file end.
        /// Tag = 40964 (A004.H)
        /// Type = ASCII
        /// Count = 13
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.RelatedSoundFile)]
        public string RelatedSoundFile { get; set; }

        #endregion

        #region Tags relating to Date and Time

        /// <summary>
        /// Date and time of oringinal data generation
        /// </summary>
        /// <remarks>
        /// DateTimeOriginal
        /// The date and time when the original image data was generated. For a DSC the date and time the picture was taken
        /// are recorded. The format is "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format, and the date and time
        /// separated by one blank character [20.H]. When the date and time are unknown, all the character spaces except
        /// colons (":") may be filled with blank characters, or else the Interoperability field may be filled with blank characters.
        /// The character string length is 20 bytes including NULL for termination. When the field is left blank, it is treated as
        /// unknown.
        /// Tag = 36867 (9003.H)
        /// Type = ASCII
        /// Count = 20
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.DateTimeOriginal)]
        public DateTime? DateTimeOriginal { get; set; }

        /// <summary>
        /// Date and Time of digital data generation
        /// </summary>
        /// <remarks>
        /// DateTimeDigitized
        /// The date and time when the image was stored as digital data. If, for example, an image was captured by DSC and at the same
        /// time the file was recorded, then the DateTimeOriginal and DateTimeDigitized will have the same contents. The format is
        /// "YYYY:MM:DD HH:MM:SS" with time shown in 24-hour format, and the date and time separated by one blank character [20.H].
        /// When the date and time are unknown, all the character spaces except colons (":") may be filled with blank characters, or else
        /// the Interoperability field may be filled with blank characters. The character string length is 20 bytes including NULL for
        /// termination. When the field is left blank, it is treated as unknown.
        /// Tag = 36868 (9004.H)
        /// Type = ASCII
        /// Count = 20
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.DateTimeDigitized)]
        public DateTime? DateTimeDigitized { get; set; }

        /// <summary>
        /// DateTime subseconds
        /// </summary>
        /// <remarks>
        /// SubsecTime
        /// A tag used to record fractions of seconds for the DateTime tag.
        /// Tag = 37520 (9290.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.SubSecTime)]
        public int? SubSecTime { get; set; }

        /// <summary>
        /// DateTimeOriginal subseconds
        /// </summary>
        /// <remarks>
        /// SubsecTimeOriginal
        /// A tag used to record fractions of seconds for the DateTimeOriginal tag.
        /// Tag = 37521 (9291.H)
        /// Type = ASCII
        /// N = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.SubSecTimeOriginal)]
        public int? SubSecTimeOriginal { get; set; }

        /// <summary>
        /// DateTimeDigitized subseconds
        /// </summary>
        /// <remarks>
        /// SubsecTimeDigitized
        /// A tag used to record fractions of seconds for the DateTimeDigitized tag.
        /// Tag = 37522 (9292.H)
        /// Type = ASCII
        /// N = Any
        /// Default = none
        /// Note－Recording subsecond data (SubsecTime, SubsecTimeOriginal, SubsecTimeDigitized)
        /// The tag type is ASCII and the string length including NULL is variable length. When the number of valid
        /// digits is up to the second decimal place, the subsecond value goes in the Value position. When it is up to
        /// four decimal places, an address value is Interoperability, with the subsecond value put in the location
        /// pointed to by that address. (Since the count of ASCII type field Interoperability is a value that includes
        /// NULL, when the number of valid digits is up to four decimal places the count is 5, and the offset value goes
        /// in the Value Offset field. See section 2.6.2.) Note that the subsecond tag differs from the DateTime tag and
        /// other such tags already defined in TIFF Rev. 6.0, and that both are recorded in the Exif IFD.
        /// Ex.: September 9, 1998, 9:15:30.130 (the number of valid digits is up to the third decimal place)
        /// DateTime 1996:09:01 09:15:30 [NULL]
        /// SubSecTime 130 [NULL]
        /// If the string length is longer than the number of valid digits, the digits are aligned with the start of the area
        /// and the rest is filled with blank characters [20.H]. If the subsecond data is unknown, the Interoperability
        /// area can be filled with blank characters.
        /// Examples when subsecond data is 0.130 seconds:
        /// Ex. 1) '1','3','0',[NULL]
        /// Ex. 2) '1','3','0',[20.H],[NULL]
        /// Ex. 3) '1','3','0', [20.H], [20.H], [20.H], [20.H], [20.H], [NULL]
        /// Example when subsecond data is unknown:
        /// Ex. 4) [20.H], [20.H], [20.H], [20.H], [20.H], [20.H], [20.H], [20.H], [NULL]
        /// </remarks>
        [ExifTypeId(ExifIdType.SubSecTimeDigitized)]
        public int? SubSecTimeDigitized { get; set; }

        #endregion

        #region Tags Relating to Picture-Taking Conditions

        /// <summary>
        /// Exposure Time
        /// </summary>
        /// <remarks>
        /// ExposureTime
        /// Exposure time, given in seconds (sec).
        /// Tag = 33434 (829A.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ExposureTime)]
        public ExifRational ExposureTime { get; set; }

        /// <summary>
        /// F number
        /// </summary>
        /// <remarks>
        /// FNumber
        /// The F number.
        /// Tag = 33437 (829D.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FNumber)]
        public ExifRational FNumber { get; set; }

        /// <summary>
        /// Exposure program
        /// </summary>
        /// <remarks>
        /// ExposureProgram
        /// The class of the program used by the camera to set exposure when the picture is taken. The tag values are as
        /// follows.
        /// Tag = 34850 (8822.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Not defined
        /// 1 = Manual
        /// 2 = Normal program
        /// 3 = Aperture priority
        /// 4 = Shutter priority
        /// 5 = Creative program (biased toward depth of field)
        /// 6 = Action program (biased toward fast shutter speed)
        /// 7 = Portrait mode (for closeup photos with the background out of focus)
        /// 8 = Landscape mode (for landscape photos with the background in focus)
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.ExposureProgram)]
        public ExposureProgramType? ExposureProgram { get; set; }

        /// <summary>
        /// Spectral sensitivity
        /// </summary>
        /// <remarks>
        /// SpectralSensitivity
        /// Indicates the spectral sensitivity of each channel of the camera used. The tag value is an ASCII string compatible
        /// with the standard developed by the ASTM Technical committee.
        /// Tag = 34852 (8824.H)
        /// Type = ASCII
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.SpectralSensitivity)]
        public string SpectralSensitivity { get; set; }

        /// <summary>
        /// ISO Speed rating
        /// </summary>
        /// <remarks>
        /// ISOSpeedRatings
        /// Indicates the ISO Speed and ISO Latitude of the camera or input device as specified in ISO 12232.
        /// Tag = 34855 (8827.H)
        /// Type = SHORT
        /// Count = Any
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ISOSpeedRatings)]
        public short? ISOSpeedRatings { get; set; }

        /// <summary>
        /// Optoelectric conversion factor
        /// </summary>
        /// <remarks>
        /// OECF
        /// Indicates the Opto-Electric Conversion Function (OECF) specified in ISO 14524. OECF is the relationship between
        /// the camera optical input and the image values.
        /// Tag = 34856 (8828.H)
        /// Type = UNDEFINED
        /// Count = ANY
        /// Default = none
        /// 
        /// When this tag records an OECF of m rows and n columns, the values are as in Figure 10.
        /// Length Type Meaning
        /// 2 SHORT Columns = n
        /// 2 SHORT Rows = m
        /// Any ASCII 0th column item name (NULL terminated)
        /// : : :
        /// Any ASCII n-1th column item name (NULL terminated)
        /// 8 SRATIONAL OECF value [0,0]
        /// : : :
        /// 8 SRATIONAL OECF value [n-1,0]
        /// 8 SRATIONAL OECF value [0,m-1]
        /// : : :
        /// 8 SRATIONAL OECF value [n-1,m-1]
        /// Figure 10 OECF Description
        /// Table 9 gives a simple example.
        /// Table 9 Example of Exposure and RGB Output Level
        /// Camera log Aperture R Output Level G Output Level B Output Level
        /// -3.0 10.2 12.4 8.9
        /// -2.0 48.1 47.5 48.3
        /// -1.0 150.2 152.0 149.8
        /// </remarks>
        [ExifTypeId(ExifIdType.OptoelectricConversionFactor)]
        public byte[] OECF { get; set; }

        /// <summary>
        /// Shutter speed
        /// </summary>
        /// <remarks>
        /// ShutterSpeedValue
        /// Shutter speed. The unit is the APEX (Additive System of Photographic Exposure) setting (see Annex C).
        /// Tag = 37377 (9201.H)
        /// Type = SRATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ShutterSpeedValue)]
        public ExifSRational ShutterSpeedValue { get; set; }

        /// <summary>
        /// Aperture
        /// </summary>
        /// <remarks>
        /// ApertureValue
        /// The lens aperture. The unit is the APEX value.
        /// Tag = 37378 (9202.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ApertureValue)]
        public ExifRational ApertureValue { get; set; }

        /// <summary>
        /// Brightness
        /// </summary>
        /// <remarks>
        /// BrightnessValue
        /// The value of brightness. The unit is the APEX value. Ordinarily it is given in the range of -99.99 to 99.99. Note that
        /// if the numerator of the recorded value is FFFFFFFF.H, Unknown shall be indicated.
        /// Tag = 37379 (9203.H)
        /// Type = SRATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.BrightnessValue)]
        public ExifSRational BrightnessValue { get; set; }

        /// <summary>
        /// Exposure Bias
        /// </summary>
        /// <remarks>
        /// ExposureBiasValue
        /// The exposure bias. The unit is the APEX value. Ordinarily it is given in the range of –99.99 to 99.99.
        /// Tag = 37380 (9204.H)
        /// Type = SRATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ExposureBiasValue)]
        public ExifSRational ExposureBiasValue { get; set; }

        /// <summary>
        /// Max Aperture
        /// </summary>
        /// <remarks>
        /// MaxApertureValue
        /// The smallest F number of the lens. The unit is the APEX value. Ordinarily it is given in the range of 00.00 to 99.99,
        /// but it is not limited to this range.
        /// Tag = 37381 (9205.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.MaxApertureValue)]
        public ExifRational MaxApertureValue { get; set; }

        /// <summary>
        /// Subject Distance
        /// </summary>
        /// <remarks>
        /// SubjectDistance
        /// The distance to the subject, given in meters. Note that if the numerator of the recorded value is FFFFFFFF.H,
        /// Infinity shall be indicated; and if the numerator is 0, Distance unknown shall be indicated.
        /// Tag = 37382 (9206.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.SubjectDistance)]
        public ExifRational SubjectDistance { get; set; }

        /// <summary>
        /// Metering Mode
        /// </summary>
        [ExifTypeId(ExifIdType.MeteringMode)]
        public MeteringModeType? MeteringMode { get; set; }

        /// <summary>
        /// Light Source
        /// </summary>
        [ExifTypeId(ExifIdType.LightSource)]
        public LightSourceType? LightSource { get; set; }

        /// <summary>
        /// Flash
        /// </summary>
        [ExifTypeId(ExifIdType.Flash)]
        public FlashType Flash { get; set; }

        /// <summary>
        /// SubjectArea 
        /// </summary>
        /// <remarks>
        /// SubjectArea
        /// This tag indicates the location and area of the main subject in the overall scene.
        /// Tag = 37396 (9214.H)
        /// Type = SHORT
        /// Count = 2 or 3 or 4
        /// Default = none
        /// The subject location and area are defined by Count values as follows.
        /// Count = 2 Indicates the location of the main subject as coordinates. The first value is the X coordinate and the
        /// second is the Y coordinate.
        /// Count = 3 The area of the main subject is given as a circle. The circular area is expressed as center coordinates
        /// and diameter. The first value is the center X coordinate, the second is the center Y coordinate, and the
        /// third is the diameter. (See Figure 12.)
        /// Count = 4 The area of the main subject is given as a rectangle. The rectangular area is expressed as center
        /// coordinates and area dimensions. The first value is the center X coordinate, the second is the center Y
        /// coordinate, the third is the width of the area, and the fourth is the height of the area. (See Figure 13.)
        /// Note that the coordinate values, width, and height are expressed in relation to the upper left as origin, prior to
        /// rotation processing as per the Rotation tag.
        /// </remarks>
        [ExifTypeId(ExifIdType.SubjectArea)]
        public short[] SubjectArea { get; set; }

        /// <summary>
        /// Focal Length
        /// </summary>
        /// <remarks>
        /// FocalLength
        /// The actual focal length of the lens, in mm. Conversion is not made to the focal length of a 35 mm film camera.
        /// Tag = 37386 (920A.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FocalLength)]
        public ExifRational FocalLength { get; set; }

        /// <summary>
        /// Flash Energy
        /// </summary>
        /// <remarks>
        ///  FlashEnergy
        /// Indicates the strobe energy at the time the image is captured, as measured in Beam Candle Power Seconds
        /// (BCPS).
        /// Tag = 41483 (A20B.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FlashEnergy)]
        public ExifRational FlashEnergy { get; set; }

        /* Look at table 5 for the test */
        /* starts at page 40 */

        #endregion

        #region Other Tags

        /// <summary>
        /// Unique image ID
        /// </summary>
        /// <remarks>
        /// ImageUniqueID
        /// This tag indicates an identifier assigned uniquely to each image. It is recorded as an ASCII string equivalent to
        /// hexadecimal notation and 128-bit fixed length.
        /// Tag = 42016 (A420.H)
        /// Type = ASCII
        /// Count = 33
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ImageUniqueId)]
        public string ImageUniqueId { get; set; }

        /// <summary>
        /// Spatial Frequency Response
        /// </summary>
        /// <remarks>
        /// SpatialFrequencyResponse
        /// This tag records the camera or input device spatial frequency table and SFR values in the direction of image width,
        /// image height, and diagonal direction, as specified in ISO 12233.
        /// Tag = 41484 (A20CH)
        /// Type = UNDEFINED
        /// Count = ANY
        /// Default = none
        /// When the spatial frequency response for m rows and n columns is recorded, the values are as shown in Figure 14.
        /// Length Type Meaning
        /// 2 SHORT Columns = n
        /// 2 SHORT Rows = m
        /// Any ASCII 0th column item name (NULL terminated)
        /// : : :
        /// Any ASCII n-1th column item name (NULL terminated)
        /// 8 RATIONAL SFR value [0,0]
        /// : : :
        /// 8 RATIONAL SFR value [n-1,0]
        /// 8 RATIONAL SFR value [0,m-1]
        /// : : :
        /// 8 RATIONAL SFR value [n-1,m-1]
        /// Figure 14 Spatial Frequency Response Description
        /// Table 10 gives a simple example.
        /// Table 10 Example of Spatial Frequency Response
        /// Spatial Frequency (lw/ph) Along Image Width Along Image Height
        /// 0.1 1.00 1.00
        /// 0.2 0.90 0.95
        /// 0.3 0.80 0.85
        /// </remarks>
        [ExifTypeId(ExifIdType.SpatialFrequenceResponse)]
        public byte[] SpatialFrequenceResponse { get; set; }

        /// <summary>
        /// Focal Plane X Resolution
        /// </summary>
        /// <remarks>
        /// FocalPlaneXResolution
        /// Indicates the number of pixels in the image width (X) direction per FocalPlaneResolutionUnit on the camera focal
        /// plane.
        /// Tag = 41486 (A20E.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FocalPlaneXResolution)]
        public ExifRational FocalPlaneXResolution { get; set; }


        /// <summary>
        /// Focal Plane Y Resolution
        /// </summary>
        /// <remarks>
        /// FocalPlaneYResolution
        /// Indicates the number of pixels in the image width (X) direction per FocalPlaneResolutionUnit on the camera focal
        /// plane.
        /// Tag = 41487 (A20F.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FocalPlaneYResolution)]
        public ExifRational FocalPlaneYResolution { get; set; }

        /// <summary>
        /// Focal Plane Resolution Unit
        /// </summary>
        /// <remarks>
        /// FocalPlaneResolutionUnit
        /// Indicates the unit for measuring FocalPlaneXResolution and FocalPlaneYResolution. This value is the same as the
        /// ResolutionUnit.
        /// Tag = 41488 (A210.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 2 (inch)
        /// Note on use of tags concerning focal plane resolution
        /// These tags record the actual focal plane resolutions of the main image which is written as a file after processing
        /// instead of the pixel resolution of the image sensor in the camera. It should be noted carefully that the data from
        /// the image sensor is resampled.
        /// These tags are used at the same time as a FocalLength tag when the angle of field of the recorded image is to
        /// be calculated precisely.
        /// </remarks>
        [ExifTypeId(ExifIdType.FocalPlaneResolutionUnit)]
        public FocalPlaneResolutionUnitType? FocalPlaneResolutionUnit { get; set; }

        /// <summary>
        /// Subject Location
        /// </summary>
        /// <remarks>
        /// SubjectLocation
        /// Indicates the location of the main subject in the scene. The value of this tag represents the pixel at the center of the
        /// main subject relative to the left edge, prior to rotation processing as per the Rotation tag. The first value indicates
        /// the X column number and second indicates the Y row number.
        /// Tag = 41492 (A214.H)
        /// Type = SHORT
        /// Count = 2
        /// Default = none
        /// When a camera records the main subject location, it is recommended that the SubjectArea tag be used instead of this tag.
        /// </remarks>
        [ExifTypeId(ExifIdType.SubjectLocation)]
        public short[] SubjectLocation { get; set; }

        /// <summary>
        /// Exposure Index
        /// </summary>
        /// <remarks>
        /// ExposureIndex
        /// Indicates the exposure index selected on the camera or input device at the time the image is captured.
        /// Tag = 41493 (A215.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.ExposureIndex)]
        public ExifRational ExposureIndex { get; set; }

        /// <summary>
        /// Sensing Method
        /// </summary>
        /// <remarks>
        /// SensingMethod
        /// Indicates the image sensor type on the camera or input device. The values are as follows.
        /// Tag = 41495 (A217.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 1 = Not defined
        /// 2 = One-chip color area sensor
        /// 3 = Two-chip color area sensor
        /// 4 = Three-chip color area sensor
        /// 5 = Color sequential area sensor
        /// 7 = Trilinear sensor
        /// 8 = Color sequential linear sensor
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.SensingMethod)]
        public SensingMethodType? SensingMethod { get; set; }

        /// <summary>
        /// File Source
        /// </summary>
        /// <remarks>
        /// FileSource
        /// Indicates the image source. If a DSC recorded the image, this tag value of this tag always be set to 3, indicating
        /// that the image was recorded on a DSC.
        /// Tag = 41728 (A300.H)
        /// Type = UNDEFINED
        /// Count = 1
        /// Default = 3
        /// 3 = DSC
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.FileSource)]
        public FileSourceType? FileSource { get; set; }

        /// <summary>
        /// SceneType 
        /// </summary>
        /// <remarks>
        /// SceneType
        /// Indicates the type of scene. If a DSC recorded the image, this tag value shall always be set to 1, indicating that the
        /// image was directly photographed.
        /// Tag = 41729 (A301.H)
        /// Type = UNDEFINED
        /// Count = 1
        /// Default = 1
        /// 1 = A directly photographed image
        /// Other = reserved 
        /// </remarks>
        [ExifTypeId(ExifIdType.SceneType)]
        public SceneTypeType? SceneType { get; set; }

        /// <summary>
        /// CFAPattern
        /// </summary>
        /// <remarks>
        /// CFAPattern
        /// Indicates the color filter array (CFA) geometric pattern of the image sensor when a one-chip color area sensor is
        /// used. It does not apply to all sensing methods.
        /// Tag = 41730 (A302.H)
        /// Type = UNDEFINED
        /// Count = ANY
        /// Default = none
        /// Figure 15 shows how a CFA pattern is recorded for a one-chip color area sensor when the color filter array is
        /// repeated in m x n (vertical x lateral) pixel units.
        /// Length Type Meaning
        /// 2 SHORT Horizontal repeat pixel unit = n
        /// 2 SHORT Vertical repeat pixel unit = m
        /// 1 BYTE CFA value [0.0]
        /// : : :
        /// 1 BYTE CFA value [n-1.0]
        /// 1 BYTE CFA value [0.m-1]
        /// : : :
        /// 1 BYTE CFA value [n-1.m-1]
        /// Figure 15 CFA Pattern Description
        /// JEITA CP-3451
        /// - 42 -
        /// The relation of color filter color to CFA value is shown in Table 11.
        /// Table 11 Color Filter Color and CFA Value
        /// Filter Color CFA Value
        /// RED 00.H
        /// GREEN 01.H
        /// BLUE 02.H
        /// CYAN 03.H
        /// MAGENTA 04.H
        /// YELLOW 05.H
        /// WHITE 06.H
        /// For example, when the CFA pattern values are {0002.H, 0002.H, 01.H, 00.H, 02.H, 01.H}, the color filter array is as
        /// shown in Figure 16.
        /// G R G R ........
        /// B G B G ........
        /// G R G R ........
        /// B G B G ........
        /// : : : :
        /// Figure 16 Color Filter Array
        /// </remarks>
        [ExifTypeId(ExifIdType.CfaPattern)]
        public byte[] CFAPattern { get; set; }

        /// <summary>
        /// Custom Rendered
        /// </summary>
        /// <remarks>
        /// CustomRendered
        /// This tag indicates the use of special processing on image data, such as rendering geared to output. When special
        /// processing is performed, the reader is expected to disable or minimize any further processing.
        /// Tag = 41985 (A401.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Normal process
        /// 1 = Custom process
        /// Other = reserved 
        /// </remarks>
        [ExifTypeId(ExifIdType.CustomRendered)]
        public CustomRenderedType? CustomRendered { get; set; }

        /// <summary>
        /// Exposure Mode
        /// </summary>
        /// <remarks>
        /// ExposureMode
        /// This tag indicates the exposure mode set when the image was shot. In auto-bracketing mode, the camera shoots a
        /// series of frames of the same scene at different exposure settings.
        /// Tag = 41986 (A402.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 0 = Auto exposure
        /// 1 = Manual exposure
        /// 2 = Auto bracket
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.ExposureMode)]
        public ExposureModeType? ExposureMode { get; set; }

        /// <summary>
        /// White Balance
        /// </summary>
        /// <remarks>
        /// WhiteBalance
        /// This tag indicates the white balance mode set when the image was shot.
        /// Tag = 41987 (A403.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 0 = Auto white balance
        /// 1 = Manual white balance
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.WhiteBalance)]
        public WhiteBalanceType? WhiteBalance { get; set; }

        /// <summary>
        /// Digital Zoom Ratio
        /// </summary>
        /// <remarks>
        /// DigitalZoomRatio
        /// This tag indicates the digital zoom ratio when the image was shot. If the numerator of the recorded value is 0, this
        /// indicates that digital zoom was not used.
        /// Tag = 41988 (A404.H)
        /// Type = RATIONAL
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.DigitalZoomRatio)]
        public ExifRational DigitalZoomRatio { get; set; }

        /// <summary>
        /// Focal Length In 35mm Film
        /// </summary>
        /// <remarks>
        /// FocalLengthIn35mmFilm
        /// This tag indicates the equivalent focal length assuming a 35mm film camera, in mm. A value of 0 means the focal
        /// length is unknown. Note that this tag differs from the FocalLength tag.
        /// Tag = 41989 (A405.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// </remarks>
        [ExifTypeId(ExifIdType.FlocalLengthIn35mmFilm)]
        public short? FocalLengthIn35mmFilm { get; set; }

        /// <summary>
        /// Scene Capture Type
        /// </summary>
        /// <remarks>
        /// SceneCaptureType
        /// This tag indicates the type of scene that was shot. It can also be used to record the mode in which the image was
        /// shot. Note that this differs from the scene type (SceneType) tag.
        /// Tag = 41990 (A406.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Standard
        /// 1 = Landscape
        /// 2 = Portrait
        /// 3 = Night scene
        /// Other = reserved 
        /// </remarks>
        [ExifTypeId(ExifIdType.SceneCaptureType)]
        public SceneCaptureTypeType? SceneCaptureType { get; set; }

        /// <summary>
        /// Gain Control
        /// </summary>
        /// <remarks>
        /// GainControl
        /// This tag indicates the degree of overall image gain adjustment.
        /// Tag = 41991 (A407.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 0 = None
        /// 1 = Low gain up
        /// 2 = High gain up
        /// 3 = Low gain down
        /// 4 = High gain down
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.GainControl)]
        public GainControlType? GainControl { get; set; }

        /// <summary>
        /// Contrast 
        /// </summary>
        /// <remarks>
        /// Contrast
        /// This tag indicates the direction of contrast processing applied by the camera when the image was shot.
        /// Tag = 41992 (A408.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Normal
        /// 1 = Soft
        /// 2 = Hard
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.Contrast)]
        public ContrastType? Contrast { get; set; }

        /// <summary>
        /// Saturation 
        /// </summary>
        /// <remarks>
        /// Saturation
        /// This tag indicates the direction of saturation processing applied by the camera when the image was shot.
        /// Tag = 41993 (A409.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Normal
        /// 1 = Low saturation
        /// 2 = High saturation
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.Saturation)]
        public SaturationType? Saturation { get; set; }

        /// <summary>
        /// Sharpness
        /// </summary>
        /// <remarks>
        /// Sharpness
        /// This tag indicates the direction of sharpness processing applied by the camera when the image was shot.
        /// Tag = 41994 (A40A.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = 0
        /// 0 = Normal
        /// 1 = Soft
        /// 2 = Hard
        /// Other = reserved        
        /// </remarks>
        [ExifTypeId(ExifIdType.Sharpness)]
        public SharpnessType? Sharpness { get; set; }

        /// <summary>
        /// Device Setting Description
        /// </summary>
        /// <remarks>
        /// DeviceSettingDescription
        /// This tag indicates information on the picture-taking conditions of a particular camera model. The tag is used only to
        /// indicate the picture-taking conditions in the reader.
        /// Tag = 41995 (A40B.H)
        /// Type = UNDEFINED
        /// Count = Any
        /// Default = none
        /// The information is recorded in the format shown in Figure 17. The data is recorded in Unicode using SHORT type
        /// for the number of display rows and columns and UNDEFINED type for the camera settings. The Unicode (UCS-2)
        /// string including Signature is NULL terminated. The specifics of the Unicode string are as given in ISO/IEC 10464-1.
        /// Length Type Meaning
        /// 2 SHORT Display columns
        /// 2 SHORT Display rows
        /// Any UNDEFINED Camera setting-1
        /// Any UNDEFINED Camera setting-2
        /// : : :
        /// Any UNDEFINED Camera setting-n
        /// Figure 17 Format used to record picture-taking conditions
        /// </remarks>
        [ExifTypeId(ExifIdType.DeviceSettingDescription)]
        public byte[] DeviceSettingDescription { get; set; }

        /// <summary>
        /// Subject Distance Range
        /// </summary>
        /// <remarks>
        /// SubjectDistanceRange
        /// This tag indicates the distance to the subject.
        /// Tag = 41996 (A40C.H)
        /// Type = SHORT
        /// Count = 1
        /// Default = none
        /// 0 = unknown
        /// 1 = Macro
        /// 2 = Close view
        /// 3 = Distant view
        /// Other = reserved
        /// </remarks>
        [ExifTypeId(ExifIdType.SubjectDistanceRange)]
        public SubjectDistanceRangeType? SubjectDistanceRange { get; set; }

        #endregion

        #endregion

        #region Tags related to GPS attributes

        /* starts at page 52 */

        #endregion

        [ExifTypeId(ExifIdType.LuminanceTable)]
        public short[] LuminanceTable { get; set; }

        [ExifTypeId(ExifIdType.ChrominanceTable)]
        public short[] ChrominanceTable { get; set; }

        #region Thumbnail Tags

        [ExifTypeId(ExifIdType.ThumbnailData)]
        public byte[] ThumbnailData { get; set; }

        public Image ThumbnailImage
        {
            get
            {
                if (ThumbnailData != null && ThumbnailData.Length > 0)
                    return new Bitmap(new MemoryStream(ThumbnailData));
                return null;
            }
        }

        [ExifTypeId(ExifIdType.ThumbnailCompression)]
        public short? ThumbnailCompression { get; set; }

        [ExifTypeId(ExifIdType.ThumbnailResolutionX)]
        public ExifRational ThumbnailResolutionX { get; set; }

        [ExifTypeId(ExifIdType.ThumbnailResolutionY)]
        public ExifRational ThumbnailResolutionY { get; set; }

        [ExifTypeId(ExifIdType.ThumbnailResolutionUnit)]
        public short? ThumbnailResolutionUnit { get; set; }

        #endregion

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            var properties = this.GetType().GetProperties().OrderBy(p => p.Name);

            foreach (var property in properties)
            {
                object propertyValue = GenericParser.GetProperty(property, this);
                if (propertyValue != null)
                {
                    if (!propertyValue.ToString().StartsWith("System."))
                        sb.AppendFormat("{0}: {1}\r\n", property.Name, propertyValue);
                }
            }

            return sb.ToString();
        }
    }
}
