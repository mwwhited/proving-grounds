var $siebel = window.$siebel = window.$siebel || {
    postForm: function (form) {
        var operation = document.getElementById('operationName').value;
        var contractAccount = document.getElementById('contractAccount').value;

        var btn = document.getElementById('btn');
        btn.style.color = "yellow";

        var ret = $postMessageProxy.SendMessage('CMS', operation, [contractAccount]);
        var result = document.getElementById('result');
        ret.then(function (res) {
            result.innerHTML = '<pre>' + JSON.stringify(res) + '</pre>';
            btn.style.color = "green";
        }).catch(function (ex) {
            result.innerHTML = JSON.stringify(ex);
            btn.style.color = "red";
        });

        return false;
    },
    Ready: function () {
        $postMessageProxy.SendReady();
    }
};