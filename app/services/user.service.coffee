'use strict'

UserService = (ENV, ApiService, jwtHelper, AuthToken) ->
  getUsername: () ->
    token = AuthToken.getToken()
    userId = jwtHelper.decodeToken(token).userId
    url = ENV.API_URL + '/users/' + userId
    ApiService.requestHandler 'GET', url

  getLoggedInUser: () ->
    token = AuthToken.getToken()
    decodedToken = jwtHelper.decodeToken(token)
    identities = decodedToken.identities
    if (identities.length > 0)
      identity = identities[0];
      if (identity.connection == 'LDAP')
        userId = identity.user_id.substring(5)
        url = ENV.API_URL_V2 + '/user/profile'
        ApiService.requestHandler 'GET', url

angular.module('lime-topcoder').factory 'UserService', [
  'ENV'
  'ApiService'
  'jwtHelper'
  'AuthToken'
  UserService
]