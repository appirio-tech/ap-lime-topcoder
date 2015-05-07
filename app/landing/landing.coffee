'use strict'

landing = ($scope, $http, $location) ->
  $http.get 'content/data/challenges.json'
  .success (challenges) ->
      $scope.challenges = challenges.slice 0, 3

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  '$http'
  '$location'
  landing
]
