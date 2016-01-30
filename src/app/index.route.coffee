angular.module 'players'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/main/main.html'
        controllerAs: 'main'
        controller: 'MainController'
      .state 'login',
        url: '/login'
        templateUrl: 'app/account/login.html'
        controller: 'LoginController'
      .state 'sign_up',
        url: '/sign_up'
        templateUrl: 'app/account/sign_up.html'
        controller: 'SignUpController'

    $urlRouterProvider.otherwise '/'
