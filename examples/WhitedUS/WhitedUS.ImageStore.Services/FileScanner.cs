using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using WhitedUS.Drawing;
using WhitedUS.ImageStore.Models;
using System;
using System.Diagnostics;

namespace WhitedUS.ImageStore.Services
{
    public class FileScanner
    {
        public FileScanner(string basePath, string searchPattern)
        {
            this.BasePath = basePath;
            this.SearchPattern = searchPattern;
        }

        public string BasePath { get; private set; }
        public string SearchPattern { get; private set; }

        private byte[] ReadFile(string name)
        {
            var filename = Path.Combine(this.BasePath, name);
            var input = File.ReadAllBytes(filename);
            var ext = Path.GetExtension(filename).ToUpper();

            if (ext == ".PNG")
            {
                var result = input.Recompress(85, ImageFormat.Png);
                return result;
            }
            else if (ext == ".JPG")
            {
                var result = input.Recompress(85, ImageFormat.Jpeg);
                return result;
            }
            else
            {
                return input;
            }

        }

        public IEnumerable<ContentItemModel> ListFiles()
        {
            var contentTypeService = new ContentTypeService();

            var directoryInfo = new DirectoryInfo(this.BasePath);
            var files = directoryInfo.EnumerateFiles(this.SearchPattern);

            var query = from file in files
                        let extension = file.Extension.Trim('.')
                        let contentType = contentTypeService.List()
                                                            .Single(c => c.Extension == extension)
                        select new ContentItemModel
                        {
                            Name = file.Name,
                            CreationTime = file.CreationTime,
                            LastAccessTime = file.LastAccessTime,
                            LastWriteTime = file.LastWriteTime,
                            //Data = new Lazy<byte[]>(() => ReadFile(file.FullName)),
                            ContentTypeID = contentType.ContentTypeID,
                        };
            return query;
        }

        public void ScanTo(ContentItemService service, int folderId)
        {
            RecurseFolders(this, folderId, service);
        }

        private void RecurseFolders(FileScanner fileScanner, int folderId, ContentItemService service)
        {
            var files = fileScanner.ListFiles().ToList();

            if (files.Count > 0)
            {
                foreach (var file in files)
                {
                    try
                    {
                        file.FolderID = folderId;

                        var existing = service.List()
                                              .Select(f => new
                                              {
                                                  FolderID = f.FolderID,
                                                  Name = f.Name,
                                                  ContentItemID = f.ContentItemID,
                                                  LastWriteTime = f.LastWriteTime,
                                              })
                                              .FirstOrDefault(f => f.FolderID == folderId
                                                                    && f.Name == file.Name);

                        if (existing != null)
                        {
                            if (existing.LastWriteTime >= file.LastWriteTime)
                                continue;

                            file.ContentItemID = existing.ContentItemID;
                        }

                        file.Data = fileScanner.ReadFile(file.Name);

                        service.Save(file);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("\tError: \"{0}\": \"{1}\"", file.Name, ex.Message);
                    }
                }
            }
        }
    }
}
