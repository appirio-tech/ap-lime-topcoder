'use strict'

login = ($scope, Auth) ->
  vm = this
  vm.msg = 'hello'
  vm.frm =
    username: 
      value: ''
    password:
      value: ''
    error: false
    errorMessage: ''
  vm.isAuth = Auth.isAuthenticated
  vm.doLogin = () ->
    error = false
    vm.frm.username.error = false
    vm.frm.password.error = false
    if vm.frm.username.value.trim().length == 0
      error = true
      vm.frm.username.error = true
      vm.frm.username.errorMessage = 'required'
    if vm.frm.password.value.trim().length == 0
      error = true
      vm.frm.password.error = true
      vm.frm.password.errorMessage = 'required'
    if error == false
      Auth.login(vm.frm.username.value, vm.frm.password.value, handleError)

  handleError = (error) ->
    $scope.$apply () ->
      vm.frm.error = true
      vm.frm.errorMessage = 'Username or password is not correct'

angular.module('lime-topcoder').controller 'login', [
  '$scope'
  'Auth'
  login
]