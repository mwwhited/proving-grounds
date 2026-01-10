var postMessageProxy = window.$postMessageProxy;

var siebelProxy = window.$siebel = window.$siebel || {};

siebelProxy.PopServiceRequests = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopServiceRequests', [businessUnit, serviceRequestNumber]);
}
siebelProxy.PopAccountServiceRequests = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopAccountServiceRequests', [businessUnit, serviceRequestNumber]);
}
siebelProxy.PopServiceRequest = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopServiceRequest', [businessUnit, serviceRequestNumber]);
}
siebelProxy.PopAccountAddresses = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopAccountAddresses', [businessUnit, serviceRequestNumber]);
}
siebelProxy.PopAccountRoles = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopAccountRoles', [businessUnit, serviceRequestNumber]);
}
siebelProxy.PopContactEmailAudit = function (businessUnit, serviceRequestNumber) {
    return postMessageProxy.SendMessage('Siebel', 'PopContactEmailAudit', [businessUnit, serviceRequestNumber]);
}