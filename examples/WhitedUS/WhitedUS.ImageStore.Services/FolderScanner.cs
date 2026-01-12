using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class FolderScanner
    {
        public FolderScanner(string basePath, string searchPattern)
        {
            this.BasePath = basePath;
            this.SearchPattern = searchPattern;
        }

        public string BasePath { get; private set; }
        public string SearchPattern { get; private set; }

        public IEnumerable<FolderModel> ListFolders()
        {
            var directoryInfo = new DirectoryInfo(this.BasePath);
            var directories = directoryInfo.EnumerateDirectories(this.SearchPattern);

            var query = from dir in directories
                        select new FolderModel()
                        {
                              Name = dir.Name,
                              //ParentPath = this.BasePath,
                              MappedPath = dir.FullName,
                              CreationTime = dir.CreationTime,
                              LastAccessTime = dir.LastAccessTime,
                              LastWriteTime = dir.LastWriteTime,
                        };
            return query;
        }

        public void ScanTo(FolderService folderService)
        {
            RecurseFolders(this, folderService);
        }

        private static void RecurseFolders(FolderScanner folderScanner, FolderService folderService)
        {
            var folders = folderScanner.ListFolders().ToList();

            if (folders.Count > 0)
            {
                var parent = folderService.List()
                                          .FirstOrDefault(f => f.MappedPath == folderScanner.BasePath);

                foreach (var folder in folders)
                {
                    folder.ParentID = parent.FolderID;

                    var existing = folderService.List()
                                                .FirstOrDefault(f => f.MappedPath == folder.MappedPath);

                    if (existing != null)
                    {
                        if (existing.LastWriteTime >= folder.LastWriteTime)
                            continue;

                        folder.FolderID = existing.FolderID;
                    }

                    folderService.Save(folder);

                    var scanner = new FolderScanner(folder.MappedPath, "*.*");
                    RecurseFolders(scanner, folderService);
                }
            }
        }
    }
}
