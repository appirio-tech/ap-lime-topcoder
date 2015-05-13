'use strict'

UserService = (ENV, ApiService) ->
  getUsername: () ->
    url = ENV.API_URL_V2 + '/user/identity'
    ApiService.requestHandler 'GET', url

  getLoggedInUser: () ->
    url = ENV.API_URL_V2 + '/user/profile'
    ApiService.requestHandler 'GET', url

angular.module('lime-topcoder').factory 'UserService', [
  'ENV'
  'ApiService'
  UserService
]