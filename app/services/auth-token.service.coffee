'use strict'

AuthToken = ($window, $location, Helpers, $http, ENV) ->
  storage = $window.localStorage
  userToken = 'userJWTToken'
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

    # Stores the JWT from the url into local storage
    storeQueryStringToken: (url) ->
      userJWTToken = Helpers.getParameterByName userToken, url

      if userJWTToken && storage
        storage.setItem userToken, userJWTToken

        absUrl = $location.absUrl()
        urlEnd =
        if   absUrl.indexOf('?') == -1
        then absUrl.length
        else absUrl.indexOf '?'

        clean_uri = absUrl.substring 0, urlEnd
        $window.location.replace clean_uri

    refreshToken: (token) ->
      options =
        url: ENV.API_URL + '/authorizations/1'
        # This makes it so that this request doesn't send the JWT
        skipAuthorization: true
        method: 'GET'
        headers:
          'Authorization': 'Bearer ' + token

      $http options

angular.module('peerReview').factory 'AuthToken', [
  '$window'
  '$location'
  'Helpers'
  '$http',
  'ENV'
  AuthToken
]