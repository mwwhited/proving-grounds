
            var $cms = window.$cms = window.$cms || {
    getBusinessUnit: function (market) {
        if (market === "USA") {
            return 'bmw us';
        } else {
            return 'bmw mx';
        }
    },
    postForm: function (form) {
        var operation = document.getElementById('operationName').value;

        var market = document.getElementById('market').value;
        var bu = $cms.getBusinessUnit(market);
        var srno = document.getElementById('srno').value;

        var btn = document.getElementById('btn');
        btn.style.color = "yellow";

        var ret = $siebel[operation].apply(form, [bu, srno]);

        var result = document.getElementById('result');
        ret.then(function (res) {
            result.innerHTML = '<pre>' + JSON.stringify(res) + '</pre>';
            btn.style.color = "green";
        }).catch(function (ex, mesg) {
            result.innerHTML = JSON.stringify(ex);
            btn.style.color = "red";
        });

        return false;
    },
    Ready: function () {
        $postMessageProxy.SendReady();
    }
};