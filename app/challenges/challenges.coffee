'use strict'

challenges = ($scope, $state, $stateParams, ChallengeService, Helpers, ENV) ->
  vm = this
  vm.domain = ENV.domain
  vm.loading = false

  vm.pageIndex = 1
  vm.challenges = []
  vm.slides = []

  vm.isGrid = false

  vm.challengesType = $stateParams.type

  getChallenges = () ->
    request =
      pageIndex: vm.pageIndex
    vm.loading = true
    ChallengeService.getChallenges(request)
    .then (response) ->
      vm.loading = false
      Helpers.formatArray response.data.data
      processChallenge challenge  for challenge in response.data.data
      vm.challenges = vm.challenges.concat response.data.data
      #console.log vm.challenges
      if vm.pageIndex == 1
        vm.slides = vm.challenges.slice 0, 3
    .catch (error) ->
      # TODO show error
      vm.loading = false

  processChallenge = (challenge) ->
    if challenge.reviewType && challenge.reviewType == 'PEER'
      challenge.icon = ''
    else
      challenge.icon = 'swift'

  loadMore = () ->
    console.log vm.pageIndex
    vm.pageIndex++
    getChallenges()

  activate = () ->
    getChallenges()


  vm.loadMore = loadMore
  activate()


angular.module('lime-topcoder').controller 'challenges', [
  '$scope'
  '$state'
  '$stateParams'
  'ChallengeService'
  'Helpers'
  'ENV'
  challenges
]