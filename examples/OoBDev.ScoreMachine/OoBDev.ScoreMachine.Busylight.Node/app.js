'use strict';

var signalR = require('@aspnet/signalr');
var busylight = require('busylight').get();

console.log('connecting to signalr');

var connection = new signalR.HubConnectionBuilder()
    .withUrl("http://10.0.88.4:5000/ScoreMachineHub")
    .configureLogging(signalR.LogLevel.Information)
    .build();

var lastColor = 'blue';

busylight.light(lastColor);

function getColor(message) {
    if (message && message.messageType === 'SpecialAction') {
        if (message.Action === 'StartBout') {
            return lastColor = 'red';
        }
        else if (message.Action === 'EndBout') {
            return lastColor = 'white';
        }
    }
    return lastColor;
}

connection.on("ReceiveData", function (message) {
    console.log('ReceiveData: ' + JSON.stringify(message));

    if (message && message.data) {
        var color = getColor(message.data);
        console.log('current color: ' + color);

        busylight.light(color);
    }
});

function startConnection() {
    connection.start().then(function () {
        connection.invoke("sendData", {
            "messageType": "ClientConnected",
            "user-agent": "node.js"
        }).catch(function (err) {
            return console.error(err.toString());
        });
    }).catch(function (err) {
        console.error(err.toString());
        setTimeout(startConnection, 1000);
    });
}

connection.onclose(function (err) {
    if (err) {
        console.error(err.toString());
    }
    setTimeout(startConnection, 1000);
});

startConnection();

console.log('Press Enter to allow process to terminate')
process.stdin.once('data', callback)

function callback(data) {
    console.log('Unreferencing stdin. Exiting in 5 seconds.')
    process.stdin.unref()

    process.stdin.once('data', function (data) {
        console.log('More data')
    })

    setTimeout(function () {
        console.log('Timeout, Exiting.')
    }, 5000);
}
