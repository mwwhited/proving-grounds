-- =============================================
-- Create Request Response Application Template
-- =============================================


--  Create the stored procedure

if exists (select 1 from sys.procedures where [object_id] = OBJECT_ID(N'[dbo].[ProcessMessageHandler]'))
drop procedure [dbo].[ProcessMessageHandler]
GO
SET ANSI_NULLS ON
go
SET QUOTED_IDENTIFIER ON
go

CREATE PROCEDURE [dbo].[ProcessMessageHandler]
   AS declare @message_body varbinary(MAX)
   
   declare @message_type int
   declare @dialog uniqueidentifier 



while (1 = 1)
begin
	begin transaction

-- Receive the next available message from the queue
	
	WAITFOR (
		RECEIVE top(1) -- just handle one message at a time
			@message_type=message_type_id, --the type of message received
			@message_body=message_body,      -- the message contents
			@dialog = conversation_handle    -- the identifier of the dialog this message was received on
			FROM ProcessMessageQueue
	), TIMEOUT 1000  -- if the queue is empty for one second, give UPDATE and go away

-- If we didn't get anything, bail out
	if (@@ROWCOUNT = 0)
		BEGIN
			Rollback Transaction
			BREAK
		END 

-- Check for the End Dialog message.
	If (@message_type <> 2) -- End dialog message
	BEGIN
-- Send the message back to the sender.
		SEND ON CONVERSATION @dialog  -- send it back on the dialog we received the message on
			MESSAGE TYPE [oobdev://ProcessMessage/Response] -- Must always supply a message type
			(@message_body);  -- the message contents (a varbinary(MAX) blob
	END

--  Commit the transaction.  At any point before this, we could roll 
--  back - the received message would be back on the queue and the response
--  wouldn't be sent.
	commit transaction
end
go


-- Create the required meta-data

CREATE MESSAGE TYPE [oobdev://ProcessMessageRequest] VALIDATION = NONE 

CREATE MESSAGE TYPE [oobdev://ProcessMessage/Response] VALIDATION = NONE 

CREATE CONTRACT [oobdev://ProcessMessage/Contract]
  ([oobdev://ProcessMessageRequest] SENT BY INITIATOR,
    [oobdev://ProcessMessage/Response] SENT BY TARGET)

CREATE QUEUE [dbo].[ProcessMessageQueue] 
   WITH 
   STATUS = ON,
   RETENTION = OFF ,
   ACTIVATION (
		STATUS = ON,
		PROCEDURE_NAME = ProcessMessageHandler ,
		MAX_QUEUE_READERS = 1, 
		EXECUTE AS SELF ),
   POISON_MESSAGE_HANDLING (STATUS = ON) 

CREATE SERVICE [ProcessMessageService] 
ON QUEUE ProcessMessageQueue

ALTER SERVICE [ProcessMessageService] 
 ( ADD CONTRACT [oobdev://ProcessMessage/Contract] )

