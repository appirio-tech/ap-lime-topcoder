'use strict'

landing = ($scope, ChallengeService, Helpers) ->
  ChallengeService.getChallenges()
  .then (response) ->
    $scope.challenges = response.data.data.slice 0, 3
    Helpers.formatArray $scope.challenges

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  'ChallengeService'
  'Helpers'
  landing
]
