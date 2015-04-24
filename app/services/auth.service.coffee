'use strict'

Auth = (ENV, $window, AuthToken, $state, $stateParams) ->
  auth0 = new Auth0
    domain: ENV.auth0Domain
    clientID: ENV.clientId
    callbackURL: ENV.auth0Callback
    
  # The page to which the browser will be forwarded after the login (can be the current page)
  # TODO fix me in this and ap-review, this cant go live
  if ENV.name == 'development'
    state = $window.encodeURIComponent 'retUrl=http://localhost:9001'
  else
    state = $window.encodeURIComponent 'retUrl=https://www.topcoder-dev.com/reviews/index.html'

  login: (username, password, errorCallback) ->
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