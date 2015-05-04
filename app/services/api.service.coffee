# ApiService makes the actual API call

'use strict'

ApiService = ($http, AuthToken) ->
  requestHandler: (method, url, data) ->
    options =
      method : method
      url    : url
      headers: {
        'Authorization' : 'Bearer ' + AuthToken.getToken()
      }

    if data
      options.data = data

    if method == 'POST'
      options.headers['Content-Type'] = 'application/json'

    $http options

angular.module('lime-topcoder').factory 'ApiService',['$http', 'AuthToken', ApiService]