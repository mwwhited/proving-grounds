CREATE QUEUE [dbo].[ProcessMessageQueue]
    WITH ACTIVATION (STATUS = OFF, PROCEDURE_NAME = [dbo].[ProcessMessageHandler], MAX_QUEUE_READERS = 1, EXECUTE AS N'dbo');

