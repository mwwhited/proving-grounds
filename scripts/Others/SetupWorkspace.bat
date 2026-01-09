REM Copy this into a text file and save as workspacesetup.bat
@ECHO OFF
SETLOCAL

SET ConfigureCCMSprint=X
SET ConfigureCandidate=_
SET ConfigureDevOpsStaging=_

TF.EXE >NUL
IF '%ERRORLEVEL%'='9009' (
	SET PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE;
)

REM C:\Program Files (x86)\Microsoft Team Foundation Server 2013 Power Tools\;C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;

ECHO === Setup Base ===
TF WORKFOLD /MAP "$/" "c:\tfs"

ECHO == Cloak Most ===
TF WORKFOLD /CLOAK "$/Agent Applications"
TF WORKFOLD /CLOAK "$/Application Common"
TF WORKFOLD /CLOAK "$/Application Configuration"
TF WORKFOLD /CLOAK "$/Bank Applications"
TF WORKFOLD /CLOAK "$/Batch Applications"
TF WORKFOLD /CLOAK "$/BizTalk"
TF WORKFOLD /CLOAK "$/Brazil"
TF WORKFOLD /CLOAK "$/Camber"
TF WORKFOLD /CLOAK "$/Canada"
TF WORKFOLD /CLOAK "$/ComFin"
TF WORKFOLD /CLOAK "$/Contract Management"
TF WORKFOLD /CLOAK "$/Customer Facing Applications"
TF WORKFOLD /CLOAK "$/DataCenterMigration"
TF WORKFOLD /CLOAK "$/Dealer and Funding"
TF WORKFOLD /CLOAK "$/Document Generation"
TF WORKFOLD /CLOAK "$/Enterprise Applications"
TF WORKFOLD /CLOAK "$/Enterprise"
TF WORKFOLD /CLOAK "$/Information Architecture"
TF WORKFOLD /CLOAK "$/Information Delivery"
TF WORKFOLD /CLOAK "$/Intranet"
TF WORKFOLD /CLOAK "$/Mexico"
TF WORKFOLD /CLOAK "$/Operations"
TF WORKFOLD /CLOAK "$/Originations"
TF WORKFOLD /CLOAK "$/Other"
TF WORKFOLD /CLOAK "$/Release Refi"
TF WORKFOLD /CLOAK "$/SA Utilities"
TF WORKFOLD /CLOAK "$/Siebel"
TF WORKFOLD /CLOAK "$/Systems Architecture"
TF WORKFOLD /CLOAK "$/Test Automation"
TF WORKFOLD /CLOAK "$/TFS"
TF WORKFOLD /CLOAK "$/Time Tracker"
TF WORKFOLD /CLOAK "$/Up2DriveIntegration"

IF '%ConfigureCCMSprint%'='X' (
	ECHO == Map CCM\Sprint ===
	TF WORKFOLD /MAP "$/Application Common/DevOps/CCM/Sprint" "C:\CCMSprint\Application Common"
	TF WORKFOLD /MAP "$/BizTalk/DevOps/CCM/Sprint" "C:\CCMSprint\BizTalk"
	TF WORKFOLD /MAP "$/Contract Management/DevOps/CCM/Sprint" "C:\CCMSprint\Contract Management"
	TF WORKFOLD /MAP "$/Document Generation/DevOps/CCM/Sprint" "C:\CCMSprint\Document Generation"
	TF WORKFOLD /MAP "$/Information Architecture/DevOps/CCM/Sprint" "C:\CCMSprint\Information Architecture"

	TF WORKFOLD /CLOAK "$/Contract Management/DevOps/CCM/Sprint/build/CMS.Services/packages"
	TF WORKFOLD /CLOAK "$/Contract Management/DevOps/CCM/Sprint/build/CMS.Web/packages"
)

IF '%ConfigureDevOpsStaging%'='X' (
	ECHO == Map DevOpsStaging ===
	TF WORKFOLD /MAP "$/Application Common/DevOpsStaging" "C:\DevOpsStaging\Application Common"
	TF WORKFOLD /MAP "$/BizTalk/DevOpsStaging" "C:\DevOpsStaging\BizTalk"
	TF WORKFOLD /MAP "$/Contract Management/DevOpsStaging" "C:\DevOpsStaging\Contract Management"
	TF WORKFOLD /MAP "$/Document Generation/DevOpsStaging" "C:\DevOpsStaging\Document Generation"
	TF WORKFOLD /MAP "$/Information Architecture/DevOpsStaging" "C:\DevOpsStaging\Information Architecture"

	TF WORKFOLD /CLOAK "$/Contract Management/DevOpsStaging/build/CMS.Services/packages"
	TF WORKFOLD /CLOAK "$/Contract Management/DevOpsStaging/build/CMS.Web/packages"
)

IF '%ConfigureCandidate%'='X' (
	ECHO == Map Candidate ===
	TF WORKFOLD /MAP "$/Application Common/Candidate" "C:\Candidate\Application Common"
	TF WORKFOLD /MAP "$/BizTalk/Candidate" "C:\Candidate\BizTalk"
	TF WORKFOLD /MAP "$/Contract Management/Candidate" "C:\Candidate\Contract Management"
	TF WORKFOLD /MAP "$/Document Generation/Candidate" "C:\Candidate\Document Generation"
	TF WORKFOLD /MAP "$/Information Architecture/Candidate" "C:\Candidate\Information Architecture"

	TF WORKFOLD /CLOAK "$/Contract Management/Candidate/build/CMS.Services/packages"
	TF WORKFOLD /CLOAK "$/Contract Management/Candidate/build/CMS.Web/packages"
)

ECHO === Get Lateset ===
TF GET /RECURSIVE "$/"

ENDLOCAL

ECHO === Done ===
PAUSE