'use strict'

ChallengeService = (ENV, ApiService) ->
  getChallenges: () ->
    params =
      type: 'develop'
      technologies: 'iOS,SWIFT'

    url = ENV.API_URL_V2 + '/challenges/active'
    ApiService.requestHandler 'GET', url, params, true

angular.module('lime-topcoder').factory 'ChallengeService', [
  'ENV'
  'ApiService'
  ChallengeService
]