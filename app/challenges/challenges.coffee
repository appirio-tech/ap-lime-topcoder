'use strict'

challenges = ($scope, $state, $stateParams, ChallengeService, Helpers, ENV) ->
  vm = this
  vm.domain = ENV.domain

  vm.slides = []
  vm.main = {hasMore: true, loading: false, pageIndex: 1, pageSize: 10, isGrid: false, first: true, challenges: [], tense: 'active'}
  vm.past = {hasMore: true, loading: false, pageIndex: 1, pageSize: 10, isGrid: false, challenges: [], tense: 'past'}
  vm.states = [vm.main]

  vm.challengesType = $stateParams.type

  if vm.challengesType == 'swiftoberfest'
    $state.go('challenges', {type: 'all'})

  getChallenges = (state) ->
    # prepares search request
    request =
      pageIndex: state.pageIndex
      pageSize: state.pageSize
      tense: state.tense

    # add review filter if required
    if vm.challengesType == 'peer'
      request.review = 'PEER'
      request.event = ENV.LIME_PROGRAM_ID

    if vm.challengesType == 'all'
      request.review = 'COMMUNITY,INTERNAL'

    if vm.challengesType == 'swiftoberfest'
      request.review = 'COMMUNITY,INTERNAL'

    # set loading flag
    state.loading = true

    # call API
    ChallengeService.getChallenges(request)
    .then (response) ->
      # set off loading flag
      state.loading = false

      # formats challenges for technologies, platforms array fields
      Helpers.formatArray response.data.data

      # process challenge for making info handy for the view
      Helpers.processChallenge challenge for challenge in response.data.data

      # filter challenges
      challenges = Helpers.filterChallenges response.data.data, vm.challengesType

      # append the retrieved challenges into existing collection
      state.challenges = state.challenges.concat challenges

      # total challenges applicable for the given filter
      total = challenges.length

      # detects if we need to show load more button
      if state.challenges.length == total
        state.hasMore = false
      else
        state.hasMore = true

      # prepares challenges to be shown in carousel
      if state.pageIndex == 1 and state == vm.main
        vm.slides = state.challenges.slice 0, 3

      #if vm.challengesType == 'peer'
      #  vm.reviewChallenges = vm.challenges.filter (challenge) ->
      #    challenge.currentPhaseName == 'Review'

      #  console.log vm.reviewChallenges

      #  vm.challenges = vm.challenges.filter (challenge) ->
      #    challenge.currentPhaseName != 'Review'

    .catch (error) ->
      # TODO show error
      state.loading = false


  loadMore = (state) ->
    console.log vm.pageIndex
    state.pageIndex++
    getChallenges(state)

  activate = () ->
    getChallenges(vm.main)
    if vm.challengesType == 'peer'
      getChallenges(vm.past)
      vm.states.push vm.past


  vm.loadMore = loadMore
  activate()

  return vm


angular.module('lime-topcoder').controller 'challenges', [
  '$scope'
  '$state'
  '$stateParams'
  'ChallengeService'
  'Helpers'
  'ENV'
  challenges
]
