ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [PhotoStore], FILENAME = 'C:\fs\N\SQL_Data\PhotoStore.mdf', SIZE = 717120 KB, FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];



