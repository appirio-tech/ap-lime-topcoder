'use strict'

LeaderboardService = (ENV, ApiService) ->
  getRankings: () ->
    url = ENV.LEADERBOARD_URL
    promise = ApiService.requestHandler 'GET', url, undefined, true
    promise

angular.module('lime-topcoder').factory 'LeaderboardService', [
  'ENV'
  'ApiService'
  LeaderboardService
]
