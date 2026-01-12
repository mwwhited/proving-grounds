ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [ImageStore_FS], FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\FileStreams\ImageStore_FS') TO FILEGROUP [FileStream];

