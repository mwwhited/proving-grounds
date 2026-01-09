-- SQL Server Agent Job Export
-- Exports SQL Server Agent job configurations, schedules, and execution history to XML
-- Platform: SQL Server (requires access to msdb database)

WITH [Jobs] AS (
	SELECT
		 sysjobs.job_id
		,sysjobs.name
		,sysjobs.enabled
		,sysjobs.description

		,(SELECT TOP 1 sysjobschedules.schedule_id
			FROM msdb.dbo.sysjobschedules
			WHERE sysjobschedules.job_id = sysjobs.job_id
			ORDER BY sysjobschedules.next_run_date DESC
			) AS schedule_id__Next

		,(SELECT TOP 1 sysjobactivity.session_id
			FROM msdb.dbo.sysjobactivity
			WHERE sysjobactivity.job_id = sysjobs.job_id
			ORDER BY sysjobactivity.run_requested_date DESC
			) AS session_id__Next

	FROM msdb.dbo.sysjobs
)
	SELECT --TOP 100
		 job.job_id
		,job.name
		,job.enabled
		,job.description

		,schedule.schedule_id
		,schedule.next_run_date
		,schedule.next_run_time

		,activity.[run_requested_date]
		,activity.[run_requested_source]
		,activity.[queued_date]
		,activity.[start_execution_date]
		,activity.[last_executed_step_id]
		,activity.[last_executed_step_date]
		,activity.[stop_execution_date]
		,activity.[job_history_id]
		,activity.[next_scheduled_run_date]

		,(
		SELECT
			 [step].[step_id]
			,[step].[step_name] as [name]
			,[step].[subsystem]
			,[step].[command]
			,[step].[flags]
			,[step].[additional_parameters]
			,[step].[cmdexec_success_code]
			,[step].[on_success_action]
			,[step].[on_success_step_id]
			,[step].[on_fail_action]
			,[step].[on_fail_step_id]
			,[step].[server]
			,[step].[database_name]
			,[step].[database_user_name]
			,[step].[retry_attempts]
			,[step].[retry_interval]
			,[step].[os_run_priority]
			,[step].[output_file_name]
			,[step].[last_run_outcome]
			,[step].[last_run_duration]
			,[step].[last_run_retries]
			,[step].[last_run_date]
			,[step].[last_run_time]
			,(
				SELECT
					 [log].[log_id]
					,[log].[log]
					,[log].[date_created]
					,[log].[date_modified]
					,[log].[log_size]
				FROM [msdb].[dbo].[sysjobstepslogs] AS [log]
				WHERE
					[log].[step_uid] = [step].[step_uid]
				FOR XML AUTO, TYPE
			)
		FROM [msdb].[dbo].[sysjobsteps] AS [step]
		WHERE
			[step].[job_id] = job.job_id
		FOR XML AUTO, TYPE, ROOT('steps')
		) as steps

		,(
		SELECT
			 history.[instance_id]
			--,history.[job_id]
			,history.[step_id]
			,history.[step_name]
			,history.[sql_message_id]
			,history.[sql_severity]
			,history.[message]
			,history.[run_status]
			,history.[run_date]
			,history.[run_time]
			,history.[run_duration]
			,history.[operator_id_emailed]
			,history.[operator_id_netsent]
			,history.[operator_id_paged]
			,history.[retries_attempted]
			--,history.[server]
		FROM [msdb].[dbo].[sysjobhistory] as history
		WHERE
			history.[job_id] = job.job_id
			AND history.[instance_id] = activity.[job_history_id]
		FOR XML AUTO, TYPE, ROOT('histories')
		) as histories

	FROM [Jobs] AS job
	LEFT OUTER JOIN msdb.dbo.sysjobschedules as schedule
		ON schedule.schedule_id = job.schedule_id__Next
	LEFT OUTER JOIN msdb.dbo.sysjobactivity as activity
		ON activity.job_id = job.job_id
			AND activity.session_id = job.session_id__Next
