
/// <reference path="../../../Scripts/jquery-1.7.2-vsdoc.js" />
/// <reference path="../../../Scripts/knockout-2.1.0.debug.js" /> 

function UserModel() {
    var self = this;
    /* Properties */

    self.Users = ko.observableArray();
    self.UsersRoles = ko.observableArray();
    self.OtherRoles = ko.observableArray();    
    
    self.CurrentPage = ko.observable(1);
    self.PageSize = ko.observable(20);
    self.TotalRowCount = ko.observable();
    self.TotalPageCount = ko.observable();

    self.UserName = ko.observable();
    self.Comment = ko.observable();
    self.Email = ko.observable();
    self.IsApproved = ko.observable();
    
    self.IsSelected = ko.observable();

    /* actions */
    self.listUsers = function () {
        var submitData = self.toPageRequestModel(self);
        $.post(Admin.Users.List, submitData, function (data) {
            self.clearUser();

            self.Users(data.Rows);
            self.CurrentPage(data.Page);
            self.PageSize(data.PageSize);
            self.TotalRowCount(data.TotalRowCount);
            self.TotalPageCount(data.TotalPageCount);
        });
    };
    self.saveUser = function () {
        var submitData = self.toSubmitModel(self);
        $.post(Admin.Users.Save, submitData, function (data) {
            if (data.Success) {
                self.selectUser(data.User);
                self.listUsers();
            }
        });
    };
    self.deleteUser = function () {
        var confirmed = confirm('Are you sure you want to delete user?');
        if (confirmed) {
            var submitData = self.toSubmitModel(self);
            $.delete_(Admin.Users.Delete, submitData, function (data) {
                if (data.Success) {
                    self.clearUser();
                    self.listUsers();
                }
            });
        }
    };

    self.listUserRoles = function(userName) {
        var submitData = { username: userName, };
        $.post(Admin.Roles.ForUser, submitData, function (data) {
            self.UsersRoles(data);
        });
    }
    self.listOtherRoles = function(userName) {
        var submitData = { username: userName, };
        $.post(Admin.Roles.ExceptForUser, submitData, function (data) {
            self.OtherRoles(data);
        });
    }

    self.assignRole = function(role){
        var submitData = { users: [self.UserName()], roles: [role.RoleName] };
        var param = $.param(submitData,true);
        $.put(Admin.Roles.Assign, param, function (data) {
            if (data.Success){                
                self.UsersRoles.push(role);
                self.OtherRoles.remove(role);
            }
        });
    };
    self.unassignRole = function(role){
        var submitData = { users: [self.UserName()], roles: [role.RoleName] };
        var param = $.param(submitData,true);
        $.delete_(Admin.Roles.Unassign, param, function (data) {
            if (data.Success){                
                self.OtherRoles.push(role);
                self.UsersRoles.remove(role);
            }
        });
    };

    self.changePage = function(targetPage) {
        if (self.CurrentPage() != targetPage) {
            self.CurrentPage(targetPage);
            self.listUsers();
        }
    };

    /* Tools */
    self.toSubmitModel = function (user) {
        return {
            UserName: user.UserName(),
            Comment: user.Comment(),
            Email: user.Email(),
            IsApproved: user.IsApproved(),
        };
    }
    self.toPageRequestModel = function (page) {
        return {
            page: page.CurrentPage(),
            pageSize: page.PageSize(),
        };
    }
    self.selectUser = function (user) {
        self.UserName(user.UserName);
        self.Comment(user.Comment);
        self.Email(user.Email);
        self.IsApproved(user.IsApproved);

        self.IsSelected(true);
        self.listUserRoles(user.UserName);
        self.listOtherRoles(user.UserName);
    }
    self.clearUser = function() {
        self.UserName('');
        self.Comment('');
        self.Email('');
        self.IsApproved(false);

        self.IsSelected(false);
    }

    self.readHash = function() {
        var hash = window.location.hash;
        if (hash) {
           $.each(hash.split('/'), function(index, value) {
                var para = value.split('=');
                if (para[0] == 'page' && para[1] != '' + self.CurrentPage()) {
                    self.CurrentPage(para[1]);
                    self.listUsers();
                }                    
           });
        }
    }
    self.setHash = function () {
        var page = self.CurrentPage();
        //var user = self.UserName();
        
        var hash = '#!/page=' + page; // + '/user=' + user;
        window.location.hash = hash;
    }
    self.CurrentPage.subscribe(function(newValue) {
        self.setHash();
    });
//    self.UserName.subscribe(function(newValue) {
//        self.setHash();
//    });

    /* Init */
    self.init = function () {
        self.readHash();
        $(window).bind('hashchange', self.readHash);

        //TODO: try to change this to lazy load http://www.knockmeout.net/2011/06/lazy-loading-observable-in-knockoutjs.html

        if (self.Users().length <= 0) {
            self.listUsers();
        }
        self.clearUser();
    };
    self.init();
}

var userModel = {};
$(function () {
    userModel = new UserModel();
    ko.applyBindings(userModel);
});