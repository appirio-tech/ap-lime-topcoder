'use strict'

routes = ($stateProvider, $urlRouterProvider, $httpProvider) ->
  states =
    landing:
      url         : '/'
      templateUrl : 'landing/landing.html'
      controller  : 'landing'
    learn:
      url         : '/learn'
      templateUrl : 'learn/learn.html'
      controller  : 'learn'
    login:
      url         : '/login'
      templateUrl : 'login/login.html'
      controller  : 'login'
    register:
      url         : '/register'
      templateUrl : 'register/register.html'
      controller  : 'register'

  for name, state of states
    $stateProvider.state name, state

  $urlRouterProvider.otherwise '/'

  $httpProvider.interceptors.push 'HeaderInterceptor'

angular.module('lime-topcoder').config [
  '$stateProvider'
  '$urlRouterProvider'
  '$httpProvider'
  routes
]