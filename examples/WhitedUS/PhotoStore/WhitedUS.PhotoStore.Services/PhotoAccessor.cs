using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Transactions;
using WhitedUS.Common.Graphics.Exif;
using WhitedUS.PhotoStore.Data;
using WhitedUS.PhotoStore.Models;

namespace WhitedUS.PhotoStore.Services
{
    public class PhotoAccessor
    {
        public PhotoAccessor(string basePath, string pattern, string[] extensions)
        {
            this.BasePath = basePath;
            this.Pattern = pattern;
            this.Extensions = extensions;

            this.DataContext = new PhotoStoreEntities();
            this.Scaler = new ImageScaler();
        }

        public string BasePath { get; private set; }
        public string Pattern { get; private set; }
        public string[] Extensions { get; private set; }
        private PhotoStoreEntities DataContext { get; set; }
        public ImageScaler Scaler { get; private set; }

        public MetaDataModel GetMetaData(string pathInfo)
        {
            var folder = Path.GetDirectoryName(pathInfo).Replace('\\', '/');
            var file = Path.GetFileNameWithoutExtension(pathInfo);
            var ext = Path.GetExtension(pathInfo);
            var query = from resource in this.DataContext.Resources
                        where resource.BasePath.Path == this.BasePath
                            && resource.Folder == folder
                            && resource.Name == file
                            && resource.Extension == ext
                        from metaData in this.DataContext.ResourceMetaDatas
                        where metaData.ResourceID == resource.ResourceID
                        select new MetaDataModel
                        {
                            ResourceID = resource.ResourceID,
                            MaxFactor = resource.MaxFactor,
                            Folder = resource.Folder,
                            Name = resource.Name,
                            Extension = resource.Extension,

                            Image_Height = metaData.Image_Height,
                            Image_Width = metaData.Image_Width,

                            ImageEXIF_ApertureValue = metaData.ImageEXIF_ApertureValue,
                            ImageEXIF_ColorSpace = metaData.ImageEXIF_ColorSpace,
                            ImageEXIF_CompressedBitsPerPixel = metaData.ImageEXIF_CompressedBitsPerPixel,
                            ImageEXIF_Contrast = metaData.ImageEXIF_Contrast,
                            ImageEXIF_CustomRendered = metaData.ImageEXIF_CustomRendered,
                            ImageEXIF_DateTimeDigitized = metaData.ImageEXIF_DateTimeDigitized,
                            ImageEXIF_DateTimeOriginal = metaData.ImageEXIF_DateTimeOriginal,
                            ImageEXIF_DateTimeValue = metaData.ImageEXIF_DateTimeValue,
                            ImageEXIF_DigitalZoomRatio = metaData.ImageEXIF_DigitalZoomRatio,
                            ImageEXIF_ExifVersion = metaData.ImageEXIF_ExifVersion,
                            ImageEXIF_ExposureBiasValue = metaData.ImageEXIF_ExposureBiasValue,
                            ImageEXIF_ExposureMode = metaData.ImageEXIF_ExposureMode,
                            ImageEXIF_ExposureProgram = metaData.ImageEXIF_ExposureProgram,
                            ImageEXIF_ExposureTime = metaData.ImageEXIF_ExposureTime,
                            ImageEXIF_FileSource = metaData.ImageEXIF_FileSource,
                            ImageEXIF_Flash = metaData.ImageEXIF_Flash,
                            ImageEXIF_FlashpixVersion = metaData.ImageEXIF_FlashpixVersion,
                            ImageEXIF_FNumber = metaData.ImageEXIF_FNumber,
                            ImageEXIF_FocalLength = metaData.ImageEXIF_FocalLength,
                            ImageEXIF_FocalLengthIn35mmFilm = metaData.ImageEXIF_FocalLengthIn35mmFilm,
                            ImageEXIF_FocalPlaneResolutionUnit = metaData.ImageEXIF_FocalPlaneResolutionUnit,
                            ImageEXIF_FocalPlaneXResolution = metaData.ImageEXIF_FocalPlaneXResolution,
                            ImageEXIF_FocalPlaneYResolution = metaData.ImageEXIF_FocalPlaneYResolution,
                            ImageEXIF_GainControl = metaData.ImageEXIF_GainControl,
                            ImageEXIF_ImageDescription = metaData.ImageEXIF_ImageDescription,
                            ImageEXIF_ImageUniqueId = metaData.ImageEXIF_ImageUniqueId,
                            ImageEXIF_ISOSpeedRatings = metaData.ImageEXIF_ISOSpeedRatings,
                            ImageEXIF_JPEGInterchangeFormat = metaData.ImageEXIF_JPEGInterchangeFormat,
                            ImageEXIF_JPEGInterchangeFormatLength = metaData.ImageEXIF_JPEGInterchangeFormatLength,
                            ImageEXIF_LightSource = metaData.ImageEXIF_LightSource,
                            ImageEXIF_Make = metaData.ImageEXIF_Make,
                            ImageEXIF_MaxApertureValue = metaData.ImageEXIF_MaxApertureValue,
                            ImageEXIF_MeteringMode = metaData.ImageEXIF_MeteringMode,
                            ImageEXIF_Model = metaData.ImageEXIF_Model,
                            ImageEXIF_Orientation = metaData.ImageEXIF_Orientation,
                            ImageEXIF_OtherProperties = metaData.ImageEXIF_OtherProperties,
                            ImageEXIF_PixelXDimension = metaData.ImageEXIF_PixelXDimension,
                            ImageEXIF_PixelYDimension = metaData.ImageEXIF_PixelYDimension,
                            ImageEXIF_ResolutionUnit = metaData.ImageEXIF_ResolutionUnit,
                            ImageEXIF_Saturation = metaData.ImageEXIF_Saturation,
                            ImageEXIF_SceneCaptureType = metaData.ImageEXIF_SceneCaptureType,
                            ImageEXIF_SceneType = metaData.ImageEXIF_SceneType,
                            ImageEXIF_SensingMethod = metaData.ImageEXIF_SensingMethod,
                            ImageEXIF_Sharpness = metaData.ImageEXIF_Sharpness,
                            ImageEXIF_ShutterSpeedValue = metaData.ImageEXIF_ShutterSpeedValue,
                            ImageEXIF_Software = metaData.ImageEXIF_Software,
                            ImageEXIF_SubjectDistanceRange = metaData.ImageEXIF_SubjectDistanceRange,
                            ImageEXIF_SubSecTime = metaData.ImageEXIF_SubSecTime,
                            ImageEXIF_SubSecTimeDigitized = metaData.ImageEXIF_SubSecTimeDigitized,
                            ImageEXIF_SubSecTimeOriginal = metaData.ImageEXIF_SubSecTimeOriginal,
                            ImageEXIF_UserComment = metaData.ImageEXIF_UserComment,
                            ImageEXIF_WhiteBalance = metaData.ImageEXIF_WhiteBalance,
                            ImageEXIF_XResolution = metaData.ImageEXIF_XResolution,
                            ImageEXIF_YResolution = metaData.ImageEXIF_YResolution,
                            ImageEXIF_YCbCrPositioning = metaData.ImageEXIF_YCbCrPositioning,
                        };

            var item = query.FirstOrDefault();
            return item;
        }

