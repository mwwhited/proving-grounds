https://docs.microsoft.com/en-us/sql/t-sql/functions/session-context-transact-sql?view=sql-server-2017

SESSION_CONTEXT(N'key')  

EXEC sp_set_session_context 'user_id', 4;  
SELECT SESSION_CONTEXT(N'user_id');  


https://docs.microsoft.com/en-us/sql/t-sql/functions/context-info-transact-sql?view=sql-server-2017