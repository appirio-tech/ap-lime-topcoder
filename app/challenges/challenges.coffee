'use strict'

challenges = ($scope, $state, $stateParams, ChallengeService, Helpers, ENV) ->
  vm = this
  vm.domain = ENV.domain
  vm.loading = false

  vm.pageIndex = 1
  vm.pageSize = 10
  vm.hasMore = true
  vm.challenges = []
  vm.slides = []

  vm.isGrid = false

  vm.challengesType = $stateParams.type

  getChallenges = () ->
    request =
      pageIndex: vm.pageIndex
      pageSize: vm.pageSize
    if vm.challengesType == 'peer'
      request.review = 'PEER'
    vm.loading = true
    ChallengeService.getChallenges(request)
    .then (response) ->
      vm.loading = false
      Helpers.formatArray response.data.data
      total = response.data.total
      processChallenge challenge  for challenge in response.data.data
      vm.challenges = vm.challenges.concat response.data.data
      if vm.challenges.length == total
        vm.hasMore = false
      else
        vm.hasMore = true
      if vm.pageIndex == 1
        vm.slides = vm.challenges.slice 0, 3
    .catch (error) ->
      # TODO show error
      vm.loading = false

  processChallenge = (challenge) ->
    if challenge.reviewType && challenge.reviewType == 'PEER'
      challenge.icon = 'peer'
      challenge.thumb = 'content/images/peer-swift-challenge.png'
    else
      challenge.icon = 'swift'
      challenge.thumb = 'content/images/swift-challenge-1.png'

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