        public Stream GetFile(string pathInfo, byte? factor, out string mimeType)
        {

            var folder = Path.GetDirectoryName(pathInfo).Replace('\\', '/');
            var file = Path.GetFileNameWithoutExtension(pathInfo);
            var ext = Path.GetExtension(pathInfo);

            var query = from resource in this.DataContext.Resources
                        where resource.BasePath.Path == this.BasePath
                            && resource.Folder == folder
                            && resource.Name == file
                            && resource.Extension == ext
                        from scale in resource.Scalings
                        where scale.Factor == (factor ?? resource.MaxFactor)
                        select new
                        {
                            scale.Data,
                            resource.ResourceType.MimeType,
                        };

            var item = query.FirstOrDefault();
            if (item == null)
                return this.MakeFile(pathInfo, factor, out mimeType);

            mimeType = item.MimeType;
            return new MemoryStream(item.Data);
        }

        private Stream MakeFile(string pathInfo, byte? factor, out string mimeType)
        {
            var fullName = Path.Combine(this.BasePath, pathInfo);

            var folder = Path.GetDirectoryName(pathInfo).Replace('\\', '/');
            var file = Path.GetFileNameWithoutExtension(pathInfo);
            var ext = Path.GetExtension(pathInfo);

            var bp = this.DataContext.BasePaths.First(b => b.Path == this.BasePath);

            var res = this.DataContext.Resources.FirstOrDefault(r =>
                r.BasePathID == bp.BasePathID
                && r.Folder == folder
                && r.Name == file
                && r.Extension == ext);

            var rt = this.DataContext.ResourceTypes.FirstOrDefault(r => r.Extension == ext);
            mimeType = rt.MimeType;
            if (res == null)
            {
                var maxFactor = this.GetFactor(pathInfo);

                using (var transaction = new TransactionScope())
                {
                    res = new Resource
                    {
                        BasePathID = bp.BasePathID,
                        ResourceTypeID = rt.ResourceTypeID,
                        Folder = folder,
                        Name = file,
                        Extension = ext,
                        MaxFactor = maxFactor,
                        CreatedDate = DateTime.Now,
                    };
                    this.DataContext.Resources.AddObject(res);
                    this.DataContext.SaveChanges();

                    this.FillAttributes(res.ResourceID, pathInfo);

                    this.DataContext.SaveChanges();

                    transaction.Complete();
                }
            }

            var targetFactor = (factor ?? res.Scalings.Max(x => x.Factor));
            var scale = this.DataContext.Scalings.FirstOrDefault(s =>
                s.ResourceID == res.ResourceID
                && s.Factor == targetFactor
                );
            Stream stream;
            if (scale == null)
            {
                using (var fileStream = File.OpenRead(fullName))
                using (var ms = new MemoryStream())
                {
                    if (mimeType == "image/x-raw")
                    {
                        var converter = new NikonRawConverter();
                        var converted = converter.ToJpeg(fileStream);
                        stream = this.Scaler.Resize(converted, mimeType, ref factor);
                    }
                    else
                    {
                        stream = this.Scaler.Resize(fileStream, mimeType, ref factor);
                    }
                    stream.CopyTo(ms);

                    scale = new Scaling
                    {
                        ResourceID = res.ResourceID,
                        Factor = factor ?? 255,
                        Data = ms.ToArray(),
                        CreatedDate = DateTime.Now,
                    };
                    this.DataContext.Scalings.AddObject(scale);
                    this.DataContext.SaveChanges();
                }
            }
            else
            {
                stream = new MemoryStream(scale.Data);
            }
            stream.Position = 0;
            return stream;
        }

