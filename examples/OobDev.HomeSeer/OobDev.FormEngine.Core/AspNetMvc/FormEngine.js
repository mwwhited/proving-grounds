window.onhashchange = function () {
    $('#__current_page').val(location.hash);
    showCurrentPage();
}

$(function () {
    ruleBuilder();
    showCurrentPage();

    var unchecked = $("input:radio,input:checkbox").filter(":not(:checked)");

    var uncheckedParents = unchecked.parent();
    uncheckedParents.find('li input,textarea,select')
                    .prop('disabled', true);

    unchecked.siblings("input:text")
             .prop('disabled', true);

    hideShow();
});

/* http://jqueryvalidation.org/validate */
$("form").validate({
    ignore: ":disabled", // ,:hidden
    errorPlacement: function ($errorLabel, $element) {
        var $elementToInsertAfter = $("#valid-" + $element.attr('id'));
        /*if ($element.prop("type") === "radio") {
            $elementToInsertAfter = $element.closest(".controls");
        }*/

        $errorLabel.insertAfter($elementToInsertAfter);
    }
    /*
    ,submitHandler: function (form) {
        //alert("This is a valid form!");
    }
    */
});

function ruleBuilder() {

    var rules = OobDev.Questionnaires.Rules;
    for (var idx = 0; idx < rules.length; idx++) {
        var rule = rules[idx];

        if (rule.type == 'set-if') {
            $("input[name='" + rule.sourceQuestion + "'][value='" + rule.sourceValue + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.is(':checked')) {
                    var updated = $('#' + _rule.data.targetId).prop('checked', true);
                    ensureChildrenEnabledDisabled(updated.attr('name'));
                }
            });
        } else if (rule.type == 'set-if-not') {
            $("input[name='" + rule.sourceQuestion + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.val() != _rule.data.sourceValue) {
                    if (self.is(':checked')) {
                        var updated = $('#' + _rule.data.targetId).prop('checked', true);
                        ensureChildrenEnabledDisabled(updated.attr('name'));
                    }
                }
            });
        } else if (rule.type == 'unset-if') {
            $("input[name='" + rule.sourceQuestion + "'][value='" + rule.sourceValue + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.is(':checked')) {
                    var updated = $('#' + _rule.data.targetId).prop('checked', false);
                    ensureChildrenEnabledDisabled(updated.attr('name'));
                }
            });
        } else if (rule.type == 'unset-if-not') {
            $("input[name='" + rule.sourceQuestion + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.val() != _rule.data.sourceValue) {
                    if (self.is(':checked')) {
                        var updated = $('#' + _rule.data.targetId).prop('checked', false);
                        ensureChildrenEnabledDisabled(updated.attr('name'));
                    }
                }
            });
        } else if (rule.type == 'disable-if') {
            $("input[name='" + rule.sourceQuestion + "'][value='" + rule.sourceValue + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.is(':checked')) {
                    var updated = $('#' + _rule.data.targetId).prop('disabled', true);
                    ensureChildrenEnabledDisabled(updated.attr('name'));
                }
            });
        } else if (rule.type == 'disable-if-not') {
            $("input[name='" + rule.sourceQuestion + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.val() != _rule.data.sourceValue) {
                    if (self.is(':checked')) {
                        var updated = $('#' + _rule.data.targetId).prop('disabled', true);
                        ensureChildrenEnabledDisabled(updated.attr('name'));
                    }
                }
            });
        } else if (rule.type == 'enable-if') {
            $("input[name='" + rule.sourceQuestion + "'][value='" + rule.sourceValue + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.is(':checked')) {
                    var updated = $('#' + _rule.data.targetId).prop('disabled', false);
                    ensureChildrenEnabledDisabled(updated.attr('name'));
                }
            });
        } else if (rule.type == 'enable-if-not') {
            $("input[name='" + rule.sourceQuestion + "']").change(rule, function (_rule) {
                var self = $(this);
                if (self.val() != _rule.data.sourceValue) {
                    if (self.is(':checked')) {
                        var updated = $('#' + _rule.data.targetId).prop('disabled', false);
                        ensureChildrenEnabledDisabled(updated.attr('name'));
                    }
                }
            });
        }

        var n = 0;
    }
}

function putFormData(_self, _url) {
    var self = $(_self);
    var form = self.closest("form");
    var formData = form.serialize();

    $.ajax({
        type: "PUT",
        data: formData,
        url: _url,
        complete: function (__jqHRX, __status) {
        },
        error: function (__req, __status, __error) {
            alert(__error);
        }
    });
}

