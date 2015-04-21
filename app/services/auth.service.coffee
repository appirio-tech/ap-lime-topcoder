'use strict'

Auth = (ENV, $window, AuthToken, $state, $stateParams) ->
  lock = new Auth0Lock ENV.clientId, ENV.auth0Domain

  # The page to which the browser will be forwarded after the login (can be the current page)
  if ENV.name == 'development'
    state = $window.encodeURIComponent 'retUrl=http://localhost:9001'
  else
    state = $window.encodeURIComponent 'retUrl=https://www.topcoder-dev.com/reviews/index.html'


  # Displays the login widget and performs the login process
  login: () ->
    lock.show
      callbackURL: 'https://api.topcoder-dev.com/pub/callback.html'
      responseType: 'code'
      connections: ['LDAP']
      authParams:
        scope: 'openid profile offline_access'
        state: state
      usernameStyle: 'username'

  logout: () ->
    AuthToken.removeToken()
    $state.transitionTo $state.current, $stateParams,
      reload: true
      inherit: false
      notify: true

  isAuthenticated: () ->
    !!AuthToken.getToken()

angular.module('peerReview').factory 'Auth', [
  'ENV'
  '$window'
  'AuthToken'
  '$state'
  '$stateParams'
  Auth
]