        private byte GetFactor(string pathInfo)
        {
            using (var bitmap = this.GetBitmap(pathInfo))
                return (byte)Math.Ceiling(Math.Log(Math.Min(bitmap.Width, bitmap.Height), 2));
        }

        private Bitmap GetBitmap(string pathInfo)
        {
            var ext = Path.GetExtension(pathInfo).ToUpper();
            if (ext == ".NEF")
            {
                using (var fileStream = new FileStream(Path.Combine(this.BasePath, pathInfo), FileMode.Open))
                {
                    var converter = new NikonRawConverter();
                    var converted = converter.ToJpeg(fileStream);
                    return new Bitmap(converted);
                }
            }
            else
            {
                return new Bitmap(Path.Combine(this.BasePath, pathInfo));
            }
        }

        private void FillAttributes(int resourceID, string pathInfo)
        {
            using (var bitmap = this.GetBitmap(pathInfo))
            {
                this.AddAttribute(resourceID, "Image", "Width", bitmap.Width);
                this.AddAttribute(resourceID, "Image", "Height", bitmap.Height);

                var exifGroup = "Image.EXIF";
                var exifData = ExifData.CreateInstance(bitmap);
                this.AddAttribute(resourceID, exifGroup, "ApertureValue", exifData.ApertureValue);
                this.AddAttribute(resourceID, exifGroup, "Artist", exifData.Artist);
                this.AddAttribute(resourceID, exifGroup, "BitsPerSample", exifData.BitsPerSample);
                this.AddAttribute(resourceID, exifGroup, "BrightnessValue", exifData.BrightnessValue);
                this.AddAttribute(resourceID, exifGroup, "ColorSpace", exifData.ColorSpace);
                this.AddAttribute(resourceID, exifGroup, "CompressedBitsPerPixel", exifData.CompressedBitsPerPixel);
                this.AddAttribute(resourceID, exifGroup, "Compression", exifData.Compression);
                this.AddAttribute(resourceID, exifGroup, "Contrast", exifData.Contrast);
                this.AddAttribute(resourceID, exifGroup, "Copyright", exifData.Copyright);
                this.AddAttribute(resourceID, exifGroup, "CustomRendered", exifData.CustomRendered);
                this.AddAttribute(resourceID, exifGroup, "DateTimeDigitized", exifData.DateTimeDigitized);
                this.AddAttribute(resourceID, exifGroup, "DateTimeOriginal", exifData.DateTimeOriginal);
                this.AddAttribute(resourceID, exifGroup, "DateTimeValue", exifData.DateTimeValue);
                this.AddAttribute(resourceID, exifGroup, "DigitalZoomRatio", exifData.DigitalZoomRatio);
                this.AddAttribute(resourceID, exifGroup, "ExifVersion", exifData.ExifVersion);
                this.AddAttribute(resourceID, exifGroup, "ExposureBiasValue", exifData.ExposureBiasValue);
                this.AddAttribute(resourceID, exifGroup, "ExposureIndex", exifData.ExposureIndex);
                this.AddAttribute(resourceID, exifGroup, "ExposureMode", exifData.ExposureMode);
                this.AddAttribute(resourceID, exifGroup, "ExposureProgram", exifData.ExposureProgram);
                this.AddAttribute(resourceID, exifGroup, "ExposureTime", exifData.ExposureTime);
                this.AddAttribute(resourceID, exifGroup, "FileSource", exifData.FileSource);
                this.AddAttribute(resourceID, exifGroup, "Flash", exifData.Flash);
                this.AddAttribute(resourceID, exifGroup, "FlashEnergy", exifData.FlashEnergy);
                this.AddAttribute(resourceID, exifGroup, "FlashpixVersion", exifData.FlashpixVersion);
                this.AddAttribute(resourceID, exifGroup, "FNumber", exifData.FNumber);
                this.AddAttribute(resourceID, exifGroup, "FocalLength", exifData.FocalLength);
                this.AddAttribute(resourceID, exifGroup, "FocalLengthIn35mmFilm", exifData.FocalLengthIn35mmFilm);
                this.AddAttribute(resourceID, exifGroup, "FocalPlaneResolutionUnit", exifData.FocalPlaneResolutionUnit);
                this.AddAttribute(resourceID, exifGroup, "FocalPlaneXResolution", exifData.FocalPlaneXResolution);
                this.AddAttribute(resourceID, exifGroup, "FocalPlaneYResolution", exifData.FocalPlaneYResolution);
                this.AddAttribute(resourceID, exifGroup, "GainControl", exifData.GainControl);
                this.AddAttribute(resourceID, exifGroup, "ImageDescription", exifData.ImageDescription);
                this.AddAttribute(resourceID, exifGroup, "ImageLength", exifData.ImageLength);
                this.AddAttribute(resourceID, exifGroup, "ImageUniqueId", exifData.ImageUniqueId);
                this.AddAttribute(resourceID, exifGroup, "ImageWidth", exifData.ImageWidth);
                this.AddAttribute(resourceID, exifGroup, "ISOSpeedRatings", exifData.ISOSpeedRatings);
                this.AddAttribute(resourceID, exifGroup, "JPEGInterchangeFormat", exifData.JPEGInterchangeFormat);
                this.AddAttribute(resourceID, exifGroup, "JPEGInterchangeFormatLength", exifData.JPEGInterchangeFormatLength);
                this.AddAttribute(resourceID, exifGroup, "LightSource", exifData.LightSource);
                this.AddAttribute(resourceID, exifGroup, "Make", exifData.Make);
                this.AddAttribute(resourceID, exifGroup, "MaxApertureValue", exifData.MaxApertureValue);
                this.AddAttribute(resourceID, exifGroup, "MeteringMode", exifData.MeteringMode);
                this.AddAttribute(resourceID, exifGroup, "Model", exifData.Model);
                this.AddAttribute(resourceID, exifGroup, "Orientation", exifData.Orientation);
                this.AddAttribute(resourceID, exifGroup, "OtherProperties", exifData.OtherProperties);
                this.AddAttribute(resourceID, exifGroup, "PhotoMetricInterpertation", exifData.PhotoMetricInterpertation);
                this.AddAttribute(resourceID, exifGroup, "PixelXDimension", exifData.PixelXDimension);
                this.AddAttribute(resourceID, exifGroup, "PixelYDimension", exifData.PixelYDimension);
                this.AddAttribute(resourceID, exifGroup, "PlanarConfiguration", exifData.PlanarConfiguration);
                this.AddAttribute(resourceID, exifGroup, "RelatedSoundFile", exifData.RelatedSoundFile);
                this.AddAttribute(resourceID, exifGroup, "ResolutionUnit", exifData.ResolutionUnit);
                this.AddAttribute(resourceID, exifGroup, "RowsPerStrip", exifData.RowsPerStrip);
                this.AddAttribute(resourceID, exifGroup, "SamplesPerPixel", exifData.SamplesPerPixel);
                this.AddAttribute(resourceID, exifGroup, "Saturation", exifData.Saturation);
                this.AddAttribute(resourceID, exifGroup, "SceneCaptureType", exifData.SceneCaptureType);
                this.AddAttribute(resourceID, exifGroup, "SceneType", exifData.SceneType);
                this.AddAttribute(resourceID, exifGroup, "SensingMethod", exifData.SensingMethod);
                this.AddAttribute(resourceID, exifGroup, "Sharpness", exifData.Sharpness);
                this.AddAttribute(resourceID, exifGroup, "ShutterSpeedValue", exifData.ShutterSpeedValue);
                this.AddAttribute(resourceID, exifGroup, "Software", exifData.Software);
                this.AddAttribute(resourceID, exifGroup, "SpectralSensitivity", exifData.SpectralSensitivity);
                this.AddAttribute(resourceID, exifGroup, "StripBytesCount", exifData.StripBytesCount);
                this.AddAttribute(resourceID, exifGroup, "StripOffset", exifData.StripOffset);
                this.AddAttribute(resourceID, exifGroup, "SubjectDistance", exifData.SubjectDistance);
                this.AddAttribute(resourceID, exifGroup, "SubjectDistanceRange", exifData.SubjectDistanceRange);
                this.AddAttribute(resourceID, exifGroup, "SubSecTime", exifData.SubSecTime);
                this.AddAttribute(resourceID, exifGroup, "SubSecTimeDigitized", exifData.SubSecTimeDigitized);
                this.AddAttribute(resourceID, exifGroup, "SubSecTimeOriginal", exifData.SubSecTimeOriginal);
                this.AddAttribute(resourceID, exifGroup, "UserComment", exifData.UserComment);
                this.AddAttribute(resourceID, exifGroup, "WhiteBalance", exifData.WhiteBalance);
                this.AddAttribute(resourceID, exifGroup, "XResolution", exifData.XResolution);
                this.AddAttribute(resourceID, exifGroup, "YCbCrPositioning", exifData.YCbCrPositioning);
                this.AddAttribute(resourceID, exifGroup, "YCbCrSubsampling", exifData.YCbCrSubsampling);
                this.AddAttribute(resourceID, exifGroup, "YResolution", exifData.YResolution);
            }
        }

