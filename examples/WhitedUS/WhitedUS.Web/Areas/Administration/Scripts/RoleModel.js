function RoleModel(roleName) {
    var self = this;
    self.RoleName = ko.observable(roleName);
}

function RoleSetModel() {

    var self = this;
    /* Properties */

    self.roles = ko.observableArray();
    self.RoleName = ko.observable();

    /* actions */
    self.getRoles = function(){
        var submitData = {};
        $.post(Admin.Roles.List, submitData, function (data) {
            self.roles(data);
        });
    };
    self.addRole = function () {
        var submitData = { RoleName: self.RoleName() };
        $.put(Admin.Roles.Create, submitData, function (data) {
            self.clearRole();
            self.roles(data);
        });
    };
    self.deleteRole = function (role) {
        var confirmed = confirm('Are you sure you want to delete role?');
        if (confirmed) {
            var submitData = { RoleName: role.RoleName, };
            $.delete_(Admin.Roles.Delete, submitData, function (data) {
                self.clearRole();
                self.roles(data);
            });
        }
    }

    /* Tools */
    self.init = function () {
        //TODO: try to change this to lazy load http://www.knockmeout.net/2011/06/lazy-loading-observable-in-knockoutjs.html
        self.getRoles();
        self.clearRole();
    };
    self.clearRole = function () {
        self.RoleName('');
    }

    self.init();
};

var roleModel = {};
$(function () {
    roleModel = new RoleModel();
    ko.applyBindings(roleModel); 
});