'use strict'

ChallengeService = (ENV, ApiService) ->
  getChallenges: (request) ->
    params =
      type: 'develop'
      technologies: 'iOS,SWIFT'
      pageIndex: if request && request.pageIndex then request.pageIndex else 1
      pageSize: if request && request.pageSize then request.pageSize else 5
      sortColumn: 'submissionEndDate'
      sortOrder: 'desc'

    url = ENV.API_URL_V2 + '/challenges/active'
    ApiService.requestHandler 'GET', url, params, true

angular.module('lime-topcoder').factory 'ChallengeService', [
  'ENV'
  'ApiService'
  ChallengeService
]