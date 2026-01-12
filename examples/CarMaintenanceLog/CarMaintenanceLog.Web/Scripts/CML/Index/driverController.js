angular.module('driverServices', ['ngResource'])
    .factory('Drivers', ['$resource', function ($resource) {
        return $resource(window.cml.base + 'api/Driver', {}, {
            query: { method: 'GET', params: {}, isArray: true }
        });
    }])
    .factory('Cars', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/Car', {}, {
            query: { method: 'GET', params: { driverid: '@driverId' }, isArray: true }
        });
    }])
    .factory('Fillups', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/Fillup', {}, {
            query: { method: 'GET', params: { id: '@id', '$top': 10, '$orderby': 'Date desc' }, isArray: true }
        });
    }])
    .factory('OilChanges', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/OilChange', {}, {
            query: { method: 'GET', params: { id: '@id', '$top': 10, '$orderby': 'Date desc' }, isArray: true }
        });
    }])
    .factory('Stations', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/Station', {}, {
            query: { method: 'GET', params: { id: '@id', '$orderby': 'Name' }, isArray: true }
        });
    }])
    .factory('MaintenanceSchedules', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/MaintenanceSchedule', {}, {
            query: { method: 'GET', params: { carid: '@carid', id: '@id', '$top': 10, '$orderby': 'Miles' }, isArray: true }
        });
    }])
    .factory('OtherServices', ['$resource', function ($resource, driverId) {
        return $resource(window.cml.base + 'api/OtherService', {}, {
            query: { method: 'GET', params: { carid: '@carid', id: '@id', '$top': 10, '$orderby': 'Date desc' }, isArray: true }
        });
    }])
;

