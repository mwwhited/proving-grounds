angular.module('accountingServices', ['ngResource'])
    .factory('Customers', ['$resource', function ($resource) {
        return $resource(window.cml.base + 'api/Customer', {}, {
            query: { method: 'GET', params: {}, isArray: true }
        });
    }])
    .factory('Invoices', ['$resource', function ($resource) {
        return $resource(window.cml.base + 'api/Invoice', {}, {
            query: {
                method: 'GET', params: {
                    customerId: "@customerId",
                    '$top': 12,
                    '$orderby': 'InvoiceDate desc'
                }, isArray: true
            },
            pdf: {
                method: 'GET',
                headers: {
                    accept: 'application/pdf'
                },
                responseType: 'arraybuffer',
                cache: true,
                transformResponse: function (data, headers) {
                    var pdf, filename;
                    if (data) {
                        if (headers) {
                            var cd = headers()['content-disposition'].split(';');
                            for (var i = 0; i < cd.length; i++) {
                                var fn = cd[i].split('=');
                                if (fn[0].trim() == "filename") {
                                    filename = fn[1];
                                    break;
                                }
                            }
                        }

                        pdf = new Blob([data], {
                            type: 'application/pdf'
                        });
                    }
                    return {
                        pdf: pdf,
                        filename: filename
                    };
                },
                params: {
                    customerId: "@customerId",
                    invoiceId: "@invoiceId"
                }
            }
        });
    }])
    .factory('Projects', ['$resource', function ($resource) {
        return $resource(window.cml.base + 'api/Project', {}, {
            query: {
                method: 'GET', params: {
                    customerId: "@customerId",
                    '$top': 12,
                    '$orderby': 'Name'
                }, isArray: true
            }
        });
    }])
    .factory('TimeLogs', ['$resource', function ($resource) {
        return $resource(window.cml.base + 'api/TimeLog', {}, {
            query: {
                method: 'GET', params: {
                    projectId: "@projectId",
                    '$top': 25,
                    '$orderby': 'Date desc'
                }, isArray: true
            }
        });
    }])
;

