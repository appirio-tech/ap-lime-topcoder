'use strict'

swiftoberfestInfo = ($scope, $stateParams, FaqService, LeaderboardService) ->
  vm = this
  vm.shown = []
  vm.questions = FaqService.getQuestions()
  vm.leaderboardMonth = 'overall'
  vm.loadingLeaderboard = true

  getScores = () ->
    vm.scores = []
    scores = {}
    if vm.leaderboardMonth != 'overall'
      for i in vm.rankings
        if i.month == vm.leaderboardMonth
          vm.scores = i.scores
    else
      for month in vm.rankings
        for participant in month.scores
          if scores.hasOwnProperty participant.handle
            scores[participant.handle] += participant.score
          else
            scores[participant.handle] = participant.score
      for key, value of scores
        participant = {}
        participant.handle = key
        participant.score = value
        vm.scores.push(participant)

  vm.changeLeaderboardMonth = (newMonth) ->
    vm.leaderboardMonth = newMonth
    getScores()

  vm.isLeaderboardMonth = (month) ->
    return vm.leaderboardMonth == month

  vm.toggleDisplay = (slug) ->
    console.log(slug)
    for q in vm.questions
      if (q.slug == slug)

        if (vm.shown.indexOf(slug) == -1)

          vm.shown.push(slug)

        else

          vm.shown.splice(vm.shown.indexOf(slug), 1)

  vm.isNotVisible = (slug) ->
    vm.shown.indexOf(slug) == -1

  LeaderboardService.getRankings()
  .then (response) ->
    vm.rankings = response.data
    vm.loadingLeaderboard = false
    getScores()

  return vm

angular.module('lime-topcoder').controller 'swiftoberfestInfo', [
  '$scope'
  '$stateParams'
  'FaqService'
  'LeaderboardService'
  swiftoberfestInfo
]
