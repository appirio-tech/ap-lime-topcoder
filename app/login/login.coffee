'use strict'

login = ($scope, Auth) ->
  $scope.login = Auth.login
  $scope.isAuth = Auth.isAuthenticated

angular.module('lime-topcoder').controller 'login', [
  '$scope'
  'Auth'
  login
]