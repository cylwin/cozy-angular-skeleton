
angular.module("cozy-angular-skeleton", [
    'ui.router'
])

.config (
    $stateProvider
    $urlRouterProvider
    $httpProvider
) ->

    $stateProvider

    .state "home",
      url: "/home"
      templateUrl: "templates/home.html"
      controller: "HomeCtrl"

    $urlRouterProvider.otherwise "/home"

.run (
    $rootScope
) ->
    console.log "RUN"


