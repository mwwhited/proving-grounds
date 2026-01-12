// <reference path=../../../../Scripts/jquery-1.8.2-vsdoc.js" />
// <reference path=../../../../Scripts/jquery.linq-vsdoc.js" />
// <reference path=../../../../Scripts/jknockout-2.1.0.debug.js" />
// <reference path=../../../../Scripts/knockout.validation.debug.js" />

var loadViewer = function () {
    var path = window.location.hash.substring(2);
    var url = viewerUrl + "/" + path;
    $.getJSON(url, function (data) {
        ko.mapping.fromJS(data, viewModel.model);
    });
};

var showImage = function (model) {
    ko.mapping.fromJS(model, viewModel.current);

    var path = window.location.hash.substring(2);
    var url = viewerExifUrl + "/" + model.Path() + '?type=Json';
    $.getJSON(url, function (data) {
        ko.mapping.fromJS(data, viewModel.exif);
    });
};