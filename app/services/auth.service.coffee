'use strict'

Auth = (ENV, $window, AuthToken, $state, $stateParams) ->
  auth0 = new Auth0
    domain: ENV.auth0Domain
    clientID: ENV.clientId
    callbackURL: ENV.auth0Callback

  login: (username, password, retUrl, errorCallback) ->
    state = $window.encodeURIComponent 'retUrl=' + retUrl
    auth0.signin({
      connection: 'LDAP',
      state: state,
      username: username,
      password: password,
    }, (err) ->
      console.log('login failed: ' + err)
      errorCallback err
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
  Auth
]