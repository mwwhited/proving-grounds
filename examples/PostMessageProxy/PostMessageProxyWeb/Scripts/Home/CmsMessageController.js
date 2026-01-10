//Name of your application
var applicationName = 'CMS';

// operations to expose
var ctrl = {
    ShowAccount: function (contractAccount) {
        return tools.prompt({ Action: 'ShowAccount', CA: contractAccount });
    },
    HelloWorld: function (message) {
        return tools.prompt({ Action: 'HelloWorld', Message: message });
    },
    Ping: function (message) {
        return { Pong: message };
    }
};

// clients
var clients = window.$clients;
var postMessageProxy = window.$postMessageProxy = window.$postMessageProxy || new PostMessageProxy(applicationName, ctrl, clients);
