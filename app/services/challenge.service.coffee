'use strict'

ChallengeService = (ENV, ApiService) ->
  getChallenges: (request) ->
    params =
      technologies: if request?.technologies then request.technologies else 'iOS,SWIFT,tvOS'
      review      : if request?.review then request.review else 'PEER,COMMUNITY,INTERNAL'
      pageIndex   : if request?.pageIndex then request.pageIndex else 1
      pageSize    : if request?.pageSize then request.pageSize else 15
      sortColumn  : 'submissionEndDate'
      sortOrder   : 'desc'

    if request?.type
      params.type = request.type

    if request?.event
      params.event = request.event

    url = ENV.API_URL_V2 + '/challenges/active'
    promise = ApiService.requestHandler 'GET', url, params, true
    promise

angular.module('lime-topcoder').factory 'ChallengeService', [
  'ENV'
  'ApiService'
  ChallengeService
]
