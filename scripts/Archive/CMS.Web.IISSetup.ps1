# Gives elevated privilege to run the script
Set-ExecutionPolicy RemoteSigned

# Constants
Set-Variable TFSSource -option Constant -value 'C:\TFS'
Set-Variable WebProjectPath -option Constant -value "$TFSSource\Contract Management\Dev\src\Web\"

# Module for working with IIS
Import-Module WebAdministration

# New Website for ApplyPayment
New-WebSite ApplyPayment 
		-PhysicalPath $WebProjectPath  + "Module.Payments.ApplyPayment"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payments.ApplyPayment.local.sfam.americas.bmw.corp

# New Website for CCNotepad
New-WebSite CCNotepad 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.CCNotepad" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.CCNotepad.local.sfam.americas.bmw.corp

# New Website for CMSWeb
New-Website CMSWeb 
		-PhysicalPath $WebProjectPath
		-ApplicationPool SFAM 
		-Hostheader cmsweb.local.sfam.americas.bmw.corp

# New Website for ContractDetails
New-WebSite ContractDetails 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.ContractDetails" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.ContractDetails.local.sfam.americas.bmw.corp

# New Website for CustomerRefunds
New-WebSite CustomerRefunds 
		-PhysicalPath $WebProjectPath  + "Module.Payments.CustomerRefunds" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payments.CustomerRefunds.local.sfam.americas.bmw.corp

# New Website for DueDateChange
New-WebSite DueDateChange 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.DueDateChange" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.DueDateChange.local.sfam.americas.bmw.corp

# New Website for Insurance
New-WebSite Insurance 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.Insurance" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.Insurance.local.sfam.americas.bmw.corp

# New Website for MaintainACH
New-WebSite MaintainACH 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.MaintainACH" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.MaintainACH.local.sfam.americas.bmw.corp

# New Website for ManageAccountStates
New-WebSite ManageAccountStates 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.ManageAccountStates" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.ManageAccountStates.local.sfam.americas.bmw.corp

# New Website for Misapplied
New-WebSite Misapplied 
		-PhysicalPath $WebProjectPath  + "Module.Payments.Misapplied" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.Misapplied.local.sfam.americas.bmw.corp

# New Website for Myworklist
New-WebSite Myworklist 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.MyWorklistItems" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.Myworklist.local.sfam.americas.bmw.corp

# New Website for ProductInfoPanel
New-WebSite ProductInfoPanel 
		-PhysicalPath $WebProjectPath  + "Module.Servicing.ProductInfoPanel" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Servicing.ProductInfoPanel.local.sfam.americas.bmw.corp

# New Website for RefundRequest
New-WebSite RefundRequest 
		-PhysicalPath $WebProjectPath  + "Module.Payment.RefundRequest" 
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.RefundRequest.local.sfam.americas.bmw.corp

# New Website for SharedCMS
New-Website SharedCMS 
		-PhysicalPath $WebProjectPath  + "Module.CMS.Shared"
		-ApplicationPool SFAM 
		-Hostheader sharedcms.local.sfam.americas.bmw.corp

# New Website for SingleCharge
New-Website SingleCharge 
		-PhysicalPath $WebProjectPath  + "Module.Payment.SingleCharge"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.SingleCharge.local.sfam.americas.bmw.corp

# New Website for TransactionHistory
New-Website TransactionHistory 
		-PhysicalPath $WebProjectPath  + "Module.Payments.TransactionHistory"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.TransactionHistory.local.sfam.americas.bmw.corp

# New Website for Termination
New-Website Termination 
		-PhysicalPath $WebProjectPath  + "Module.EOT.Termination"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.EOT.Termination.local.sfam.americas.bmw.corp

# New Website for CustomerCredits
New-Website CustomerCredits 
		-PhysicalPath $WebProjectPath  + "Module.Payment.CustomerCredits"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.CustomerCredits.local.sfam.americas.bmw.corp

# New Website for PromiseToPay
New-Website PromiseToPay 
		-PhysicalPath $WebProjectPath  + "Module.Payment.PromiseToPay"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.PromiseToPay.local.sfam.americas.bmw.corp

# New Website for CustomerCredits
New-Website CustomerCredits 
		-PhysicalPath $WebProjectPath  + "Module.Payment.CustomerCredits"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.CustomerCredits.local.sfam.americas.bmw.corp

# New Website for CustomerCredits
New-Website CustomerCredits 
		-PhysicalPath $WebProjectPath  + "Module.Payment.CustomerCredits"
		-ApplicationPool SFAM 
		-Hostheader cmsModule.Payment.CustomerCredits.local.sfam.americas.bmw.corp
