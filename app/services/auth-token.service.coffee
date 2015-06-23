'use strict'

AuthToken = (ENV, $window, $cookies) ->
  tokenKey = 'tcjwt'

  token =
    setToken: (token) ->
      $window.document.cookie = tokenKey + '=' + token + '; path=/; domain=.' + ENV.domain + '; expires=' + new Date((new Date()).getTime() + 12096e5)

    getToken: () ->
      $cookies.get(tokenKey)

    removeToken: () ->
      $window.document.cookie = tokenKey + '=' + token + '; path=/; domain=.' + ENV.domain + '; expires=' + new Date(0).toUTCString()

angular.module('lime-topcoder').factory 'AuthToken', [
  'ENV'
  '$window'
  '$cookies'
  AuthToken
]