        private void AddAttribute(int resourceID, string groupName, string attributeName, object value)
        {
            var stringResult = (value ?? string.Empty).ToString();
            if (string.IsNullOrWhiteSpace(stringResult))
                return;


            var attribute = this.DataContext.ResourceAttributeTypes.FirstOrDefault(a => a.AttributeGroup == groupName && a.AttributeName == attributeName);
            if (attribute == null)
            {
                attribute = new ResourceAttributeType
                {
                    AttributeGroup = groupName,
                    AttributeName = attributeName,
                };
                this.DataContext.ResourceAttributeTypes.AddObject(attribute);
                this.DataContext.SaveChanges();
            }

            this.DataContext.ResourceAttributes.AddObject(new ResourceAttribute
            {
                ResourceAttributeTypeID = attribute.ResourceAttributeTypeID,
                ResourceID = resourceID,
                Value = stringResult,
            });
        }

        public IQueryable<TagModel> ListTags()
        {
            var query = from tag in this.DataContext.TagSummaryDatas
                        select new TagModel
                        {
                            TagID = tag.TagID,
                            Label = tag.Label,
                            Count = tag.Count ?? 0,
                            Total = tag.Total ?? 0,
                            Percent = tag.Percent ?? 0,
                            Tier = tag.Tier ?? 0,
                        };
            return query;
        }

