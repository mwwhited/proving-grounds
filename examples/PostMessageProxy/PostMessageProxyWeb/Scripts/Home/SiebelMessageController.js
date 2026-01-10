//Name of your application
var applicationName = 'Siebel';

// operations to expose
var ctrl = {
    PopServiceRequest: function (businessUnit, ServiceRequestNumber) {
        console.log(['PopServiceRequest', businessUnit, ServiceRequestNumber]);
    },
    PopAccountServiceRequests: function (businessUnit, ServiceRequestNumber) {
        console.log(['PopAccountServiceRequests', businessUnit, ServiceRequestNumber]);
    },
    PopAccountAddresses: function (businessUnit, ServiceRequestNumber) {
        console.log(['PopAccountAddresses', businessUnit, ServiceRequestNumber]);
    },
    PopAccountRoles: function (businessUnit, ServiceRequestNumber) {
        console.log(['PopAccountRoles', businessUnit, ServiceRequestNumber]);
    },
    PopContactEmailAudit: function (businessUnit, ServiceRequestNumber) {
        console.log(['PopContactEmailAudit', businessUnit, ServiceRequestNumber]);
    },
    HelloWorld_Response: function (result, args) {
        console.log(['HelloWorld_Response', result, args]);
        return "Success!";
    }
};

// clients
var clients = window.$clients;
var postMessageProxy = window.$postMessageProxy = window.$postMessageProxy || new PostMessageProxy(applicationName, ctrl, clients);
