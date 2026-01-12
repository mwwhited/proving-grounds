ko.bindingHandlers.date = {
    update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        try {
            var value = valueAccessor();
            var date = eval(value.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
            var output = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();

            $(element).html('<span class="date" style="white-space: nowrap;">' + output + '</span>');
        }
        catch (err) {
            $(element).html('<span error-message="' + err.message + '"></span>');
        }
    }
}; 
ko.bindingHandlers.email = {
    update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var email = valueAccessor()
        $(element).html('<a href="mailto:' + email + '">' + email + '</a>');
    }
};