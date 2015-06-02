'use strict'

landing = ($scope, $state, ChallengeService, Helpers, ENV) ->
  $scope.domain = ENV.domain

  # Make sure there are 3 challenges showing.
  # The first challenge should be of type 'PEER'.
  # If not, fill with other challenge types.
  ChallengeService.getChallenges review: 'PEER'
  .then (response) ->
    peerChallenges = response.data.data.slice 0, 1
    numPeerChallenges = peerChallenges.length

    ChallengeService.getChallenges(review: 'COMMUNITY,INTERNAL')
    .then (response) ->
      nonPeerChallenges = response.data.data.slice 0, 3
      if numPeerChallenges is 1
        $scope.challenges = peerChallenges.concat(nonPeerChallenges.slice 0, 2)
      else if numPeerChallenges is 0
        $scope.challenges = nonPeerChallenges

      Helpers.formatArray $scope.challenges
      Helpers.processChallenge challenge for challenge in $scope.challenges

  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944, (form) ->
    form.onSuccess () ->
      $state.go 'confirmNewsletter'
      false

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  '$state'
  'ChallengeService'
  'Helpers'
  'ENV'
  landing
]
