'use strict'

Auth = (ENV, $window, AuthToken, $state, $stateParams, $location, $timeout) ->
  auth0 = new Auth0
    domain: ENV.auth0Domain
    clientID: ENV.clientId
    callbackURL: ENV.auth0Callback

  login: (username, password, retUrl, errorCallback) ->
    auth0.signin({
      connection: 'LDAP',
      scope: 'openid profile',
      username: username,
      password: password,
    }, (err, profile, id_token, access_token, state) ->
      if (err) 
        errorCallback err
      else
        AuthToken.setToken id_token
        $timeout $location.path retUrl
    )

  logout: () ->
    AuthToken.removeToken()
    $state.transitionTo $state.current, $stateParams,
      reload: true
      inherit: false
      notify: true

  isAuthenticated: () ->
    !!AuthToken.getToken()

angular.module('lime-topcoder').factory 'Auth', [
  'ENV'
  '$window'
  'AuthToken'
  '$state'
  '$stateParams'
  '$location'
  '$timeout'
  Auth
]