'use strict'

register = ($scope, Auth, Countries) ->
  vm = this
  vm.registering = false
  
  vm.reg = null
  vm.frm =
    error: false
    errorMessage: ''
    countries: Countries.all

  vm.doRegister = () ->
    vm.registering = true
    vm.reg.regSource = 'apple'
    Auth.register vm.reg
    .then (data) ->
      vm.registering = false
      if data.data.error
        handleError data.data.error
      else handleSuccess
    .catch (data) ->
      vm.registering = false
      if data.data && data.data.error
        handleError data.data.error.details[0]
      else handleError

  vm.hasError = (field) ->
    form = $scope.frm
    return (form[field].$dirty || form.$submitted) && form[field].$invalid

  handleSuccess = () ->
    vm.registering = false
    console.log 'account created: ' + JSON.stringify vm.reg

  # handles error event of the login action
  handleError = (error) ->
    vm.registering = false
    # $scope.$apply () ->
    vm.frm.error = true
    vm.frm.errorMessage = 'Account could not be created. ' + error

angular.module('lime-topcoder').controller 'register', [
  '$scope'
  'Auth'
  'Countries'
  register
]