function hidePage(_pageName) {

    if (_pageName == 'all') {
        showCurrentPage();
        $('#page-set div.page .page-controls').show();
    } else {
        $('#page-' + _page_Name).hide();
        $('#page-set div.page .page-controls').show();
    }
}

function showPage(_pageName) {

    if (_pageName == 'all') {
        $('#page-set div.page').show();
        $('#page-set div.page .page-controls').hide();
    } else if (_pageName == 'current') {
        showCurrentPage();
        $('#page-set div.page .page-controls').show();
    } else {
        $('#page-' + _page_Name).show();
        $('#page-set div.page .page-controls').show();
    }
}

function showCurrentPage() {
    var target = location.hash.substring(1, location.hash.length) || '';
    if (target == '') {
        target = $('#page-set').attr('data-entry-point');
    }

    $('#page-set div.page').hide();
    $('#page-' + target).show();
    $('#page-set div.page .page-controls').show();

    if ($('#page-' + target).length == 0) {
        $('#page-set').append("<div class='page' id='page-" + target + "'>Page &quot;" + target + "&quot; not found</div>");
    }
}

function setLinkedValue(_self) {
    var self = $(_self);
    var value = self.val();
    var target = $('#' + self.attr('data-linked'));
    target.val(value).prop('checked', true);
}

function focusLinked(_self) {
    var self = $(_self);
    var target = $('#' + self.attr('data-linked'));
    target.focus();
}

function checkLinkedSet(_self) {
    var self = $(_self);
    var groupName = self.attr('name');
    var group = $("input[name=" + groupName + "]");

    group.each(function (idx) {
        var item = $(this);
        var linked = $('#' + item.attr('data-linked'));
        if (linked) {
            if (item.is(':checked')) {
                linked.prop('disabled', false);
            } else {
                linked.prop('disabled', true);
            }
        }
    })

    /* add rules so checkboxes and radios can work together */
    if (self.is(':checked')) {
        var mytype = self.attr('type');
        var othertype = ''
        if (mytype == 'radio') {
            /* if radio and check in set and radio is selected uncheck all checks */
            othertype = 'checkbox';
        } else if (mytype == 'checkbox') {
            /* if radio and check in set and check is selected uncheck all radios */
            othertype = 'radio';
        }
        $("input[name='" + groupName + "'][type='" + othertype + "']:checked").attr("checked", false);
    }

    ensureChildrenEnabledDisabled(groupName);
}

function hideShow() {
    // Hide all children of unchecked 
    $("input[type='radio']:not(:checked),input[type=checkbox]:not(:checked)").filter(":not(:disabled)").siblings("ol").hide();

    $("input[type='radio']:checked,input[type=checkbox]:checked").filter(":not(:disabled)").siblings("ol").show();
}

function ensureChildrenEnabledDisabled(_groupName) {

    //$("input,select,textarea").prop('disabled', false);

    /* if child is set then enable child fields */
    var checked = $("input[name=" + _groupName + "]:checked").parent();
    checked.find('li input,textarea,select')
            .prop('disabled', false);
    /* if field is not checked then disable child fields */
    var unchecked = $("input[name=" + _groupName + "]:not(:checked)").parent();
    unchecked.find('li input,textarea,select')
             .prop('disabled', true);

    /* If "other" radio or checkbox is not checked then disable related textbox */
    $("input[type='checkbox']:not(:checked) ~ input[type='text']").prop('disabled', true);
    $("input[type='radio']:not(:checked) ~ input[type='text']").prop('disabled', true);
    /* If "other" radio or checkbox is checked then enable related textbox */
    $("input[type='checkbox']:checked ~ input[type='text']").prop('disabled', false);
    $("input[type='radio']:checked ~ input[type='text']").prop('disabled', false);

    hideShow();
}

var addOtherTrack = 0;

function addOtherBox(_self, inputType) {
    var self = $(_self);
    var parent = self.parent();

    var newIdNumber = addOtherTrack++;

    var questionId = self.attr('data-target-id') + '_' + newIdNumber;
    var groupName = self.attr('data-target-group');

    var newLi = $("<li />", {
        class: parent.attr('class'),
        id: parent.attr('id') + '_' + newIdNumber
    }).append(
      $('<input />', {
          name: groupName,
          id: questionId,
          type: inputType,
          'data-linked': 'secondary-' + questionId,
          onclick: "focusLinked(this)",
          onchange: "checkLinkedSet(this)"
      }),
      $('<label />', {
          text: 'Other',
          for: questionId
      }),
      $('<input />', {
          name: 'secondary-' + groupName,
          id: 'secondary-' + questionId,
          type: 'text',
          'data-linked': questionId,
          onchange: "setLinkedValue(this)"
      })
    ).insertBefore(parent);
}