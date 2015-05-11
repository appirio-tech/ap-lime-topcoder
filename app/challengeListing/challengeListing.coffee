'use strict'

challengeListing = ($scope, $http) ->
	$scope.challenges={};
	$scope.isGrid=false;
	$http.get 'content/data/challengeListing.json'
  .success (challenges) ->
      $scope.challenges = challenges

angular.module('lime-topcoder').controller 'challengeListing', [
  '$scope',
	'$http',
  challengeListing
]