'use strict'

peerChallenge = ($scope, $http) ->
	$scope.challenges={};
	$scope.isGrid=false;
	$http.get 'content/data/peerChallenges.json'
  .success (challenges) ->
      $scope.challenges = challenges

angular.module('lime-topcoder').controller 'peerChallenge', [
  '$scope',
	'$http',
  peerChallenge
]