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
      url         : '/login?retUrl&retState'
      templateUrl : 'login/login.html'
      controller  : 'login'
    register:
      url         : '/register'
      templateUrl : 'register/register.html'
      controller  : 'register'
    confirmRegistration:
      url         : '/register/confirm'
      templateUrl : 'register/confirm.html'
      controller  : 'register'
    challengeListing:
      url         : '/challengeListing'
      templateUrl : 'challengeListing/challengeListing.html'
      controller  : 'challengeListing'
    peerChallenge:
      url         : '/peerChallenge'
      templateUrl : 'peerChallenge/peerChallenge.html'
      controller  : 'peerChallenge'

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
