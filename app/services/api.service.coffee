# ApiService makes the actual API call

'use strict'

ApiService = ($http, AuthToken) ->
  requestHandler: (method, url, data, noAuth) ->
    options =
      method : method
      url    : url
      headers: {}

    token = AuthToken.getToken()
    if token and not noAuth
      options.headers =
        Authorization: 'Bearer ' + token

    if data and method isnt 'GET'
      options.data = data

    if data and method is 'GET'
      options.params = data

    if method is 'POST'
      options.headers['Content-Type'] = 'application/json'

    $http options

angular.module('lime-topcoder').factory 'ApiService', [
  '$http'
  'AuthToken'
  ApiService
]
