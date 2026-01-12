ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [PhotoStore_log], FILENAME = 'C:\fs\N\SQL_Data\PhotoStore_1.ldf', SIZE = 388544 KB, MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);



