-- PostgreSQL Event Log Query
-- Queries application event traces with JSON payload filtering
-- Platform: PostgreSQL
-- Note: Hostname filters have been anonymized - customize for your environment

SELECT
	id,timestamp, computername, providername, instancename, level, /*formattedmessage,*/ payload, activityid, relatedactivityid
	--,(payload::JSON->'logRequestMessage')
FROM    traces
WHERE   timestamp > '2019-02-15 10:00' --AND timestamp < '2019-02-15 17:00'

AND providername IN ('NgxEventSource') /* this is the core api event source */

-- Limiting to selected computers is useful. The lower(computername) field is indexed, and eliminates oddness in how hostnames are stored.
AND (
	-- Example: Development environment
	--lower(computername::text) IN ( 'dev-server-01', 'dev-server-02', 'dev-server-03' )

	-- Example: Test environment
	lower(computername::text) IN ( 'test-server-01', 'test-server-02', 'test-server-03' )
)

AND (payload::JSON->'logRequestMessage') IS NOT NULL


ORDER BY timestamp DESC
LIMIT 100
