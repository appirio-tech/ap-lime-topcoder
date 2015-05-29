'use strict'

HeaderInterceptor = () ->
  attach =
    request: (request) ->
      request.headers['Accept'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'

      request

angular.module('lime-topcoder').factory 'HeaderInterceptor', HeaderInterceptor
