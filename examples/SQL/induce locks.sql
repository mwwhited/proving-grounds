

BEGIN TRAN

--PRINT 'before'
--EXEC [dbo].[RetrieveMissingEmbeddings]

--DROP TABLE IF EXISTS [#temp-mwhited]

--PRINT 'select'
--SELECT TOP 1
--	[ID]
--INTO [#temp-mwhited]
--FROM [dbo].[UnderwriterActivity] WITH (UPDLOCK, ROWLOCK, READPAST)
--ORDER BY
--	SubmissionDate

--PRINT 'update'
--UPDATE [dbo].[UnderwriterActivity]  WITH (UPDLOCK, ROWLOCK, READPAST)
--SET [IsVectorSet] = 0
--FROM [dbo].[UnderwriterActivity]
--INNER JOIN [#temp-mwhited]
--	ON [#temp-mwhited].[ID] = [UnderwriterActivity].[ID]
	
--DROP TABLE IF EXISTS [#temp-mwhited2]
--PRINT 'select'
--SELECT TOP 3
--	 QuoteID	
--	,InstanceId
--INTO [#temp-mwhited2]
--FROM [RUBI_Prod].[dbo].[SubmissionClearingCached]  WITH (UPDLOCK, ROWLOCK, READPAST)
--ORDER BY
--	InstanceDate

--PRINT 'update'
--UPDATE [RUBI_Prod].[dbo].[SubmissionClearingCached]  WITH (UPDLOCK, ROWLOCK, READPAST)
--SET [IsVectorSet] = 0, [IsOutOfDate] = 0
--FROM [RUBI_Prod].[dbo].[SubmissionClearingCached]
--INNER JOIN [#temp-mwhited2]
--	ON  [#temp-mwhited2].QuoteID = [SubmissionClearingCached].QuoteID
--	AND [#temp-mwhited2].InstanceId = [SubmissionClearingCached].InstanceId
	

--PRINT 'after'
--EXEC [dbo].[RetrieveMissingEmbeddings]

--PRINT 'force out of date'

UPDATE [RUBI_Prod].[dbo].[SubmissionClearingCached]  WITH (UPDLOCK, ROWLOCK, READPAST)
SET [IsOutOfDate] = 0
FROM [RUBI_Prod].[dbo].[SubmissionClearingCached]
WHERE
	[QuoteID] = 'CE6DE52DE2'

--ROLLBACK
