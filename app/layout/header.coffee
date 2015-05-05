'use strict'

header = ($scope, Auth) ->
  $scope.logout = Auth.logout
  $scope.login  = Auth.login
  $scope.isAuth = Auth.isAuthenticated

angular.module('lime-topcoder').controller 'header', [
  '$scope'
  'Auth'
  header
]