angular.module('driverApp', ['ngRoute', 'driverServices'])
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
    .controller('DriversController', ['$scope', 'Drivers', function ($scope, _) {
        $scope.Drivers = [];
        $scope.SelectedDriver = null;

        $scope.selectDriver = function (_selected) {
            $scope.SelectedDriver = _selected;
        };
        $scope.clearSelectedDriver = function () {
            $scope.SelectedDriver = null;
        };

        _.query()
         .$promise
         .then(function (_drivers) {
             $scope.Drivers = _drivers;
             $scope.selectDriver(_drivers[0]);
         });
    }])
    .controller('CarsController', ['$scope', 'Cars', function ($scope, _) {
        $scope.Cars = [];
        $scope.SelectedCar = null;

        $scope.selectCar = function (_selected) {
            $scope.SelectedCar = _selected;
        };
        $scope.clearCar = function () {
            $scope.SelectedCar = null;
        };
        $scope.saveCar = function () {
            if ($scope.SelectedCar) {
                var ret = _.save($scope.SelectedCar, function (__data, __status, __header, __config) {
                    $scope.SelectedCar.CarID = __data.CarID;
                    $scope.refreshCars();
                });
            }
            SelectedCar.$save();
        };
        $scope.newCar = function () {
            $scope.SelectedCar = {
                CarID: 0,
                DriverID: $scope.SelectedDriver.DriverID,

                Make: '',
                Model: '',
                SubModel: '',
                Year: 2000,
                StartingMiles: 0,
                Notes: '',
                PurchasedDate: new Date(),
                TotalMiles: 0
            };
        };
        $scope.refreshCars = function () {
            $scope.SelectedCar = null;
            if ($scope.SelectedDriver)
            {
                _.query({ driverId: $scope.SelectedDriver.DriverID })
                 .$promise
                 .then(function (_cars) {
                     $scope.Cars = _cars;
                     $scope.selectCar(_cars[0]);
                     $scope.$apply();
                 });
            }
        };
        
        $scope.$watch('SelectedDriver', function (_new, _old) {
            $scope.refreshCars();
        });
    }])
    .controller('FillupController', ['$scope', 'Fillups', function ($scope, _) {
        $scope.FillUps = [];
        $scope.SelectedFillup = null;

        $scope.Calc_ExtendedCost = function (_fillup) {
            return _fillup.ExtendedCost = _fillup.CostPerGallon * _fillup.Gallons;
        };
        $scope.Calc_MilesPerGallon = function (_fillup) {
            return _fillup.MilesPerGallon = _fillup.TankMiles / _fillup.Gallons;
        };

        $scope.selectFillup = function (_selected) {
            $scope.SelectedFillup = _selected;
        };
        $scope.clearSelectedFillup = function () {
            $scope.SelectedFillup = null;
        };
        $scope.newFillup = function () {
            $scope.SelectedFillup = {
                FillUpID: 0,
                CarID: $scope.SelectedCar.CarID,
                Date: new Date(),

                CostPerGallon: 0,
                Gallons: 0,
                Octane: 0,
                TankMiles: 0,
                TotalMiles: 0,
                Station: '',
                Notes: ''
            };
        };
        $scope.saveFillup = function () {
            if ($scope.SelectedFillup) {
                var ret = _.save($scope.SelectedFillup, function (__data, __status, __header, __config) {
                    $scope.SelectedFillup.FillUpID = __data.FillUpID;
                    $scope.refreshFillup();
                });
            }
        };
        $scope.refreshFillup = function () {
            $scope.clearSelectedFillup();
            $scope.FillUps = _.query({ id: $scope.SelectedCar.CarID });
        };

        $scope.$watch('SelectedCar', function (_new, _old) {
            $scope.refreshFillup();
        });
    }])
    .controller('OilChangeController', ['$scope', 'OilChanges', function ($scope, _) {
        $scope.OilChanges = [];
        $scope.SelectedOilChange = null;

        $scope.selectOilChange = function (_selected) {
            $scope.SelectedOilChange = _selected;
        };
        $scope.clearSelectedOilChange = function () {
            $scope.SelectedOilChange = null;
        };
        $scope.newOilChange = function () {
            $scope.SelectedOilChange = {
                OilChangeID: 0,
                CarID: $scope.SelectedCar.CarID,
                Date: new Date(),

                ChangeMiles: 0,
                OilBrand: '',
                FilterBrand: '',
                Quarts: 0,
                OilCost: 0,
                FilterCost: 0,
                LaborCost: 0,
                TaxRate: 0,
                OtherCost: 0,
                Location: '',
                Notes: ''

                //ExtendedCost = item.ExtendedCost,
            };
        };
        $scope.saveOilChange = function () {
            if ($scope.SelectedOilChange) {
                var ret = _.save($scope.SelectedOilChange, function (__data, __status, __header, __config) {
                    $scope.SelectedOilChange.OilChangeID = __data.OilChangeID;
                    $scope.refreshOilChange();
                });
            }
        };
        $scope.refreshOilChange = function () {
            $scope.clearSelectedOilChange();
            $scope.OilChanges = _.query({ id: $scope.SelectedCar.CarID });
        };

        $scope.$watch('SelectedCar', function (_new, _old) {
            $scope.refreshOilChange();
        });
    }])
    .controller('StationController', ['$scope', 'Stations', function ($scope, _) {
        $scope.Stations = _.query();
    }])
    .controller('MaintenanceScheduleController', ['$scope', 'MaintenanceSchedules', function ($scope, _) {
        $scope.MaintenanceSchedules = [];
        $scope.SelectedMaintenanceSchedule = null;

        $scope.selectMaintenanceSchedule = function (_selected) {
            $scope.SelectedMaintenanceSchedule = _selected;
        };
        $scope.clearSelectedMaintenanceSchedule = function () {
            $scope.SelectedMaintenanceSchedule = null;
        };
        $scope.newMaintenanceSchedule = function () {
            $scope.SelectedMaintenanceSchedule = {
                MaintenanceScheduleID: 0,
                CarID: $scope.SelectedCar.CarID,
                Miles: 0,
                WorkItems: '',
                CompletedOn: null,
                IsComplete: false,
                PastDue: false
            };
        };
        $scope.saveMaintenanceSchedule = function () {
            if ($scope.SelectedMaintenanceSchedule) {
                var ret = _.save($scope.SelectedMaintenanceSchedule, function (__data, __status, __header, __config) {
                    $scope.SelectedMaintenanceSchedule.MaintenanceScheduleID = __data.MaintenanceScheduleID;
                    $scope.refreshMaintenanceSchedule();
                });
            }
        };
        $scope.refreshMaintenanceSchedule = function () {
            $scope.clearSelectedMaintenanceSchedule();
            $scope.MaintenanceSchedules = _.query({ carid: $scope.SelectedCar.CarID });
        };

        $scope.$watch('SelectedCar', function (_new, _old) {
            $scope.refreshMaintenanceSchedule();
        });
    }])
    .controller('OtherServiceController', ['$scope', 'OtherServices', function ($scope, _) {
        $scope.OtherServices = [];
        $scope.SelectedOtherService = null;

        $scope.selectOtherService = function (_selected) {
            $scope.SelectedOtherService = _selected;
        };
        $scope.clearSelectedOtherService = function () {
            $scope.SelectedOtherService = null;
        };
        $scope.newOtherService = function () {
            $scope.SelectedOtherService = {
                OtherServiceID: 0,
                CarID: $scope.SelectedCar.CarID,
                Date: new Date(),
                Miles: 0,
                Item: '',
                Cost: 0,
                Rate: 0,
                Location: '',
                Notes: '',
                ExtendedCost: 0
            };
        };
        $scope.saveOtherService = function () {
            if ($scope.SelectedOtherService) {
                var ret = _.save($scope.SelectedOtherService, function (__data, __status, __header, __config) {
                    $scope.SelectedOtherService.OtherServiceID = __data.OtherServiceID;
                    $scope.refreshOtherService();
                });
            }
        };
        $scope.refreshOtherService = function () {
            $scope.clearSelectedOtherService();
            $scope.OtherServices = _.query({ carid: $scope.SelectedCar.CarID });
        };

        $scope.$watch('SelectedCar', function (_new, _old) {
            $scope.refreshOtherService();
        });
    }])
;