ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [ImageStore_log], FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ImageStore_log.ldf', SIZE = 1024 KB, MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);

