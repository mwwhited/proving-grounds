
$(function () {
    var uri = window.OobDev.MsitApiUri;
    $.ajax({
        url: uri,
        success: function (_data, _status, _jqXHR) {
            var text = JSON.stringify(_data);
            $('#jsondata').append('<pre>'.concat(text).concat('</pre>'));
            window.OobDev.Zoom = window.OobDev.Zoom || {};
            window.OobDev.Zoom.Data = _data;
            render();
        },
        dataType: 'json'
    });

    document.getElementById("viewer");
});

window.onresize = function (_event) {
    render();
};

function render() {
    window.OobDev.Zoom = window.OobDev.Zoom || {};
    window.OobDev.Zoom.Data = window.OobDev.Zoom.Data || {};

    var c = document.getElementById("viewer");
    var parentSize = {
        width: c.parentElement.clientWidth,
        height: c.parentElement.clientHeight,
    };

    var ctx = c.getContext("2d");
    ctx.canvas.width = parentSize.width;
    ctx.canvas.height = parentSize.height;

    var levelNumber = c.getAttribute('data-level');
    var tiles = window.OobDev.Zoom.Data.Levels[levelNumber].Tiles;

    for (var x = 0; x < tiles.X; x++) {
        for (var y = 0; y < tiles.Y; y++) {

            var pos = {
                y: window.OobDev.TileSize * y,
                x: window.OobDev.TileSize * x
            };

            var img = new Image;
            img.setAttribute('data-x', pos.x);
            img.setAttribute('data-y', pos.y);
            img.onload = function () {
                ctx.drawImage(this, this.getAttribute('data-x'), this.getAttribute('data-y'));
            };

            var imageUri = window.OobDev.MsitApiUri.concat('/', levelNumber, '/', x, '/', y);
            img.src = imageUri;

            pos = undefined;
        }
    }
}