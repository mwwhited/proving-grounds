ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [aspnetdb_log], FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\aspnetdb_log.LDF', SIZE = 768 KB, MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);