angular.module('accountingApp', ['ngRoute', 'accountingServices'])
    .directive('showTab', function () {
        return {
            link: function (scope, element, attrs) {
                element.click(function (e) {
                    e.preventDefault();
                    $(element).tab('show');
                });
            }
        };
    })
    .controller('CustomerController', ['$scope', 'Customers', function ($scope, _) {
        $scope.Customers = [];
        $scope.SelectedCustomer = null;

        $scope.selectCustomer = function (_selected) {
            $scope.SelectedCustomer = _selected;
        };
        $scope.clearSelectedCustomer = function () {
            $scope.SelectedCustomer = null;
        };
        $scope.newCustomer = function () {
            $scope.SelectedCustomer = {
                CustomerID: 0,
                CompanyName: '',
                FirstName: '',
                LastName: '',
                Address1: '',
                Address2: '',
                City: '',
                State: '',
                PostalCode: '',
                Country: '',
                AccountingEmail: '',
                ContractEmail: '',
                Phone: '',
                Notes: ''
            };
        };
        $scope.saveCustomer = function () {
            if ($scope.SelectedCustomer) {
                var ret = _.save($scope.SelectedCustomer, function (__data, __status, __header, __config) {
                    $scope.SelectedCustomer.CustomerID = __data.CustomerID;
                    $scope.refreshCustomer();
                });
            }
        };
        $scope.refreshCustomer = function () {
            $scope.clearSelectedCustomer();
            $scope.Customers = _.query({}, function () {
                $scope.SelectedCustomer = $scope.Customers[0];
            });
        };

        setImmediate(function () {
            $scope.refreshCustomer();
        });

        //$scope.$watch('SelectedCar', function (_new, _old) {
        //    $scope.refreshCustomer();
        //});
    }])
    .controller('InvoiceController', ['$scope', 'Invoices', function ($scope, _) {
        $scope.Invoices = [];
        $scope.SelectedInvoice = null;

        $scope.selectInvoice = function (_selected) {
            $scope.SelectedInvoice = _selected;
        };
        $scope.clearSelectedInvoice = function () {
            $scope.SelectedInvoice = null;
        };
        $scope.newInvoice = function () {
            $scope.SelectedInvoice = {
                CustomerID: 0,
                Notes: "",
                InvoiceDate: new Date(),
                DueDate: new Date(),
                TermsID: 1,
                TermsAndConditions: null,
                InvoiceStatusCode: "New",
                InvoiceNumber: "1100",
                PaidDate: null,
                Comment: ""
            };
        };
        $scope.saveInvoice = function () {
            if ($scope.SelectedInvoice) {
                var ret = _.save($scope.SelectedInvoice, function (__data, __status, __header, __config) {
                    $scope.SelectedInvoice.InvoiceID = __data.InvoiceID;
                    $scope.refreshInvoice();
                });
            }
        };
        $scope.refreshInvoice = function () {
            $scope.clearSelectedInvoice();
            $scope.Invoices = _.query({ customerId: $scope.SelectedCustomer.CustomerID });
        };
        $scope.downloadPdf = function (_selected) {
            var pdfBlob = _.pdf({
                customerId: $scope.SelectedCustomer.CustomerID,
                invoiceId: _selected.InvoiceID
            }, function (resp) {
                saveAs(resp.pdf, resp.filename || "invoice.pdf");
            });
        };

        setImmediate(function () {
            $scope.refreshInvoice();
        });

        $scope.$watch('SelectedCustomer', function (_new, _old) {
            $scope.refreshInvoice();
        });
    }])
    .controller('TimeLogController', ['$scope', 'Projects', 'TimeLogs', function ($scope, _p, _t) {
        $scope.Projects = [];
        $scope.SelectedProject = null;

        $scope.TimeLogs = [];
        $scope.SelectedTimeLog = null;

        $scope.selectProject = function (_selected) {
            $scope.SelectedProject = _selected;
        };
        $scope.clearSelectedProject = function () {
            $scope.SelectedProject = null;
        };
        $scope.selectTimeLog = function (_selected) {
            $scope.SelectedTimeLog = _selected;
        };
        $scope.clearSelectedTimeLog = function () {
            $scope.SelectedTimeLog = null;
        };


        //$scope.newInvoice = function () {
        //    $scope.SelectedInvoice = {
        //        CustomerID: 0,
        //        Notes: "",
        //        InvoiceDate: new Date(),
        //        DueDate: new Date(),
        //        TermsID: 1,
        //        TermsAndConditions: null,
        //        InvoiceStatusCode: "New",
        //        InvoiceNumber: "1100",
        //        PaidDate: null,
        //        Comment: ""
        //    };
        //};
        //$scope.saveInvoice = function () {
        //    if ($scope.SelectedInvoice) {
        //        var ret = _.save($scope.SelectedInvoice, function (__data, __status, __header, __config) {
        //            $scope.SelectedInvoice.InvoiceID = __data.InvoiceID;
        //            $scope.refreshInvoice();
        //        });
        //    }
        //};
        $scope.refreshProjects = function () {
            $scope.clearSelectedProject();
            _p.query({ customerId: $scope.SelectedCustomer.CustomerID })
              .$promise
              .then(function (_projects) {
                  $scope.Projects = _projects;
                  $scope.SelectedProject = _projects[0];
              });
        };
        $scope.refreshTimeLogs = function () {
            $scope.clearSelectedTimeLog();
            $scope.TimeLogs = _t.query({ projectId: $scope.SelectedProject.ProjectID });
        };

        setImmediate(function () {
            $scope.refreshProjects();
        });

        $scope.$watch('SelectedCustomer', function (_new, _old) {
            $scope.refreshProjects();
        });
        $scope.$watch('SelectedProject', function (_new, _old) {
            $scope.refreshTimeLogs();
        });
    }])
;