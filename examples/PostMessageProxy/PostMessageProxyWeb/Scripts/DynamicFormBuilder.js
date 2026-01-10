var clients = window.$clients = window.$clients || {};
var postMessageProxy = window.$postMessageProxy;

var actors = {};
for (var clientName in clients) {
    var adapter = window['$' + clientName.toLowerCase()];
    if (adapter) {
        var operations = {
            TargetURL: window.$clients[clientName]
        };

        for (var fn in adapter) {
            var f = adapter[fn];
            if (typeof f === 'function') {
                operations[fn] = {
                    Action: f,
                    Arguments: tools.getFunctionArguments(f)
                }
            }
        }

        actors[clientName] = operations;
    }
}
clients.model = actors;

(function FormBuilder(formid, model) {
    var form = document.getElementById(formid);

    if (!form || !postMessageProxy) return;
    form.ProxyRef = postMessageProxy;

    var functionlist = document.getElementById('localFunctions')
    var appDef = postMessageProxy.ApplicationDef;
    for (var appFuncName in appDef) {
        var appFuncArgs = appDef[appFuncName];

        var appFuncLi = document.createElement('li');
        appFuncLi.innerHTML = appFuncName + '(' + appFuncArgs.join() + ')';

        functionlist.appendChild(appFuncLi);
    }

    /* Event Handler */
    tools.bindEvent(window, 'load', function () {
        setTimeout(function () { // delay sending ApplicationReady for 5 seconds
            postMessageProxy.SendReady();
        }, 5000);
    });
    
    var opBtnReady = document.createElement('button');
    opBtnReady.innerHTML = "Ready";
    opBtnReady.id = fullOpName;
    opBtnReady.addEventListener('click', function () {
        var promise = postMessageProxy.SendReady();
    });
    form.appendChild(opBtnReady);

    for (var clientName in model) {
        var client = model[clientName];

        var appDiv = document.createElement('div');
        appDiv.ClientRef = client;

        var title = document.createElement('h4');
        title.innerHTML = clientName;
        appDiv.appendChild(title);
        var url = document.createElement('h5');
        url.innerHTML = client.TargetURL;
        appDiv.appendChild(url);

        for (var opName in client) {
            var op = client[opName];
            if (op.Action) {
                var opFieldSet = document.createElement('fieldset');
                opFieldSet.ActionRef = op;

                var opFieldSetLedger = document.createElement('legend');
                opFieldSetLedger.innerHTML = opName;
                opFieldSet.appendChild(opFieldSetLedger);

                var argInputs = [];

                var fullOpName = clientName + '_' + opName;

                for (var argIndx in op.Arguments) {
                    var argName = op.Arguments[argIndx];
                    var fullArgName = fullOpName + '_' + argName;

                    var argDiv = document.createElement('div');

                    var argLabel = document.createElement('label');
                    argLabel.innerHTML = argName;
                    argLabel.attributes['for'] = fullArgName;
                    argDiv.appendChild(argLabel);

                    var argInput = document.createElement('input');
                    argInput.id = fullArgName;
                    argDiv.appendChild(argInput);

                    opFieldSet.appendChild(argDiv);
                }

                var opBtn = document.createElement('button');
                opBtn.innerHTML = "Send";
                opBtn.id = fullOpName;
                opBtn.addEventListener('click', function () {
                    var clientRef = this.parentNode.parentNode.ClientRef;
                    var actionRef = this.parentNode.ActionRef;

                    var argElements = this.parentNode.getElementsByTagName('input');
                    var argValues = [];
                    for (var i = 0; i < argElements.length; i++) {
                        var element = argElements[i];
                        argValues.push(element.value);
                    }

                    var promise = actionRef.Action.apply(clientRef, argValues);
                });
                opFieldSet.appendChild(opBtn);

                appDiv.appendChild(opFieldSet);
            }
        }
        
        form.appendChild(appDiv);
    }
})('dynamicForm', actors)

var postMessageProxy = window.$postMessageProxy;
if (postMessageProxy) {
    postMessageProxy.onreceived = function (e) {
        /*
            e.source //Caller's Instance (window.opener)
            e.origin //Caller's URL
            e.data   //payload from caller
        */
        //this is just demo code
        var tbody = document.getElementById('messageRows');
        if (tbody) {
            var tRow = tbody.insertRow(0);
            tRow.insertCell(0).innerHTML = "<";
            tRow.insertCell(1).innerHTML = e.origin;
            tRow.insertCell(2).innerHTML = JSON.stringify(e.data);
        }
    }
    postMessageProxy.onsent = function (e) {
        /*
                target: proxy,
                origin: window.location,
                data: {
                    Source: prv.Application,
                    Target: targetApplication,
                    Operation: operationName,
                    Arguments: args
                }
    
        */
        //this is just demo code
        var tbody = document.getElementById('messageRows');
        if (tbody) {
            var tRow = tbody.insertRow(0);
            tRow.insertCell(0).innerHTML = ">";
            tRow.insertCell(1).innerHTML = e.origin;
            tRow.insertCell(2).innerHTML = JSON.stringify(e.data);
        }
    }
}