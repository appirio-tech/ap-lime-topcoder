'use strict'

landing = ($scope, $http) ->
  $http.get 'content/data/challenges.json'
  .success (challenges) ->
      $scope.challenges = challenges.slice 0, 3

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  '$http'
  landing
]
