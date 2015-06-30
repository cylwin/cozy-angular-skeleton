angular.module("cozy-angular-skeleton")
.controller "HomeCtrl", (
    $rootScope
    $scope
) ->
    console.log "HomeCtrl"

    $scope.name = "Cyril"
