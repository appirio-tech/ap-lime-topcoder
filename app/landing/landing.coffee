'use strict'

landing = ($scope, ChallengeService, MarketoService, Helpers, ENV) ->
  $scope.domain = ENV.domain
  $scope.email = ''

  $scope.postForm = (email) ->
    console.log 'email ', email
    console.log 'scope ', $scope.email
    body =
      formid    : 'FO1944A1ZN1972LA1'
      munchkinId: '921-UOU-112'
      Email     : email

    MarketoService.sendEmail body
    .then (result) ->
      console.log 'result of send: ', result
      # in success do this:
      # $scope.email = '' - might not need this if doing below
      # set form to pristine in success


  # Make sure there are 3 challenges showing.
  # The first challenge should be of type 'PEER'.
  # If not, fill with other challenge types.
  ChallengeService.getChallenges review: 'PEER'
  .then (response) ->
    peerChallenges = response.data.data.slice 0, 1
    numPeerChallenges = peerChallenges.length

    ChallengeService.getChallenges()
    .then (response) ->
      nonPeerChallenges = response.data.data.slice 0, 3
      if numPeerChallenges == 1
        $scope.challenges = peerChallenges.concat(nonPeerChallenges.slice 0, 2)
      else if numPeerChallenges == 0
        $scope.challenges = nonPeerChallenges

      Helpers.formatArray $scope.challenges
      Helpers.processChallenge challenge for challenge in $scope.challenges

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  'ChallengeService'
  'MarketoService'
  'Helpers'
  'ENV'
  landing
]
