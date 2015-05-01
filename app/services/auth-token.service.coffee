'use strict'

AuthToken = ($window, $location, Helpers, $http, ENV) ->
  storage = $window.localStorage
  userToken = 'tcjwt'
  cachedToken = null

  token =
    setToken: (token) ->
      # CachedToken allows us to store jwt in variable
      # instead of always having to access local storage
      cachedToken = token
      storage.setItem userToken, token

    getToken: () ->
      if !cachedToken
        cachedToken = storage.getItem userToken
      cachedToken

    removeToken: () ->
      cachedToken = null
      storage.removeItem userToken

angular.module('lime-topcoder').factory 'AuthToken', [
  '$window'
  '$location'
  'Helpers'
  '$http',
  'ENV'
  AuthToken
]