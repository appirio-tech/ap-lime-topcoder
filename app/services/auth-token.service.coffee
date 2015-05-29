'use strict'

AuthToken = (ENV, $window, $cookies) ->
  tokenKey = 'tcjwt'
  cachedToken = null

  token =
    setToken: (token) ->
      $window.document.cookie = tokenKey + '=' + token + '; path=/; domain=.' + ENV.domain + '; expires=' + new Date(new Date().getTime() + 12096e5)
      cachedToken = token
    getToken: () ->
      if not cachedToken
        cachedToken = $cookies[tokenKey]
      cachedToken

    removeToken: () ->
      $window.document.cookie = tokenKey + '=; path=/; domain=.' + ENV.domain + '; expires=' + new Date(0).toUTCString()
      cachedToken = null

angular.module('lime-topcoder').factory 'AuthToken', [
  'ENV'
  '$window'
  '$cookies'
  AuthToken
]