'use strict'

dependencies = [
  'angular-jwt'
  'app.config'
  'app.directives'
  'ui.router'
  'ngDropdowns'
  'ui.bootstrap'
]

run = ($rootScope, $state, AuthToken, Auth) ->

  # If we are using V2 auth, we can probably delete this:

  # $rootScope.$on '$locationChangeStart', (event, newUrl, oldUrl) ->
  #   # When the url changes, checks if userJWTToken is in the query string.
  #   # If so, store it in local storage
  #   if newUrl.indexOf('userJWTToken') > -1
  #     console.log 'found JWT in url and storing it'
  #     AuthToken.storeQueryStringToken newUrl

  # On each state change, Angular will check for authentication
  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    # Check if the user is authenticated when the state requires authentication
    if toState.authenticate && !Auth.isAuthenticated()
      console.log 'State requires authentication, and user is not logged in.'
      # TODO Auth.login() should redirect to /login

angular.module('lime-topcoder', dependencies).run [
  '$rootScope'
  '$state'
  'AuthToken'
  'Auth'
  run
]
