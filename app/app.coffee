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
  # Attaching $state to the $rootScope allows us to access the
  # current state in index.html (see div with ui-view on the index page)
  $rootScope.$state = $state

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
