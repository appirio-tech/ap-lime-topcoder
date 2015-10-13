'use strict'

dependencies = [
  'angular-jwt'
  'app.config'
  'app.directives'
  'ui.router'
  'ngCookies'
  'ngSanitize'
  'ui.bootstrap'
  'duScroll'
]

run = ($rootScope, $state, $location, Auth) ->
  # Attaching $state to the $rootScope allows us to access the
  # current state in index.html (see div with ui-view on the index page)
  $rootScope.$state = $state
  originalQuery = {}

  # Remember the old query params
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    originalQuery.params = $location.search()

  # On each state change, Angular will check for authentication
  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    # Keeps ui-router from loading pages half way down the page
    document.body.scrollTop = 0
    document.documentElement.scrollTop = 0

    $location.search angular.extend {}, originalQuery.params, toParams

    # Check if the user is authenticated when the state requires authentication
    if toState.authenticate && !Auth.isAuthenticated()
      console.log 'State requires authentication, and user is not logged in.'
      # TODO Auth.login() should redirect to /login

angular.module('lime-topcoder', dependencies).run [
  '$rootScope'
  '$state'
  '$location'
  'Auth'
  run
]
