'use strict'

UserService = (ENV, ApiService, jwtHelper, AuthToken) ->
  getUsername: () ->
    token = AuthToken.getToken()
    userId = jwtHelper.decodeToken(token).userId
    url = ENV.API_URL + '/users/' + userId
    ApiService.requestHandler 'GET', url

angular.module('peerReview').factory 'UserService', [
  'ENV'
  'ApiService'
  'jwtHelper'
  'AuthToken'
  UserService
]