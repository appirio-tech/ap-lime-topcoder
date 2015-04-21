'use strict'

# We can probably tweak this if using V2 Auth:
# JwtConfig = ($httpProvider, jwtInterceptorProvider) ->

#   jwtInterceptor = (jwtHelper, AuthToken) ->
#     idToken = AuthToken.getToken 'userJWTToken'

#     console.log 'current token is: ', idToken
#     if idToken?
#       if jwtHelper.isTokenExpired idToken
#         console.log 'token is expired'
#         AuthToken.refreshToken idToken
#         .then (response) ->
#           idToken = response.data.result.content.token
#           console.log 'new token is: ', idToken
#           AuthToken.setToken idToken
#           idToken
#       else
#         console.log 'token is not expired'
#         idToken
#     else
#       console.log 'token does not exist'
#       ''

#   jwtInterceptor.$inject = ['jwtHelper', 'AuthToken']
#   jwtInterceptorProvider.tokenGetter = jwtInterceptor

#   $httpProvider.interceptors.push 'jwtInterceptor'

HeaderInterceptor = () ->
  attach =
    request: (request) ->
      request.headers['Accept'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'

      request

angular.module('lime-topcoder').factory 'HeaderInterceptor', HeaderInterceptor
# angular.module('lime-topcoder').config JwtConfig
