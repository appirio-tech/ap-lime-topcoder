'use strict'

AuthToken = (ENV, $window, $cookies) ->
  tokenKey = 'tcjwt'

  token =
    setToken: (token) ->
      options =
        domain: ENV.domain
        expires: new Date(new Date().getTime() + 12096e5)

      $cookies.put(tokenKey, token, JSON.stringify(options))

    getToken: () ->
      $cookies.get(tokenKey)

    removeToken: () ->
      $cookies.remove(tokenKey)

angular.module('lime-topcoder').factory 'AuthToken', [
  'ENV'
  '$window'
  '$cookies'
  AuthToken
]
