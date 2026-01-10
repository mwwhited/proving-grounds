var postMessageProxy = window.$postMessageProxy;

var cms = window.$cms = window.$cms || {};

//cms.ShowAccount = function (contractAccount) {
//    return postMessageProxy.SendMessage('CMS', 'ShowAccount', [contractAccount]);
//}
//cms.HelloWorld = function (message) {
//    return postMessageProxy.SendMessage('CMS', 'HelloWorld', [message]);
//}
cms.Ping = function (message) {
    return postMessageProxy.SendMessage('CMS', 'Ping', [message]);
}