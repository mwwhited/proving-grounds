/* Extend jQuery with functions for PUT and DELETE requests. */

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
    });
}

jQuery.extend({
    put: function (url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function (url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    },
});

(function ($) {
    // VERTICALLY ALIGN FUNCTION
    $.fn.vAlign = function() {
	    return $(this).each(function(i){
	    var ah = $(this).height();
	    var ph = $(this).parent().height();
	    var mh = Math.ceil((ph-ah) / 2);
        if (mh < 0) 
        {
            mh = 0;
        }

	    $(this).css('margin-top', mh);
	    });
    };
})(jQuery);