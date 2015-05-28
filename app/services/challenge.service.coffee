'use strict'

ChallengeService = (ENV, ApiService) ->
  getChallenges: (request) ->
    params =
      type        : if request?.type then request.type else 'develop'
      review      : if request?.review then request.review else 'PEER,COMMUNITY,INTERNAL'
      pageIndex   : if request?.pageIndex then request.pageIndex else 1
      pageSize    : if request?.pageSize then request.pageSize else 15
      sortColumn  : 'submissionEndDate'
      sortOrder   : 'desc'

    if request?.technologies
      params.technologies = request.technologies

    url = ENV.API_URL_V2 + '/challenges/active'
    ApiService.requestHandler 'GET', url, params, true

angular.module('lime-topcoder').factory 'ChallengeService', [
  'ENV'
  'ApiService'
  ChallengeService
]
