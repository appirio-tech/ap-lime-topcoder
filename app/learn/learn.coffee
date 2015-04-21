'use strict'

learn = ($scope) ->
  $scope.loaded = false
  $scope.loaded = true

angular.module('lime-topcoder').controller 'learn', [
  '$scope'
  learn
]