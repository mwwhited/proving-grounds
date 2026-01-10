CREATE SERVICE [ProcessMessageService]
    AUTHORIZATION [dbo]
    ON QUEUE [dbo].[ProcessMessageQueue]
    ([oobdev://ProcessMessage/Contract]);

