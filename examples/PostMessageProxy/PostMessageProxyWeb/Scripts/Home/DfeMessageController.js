//Name of your application
var applicationName = 'DFE';

// operations to expose
var ctrl = {
    ShowDeal: function (dealJacket) {
        return tools.prompt({ Action: 'ShowDeal', DJ: dealJacket });
    },
    HelloWorld: function (message) {
        return tools.prompt({ Action: 'HelloWorld', Message: message });
    }
};

// clients
var clients = window.$clients;
var postMessageProxy = window.$postMessageProxy = window.$postMessageProxy || new PostMessageProxy(applicationName, ctrl, clients);
