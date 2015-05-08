# ApiService makes the actual API call

'use strict'

ApiService = ($http, AuthToken) ->
  requestHandler: (method, url, data, noAuth) ->
    options =
      method : method
      url    : url
      headers: {
        'Authorization' : 'Bearer ' + AuthToken.getToken()
      }

    if data && method != 'GET'
      options.data = data

    if data && method == 'GET'
      options.params = data

    if method == 'POST'
      options.headers['Content-Type'] = 'application/json'

    if noAuth
      delete options.headers.Authorization

    $http options

angular.module('lime-topcoder').factory 'ApiService',['$http', 'AuthToken', ApiService]