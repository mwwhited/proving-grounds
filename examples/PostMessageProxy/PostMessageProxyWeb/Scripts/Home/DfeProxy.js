var postMessageProxy = window.$postMessageProxy;

var dfe = window.$dfe = window.$dfe || {};

dfe.ShowDeal = function (dealJacket) {
    return postMessageProxy.SendMessage('DFE', 'ShowDeal', [dealJacket]);
}
dfe.HelloWorld = function (message) {
    return postMessageProxy.SendMessage('DFE', 'HelloWorld', [message]);
}