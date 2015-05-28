'use strict'

challenges = ($scope, $state, $stateParams, $q, ChallengeService, Helpers, ENV) ->
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
    # prepares search request
    devReq =
      type: 'develop'
      technologies: 'iOS,SWIFT'
      pageIndex: vm.pageIndex
      pageSize: vm.pageSize

    # add review filter if required
    if vm.challengesType == 'peer'
      devReq.review = 'PEER'

    stdReq =
      type: 'design'
      pageIndex: vm.pageIndex
      pageSize: vm.pageSize

    if vm.challengesType == 'all'
      request.review = 'COMMUNITY,INTERNAL'

    # set loading flag
    vm.loading = true

    promises = [
      ChallengeService.getChallenges(devReq)
    ]

    if vm.challengesType == 'all'
      promises.push(ChallengeService.getChallenges(stdReq))

    # call API
    $q.all promises
    .then (response) ->
      devChallenges = response[0].data.data
      # total dev challenges applicable for the given filter
      devTotal = response[0].data.total
      stdChallenges = response[1]?.data.data
      # total studio challenges applicable for the given filter
      stdTotal = response[1]?.data.total
      stdTotal ?= 0

      # set off loading flag
      vm.loading = false

      # formats challenges for technologies, platforms array fields
      Helpers.formatArray devChallenges
      if stdChallenges
        Helpers.formatArray stdChallenges

      # process challenge for making info handy for the view
      Helpers.processChallenge challenge for challenge in devChallenges

      # append the retrieved challenges into existing collection
      vm.challenges = vm.challenges.concat devChallenges

      discardCount = 0
      if stdChallenges
        for challenge in stdChallenges
          if Helpers.filterStudioChallenge(challenge) == true
            Helpers.processChallenge(challenge)
            vm.challenges.push(challenge)
          else
            discardCount++

      total = devTotal + stdTotal

      # detects if we need to show load more button
      if vm.challenges.length == total - discardCount
        vm.hasMore = false
      else
        vm.hasMore = true

      # prepares challenges to be shown in carousel
      if vm.pageIndex == 1
        vm.slides = vm.challenges.slice 0, 3

    .catch (error) ->
      # TODO show error
      vm.loading = false

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
  '$q'
  'ChallengeService'
  'Helpers'
  'ENV'
  challenges
]