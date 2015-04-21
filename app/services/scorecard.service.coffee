'use strict'

ScorecardService = (ENV, ApiService) ->
  getScorecard: (challengeId) ->
    url = ENV.API_URL + '/challenges/' + challengeId + '/scorecards'
    ApiService.requestHandler 'GET', url
  getScorecardQuestions: (challengeId, scorecardId) ->
    url = ENV.API_URL + '/challenges/' + challengeId + '/scorecards/' + scorecardId + '/scorecardQuestions'
    ApiService.requestHandler 'GET', url

angular.module('peerReview').factory 'ScorecardService', [
  'ENV'
  'ApiService'
  ScorecardService
]