select 
	cmd
	,loginame
	,hostname
	,lastwaittype
	,waittime
	--,* 
from sys.sysprocesses
where blocked > 0

SELECT 
    blocking_session_id AS BlockingSession,
    session_id AS BlockedSession,
    wait_type,
    wait_time,
    wait_resource,
    text AS SqlText
FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE wait_type LIKE 'LCK%';

SELECT
    r.session_id,
    r.blocking_session_id,
    l.resource_type,
    l.resource_database_id,
    DB_NAME(l.resource_database_id) AS database_name,
    OBJECT_NAME(p.object_id, l.resource_database_id) AS table_name,
    l.resource_associated_entity_id AS resource_id,
    l.request_mode,
    l.request_status,
    r.wait_type,
    r.wait_resource,
t.text AS sql_text
FROM sys.dm_tran_locks AS l
JOIN sys.dm_exec_requests AS r
    ON l.request_session_id = r.session_id
LEFT JOIN sys.partitions AS p
    ON l.resource_associated_entity_id = p.hobt_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE l.resource_database_id = DB_ID()
ORDER BY r.session_id;


-- force lock timeout 
-- SET LOCK_TIMEOUT 10000
