'use strict'

register = ($scope, $state, Auth, Countries) ->
  DEFAULT_STATE = 'landing'
  vm = this
  vm.registering = false

  createDropdownModel = (country, index) ->
    text: country
    value: index
  
  vm.reg = {}
  vm.frm =
    error: false
    errorMessage: ''
    countries: Countries.all.map createDropdownModel

  vm.doRegister = () ->
    vm.registering = true
    vm.frm.error = false
    vm.frm.errorMessage = ''
    vm.reg.regSource = 'apple'
    Auth.register vm.reg
    .then (data) ->
      vm.registering = false
      if data.data.error
        regError data.data.error
      else regSuccess()
    .catch (data) ->
      vm.registering = false
      if data.data && data.data.error
        regError data.data.error.details
      else regSuccess()

  vm.hasError = (field) ->
    form = $scope.frm
    (form[field].$dirty || form.$submitted) && form[field].$invalid

  vm.handleAgree = () ->
    console.log(vm.frm.agree);
    vm.frm.agree = !vm.frm.agree

  regSuccess = () ->
    Auth.login vm.reg.handle, vm.reg.password, loginSuccess, loginError

  loginSuccess = () ->
    $scope.$parent.main.activate()
    if $state.get vm.retState
      $state.go vm.retState
    else
      $state.go DEFAULT_STATE
          
  # handles error event of the login action
  regError = (error) ->
    vm.registering = false
    # $scope.$apply () ->
    vm.frm.error = true
    vm.frm.errorMessage = 'Account could not be created. ' + error
    
  loginError = (error) ->
    vm.registering = false
    vm.frm.error = true
    vm.frm.errorMessage = 'Your account was created, but we were unable to log you in. If this problem persists, please contact: support@topcoder.com'

angular.module('lime-topcoder').controller 'register', [
  '$scope'
  '$state'
  'Auth'
  'Countries'
  register
]