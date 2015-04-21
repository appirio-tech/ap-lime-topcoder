# ApiService makes the actual API call

'use strict'

ApiService = ($http) ->
  requestHandler: (method, url, data) ->
    options =
      method : method
      url    : url
      headers: {}

    if data
      options.data = data

    if method == 'POST'
      options.headers['Content-Type'] = 'application/json'

    $http options

angular.module('peerReview').factory 'ApiService',['$http', ApiService]