BEGIN TRY
	BEGIN TRANSACTION 
		DECLARE @ch UNIQUEIDENTIFIER;
		DECLARE @msg XML;
	
		BEGIN DIALOG CONVERSATION @ch
			FROM SERVICE [ProcessResponseService]
			TO SERVICE 'ProcessMessageService'
			ON CONTRACT [oobdev://ProcessMessage/Contract]
			WITH ENCRYPTION = OFF;

		SET @msg = N'<Root>
			<Item id=''Value'' />
		</Root>';

		SEND ON CONVERSATION @ch MESSAGE TYPE 
			[oobdev://ProcessMessage/Request] (@msg);
	COMMIT;
END TRY
BEGIN CATCH
	SELECT  
		ERROR_NUMBER() AS ErrorNumber  
		,ERROR_SEVERITY() AS ErrorSeverity  
		,ERROR_STATE() AS ErrorState  
		,ERROR_PROCEDURE() AS ErrorProcedure  
		,ERROR_LINE() AS ErrorLine  
		,ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK;
END CATCH