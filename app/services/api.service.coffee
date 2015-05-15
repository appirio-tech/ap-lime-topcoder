# ApiService makes the actual API call

'use strict'

ApiService = ($http, AuthToken) ->
  requestHandler: (method, url, data, noAuth) ->
    options =
      method : method
      url    : url
      headers: {}

    token = AuthToken.getToken()
    if token && !noAuth
      options.headers =
        Authorization: 'Bearer ' + token

    if data && method != 'GET'
      options.data = data

    if data && method == 'GET'
      options.params = data

    if method == 'POST'
      options.headers['Content-Type'] = 'application/json'

    $http options

angular.module('lime-topcoder').factory 'ApiService',['$http', 'AuthToken', ApiService]
