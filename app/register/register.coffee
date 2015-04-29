'use strict'

register = ($scope, Auth) ->
  vm = this
  vm.registering = false
  
  vm.reg = null
  vm.frm =
    error: false
    errorMessage: ''

  vm.doRegister = () ->
    vm.registering = true
    vm.reg.regSource = 'apple'
    Auth.register vm.reg
    

  vm.hasError = (field) ->
    form = $scope.frm
    return (form[field].$dirty || form.$submitted) && form[field].$invalid

  handleSuccess = (profile) ->
    vm.registering = false
    console.log 'account created: ' + JSON.stringify vm.reg

  # handles error event of the login action
  handleError = (error) ->
    vm.registering = false
    $scope.$apply () ->
      vm.frm.error = true
      vm.frm.errorMessage = 'Account could not be created.'

angular.module('lime-topcoder').controller 'register', [
  '$scope'
  'Auth'
  register
]