        public bool IsPathDirectory(string path)
        {
            return Directory.Exists(path);
        }

        public bool IsPathFile(string path)
        {
            return File.Exists(path);
        }

        public IQueryable<IFileSystemModel> ListByPath(string path)
        {
            return (from directory in System.IO.Directory.EnumerateDirectories(path)
                    let p = directory.Substring(this.BasePath.Length).TrimStart('/', '\\')
                    where Regex.IsMatch(p, this.Pattern)
                    orderby p
                    let files = from file in System.IO.Directory.EnumerateFiles(directory, "*.*", SearchOption.AllDirectories)
                                let f = file.Substring(this.BasePath.Length).TrimStart('/', '\\')
                                let e = System.IO.Path.GetExtension(file).ToUpper()
                                where this.Extensions.Contains(e)
                                select f
                    let file = files.FirstOrDefault()
                    where !string.IsNullOrWhiteSpace(file)
                    select (IFileSystemModel)new DirectoryModel
                    {
                        Path = p.Replace('\\', '/'),
                        Thumbnail = file.Replace('\\', '/'),
                        Name = Path.GetFileNameWithoutExtension(p),
                    }).Concat(from file in System.IO.Directory.EnumerateFiles(path)
                              let p = file.Substring(this.BasePath.Length).TrimStart('/', '\\')
                              let e = System.IO.Path.GetExtension(file).ToUpper()
                              where this.Extensions.Contains(e)
                              where Regex.IsMatch(p, this.Pattern)
                              orderby p
                              select (IFileSystemModel)new FileModel
                              {
                                  Path = p.Replace('\\', '/'),
                                  Name = Path.GetFileNameWithoutExtension(p),
                              }).AsQueryable();
        }

        public IQueryable<IFileSystemModel> ListByTags(string[] tags)
        {
            var query = from basePath in this.DataContext.BasePaths
                        where basePath.Path == this.BasePath
                        from resource in basePath.Resources
                        where tags.All(t => resource.ResourceTags.Any(rt => rt.Tag.Label == t))
                        orderby new
                        {
                            resource.Folder,
                            resource.Name,
                            resource.Extension,
                        }
                        select new FileModel
                        {
                            Path = resource.Folder + "/" + resource.Name + resource.Extension,
                            Name = resource.Name,
                        };
            return query;
        }

        public bool TagAdd(string pathInfo, string tag)
        {
            var folder = Path.GetDirectoryName(pathInfo).Replace('\\', '/');
            var file = Path.GetFileNameWithoutExtension(pathInfo);
            var ext = Path.GetExtension(pathInfo);

            var query = from res in this.DataContext.Resources
                        where res.BasePath.Path == this.BasePath
                             && res.Folder == folder
                             && res.Name == file
                             && res.Extension == ext
                        select new
                        {
                            Resource = res,
                            Tagged = res.ResourceTags.Any(rt => rt.Tag.Label == tag),
                        };
            var resource = query.FirstOrDefault();

            if (resource != null && !resource.Tagged)
            {
                var tagEntity = this.DataContext
                                .Tags
                                .FirstOrDefault(t => t.Label == tag);

                if (tagEntity == null)
                {
                    tagEntity = new Tag
                    {
                         Label = tag,
                    };
                    this.DataContext.Tags.AddObject(tagEntity);
                    this.DataContext.SaveChanges();
                }

                this.DataContext.ResourceTags.AddObject(new ResourceTag
                {
                     TagID = tagEntity.TagID,
                     ResourceID = resource.Resource.ResourceID,
                });
                this.DataContext.SaveChanges();
                return true;
            }
            return false;
        }

        public bool TagRemove(string pathInfo, string tag)
        {
            var folder = Path.GetDirectoryName(pathInfo).Replace('\\', '/');
            var file = Path.GetFileNameWithoutExtension(pathInfo);
            var ext = Path.GetExtension(pathInfo);

            var query = from res in this.DataContext.Resources
                        where res.BasePath.Path == this.BasePath
                             && res.Folder == folder
                             && res.Name == file
                             && res.Extension == ext
                        select new
                        {
                            Resource = res,
                            Tagged = res.ResourceTags.Any(rt => rt.Tag.Label == tag),
                        };
            var resource = query.FirstOrDefault();

            if (resource != null && resource.Tagged)
            {
                var resourceTag = this.DataContext
                                      .ResourceTags
                                      .FirstOrDefault(rt => rt.Tag.Label == tag);

                if (resourceTag != null)
                {
                    this.DataContext.ResourceTags.DeleteObject(resourceTag);
                    this.DataContext.SaveChanges();
                    return true;
                }
            }
            return false;
        }
    }
}
