'use strict'

register = ($scope, $state, $stateParams, Auth, Countries, ENV) ->
  DEFAULT_STATE = 'landing'
  vm = this
  vm.domain = ENV.domain
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
    vm.reg.utm_campaign = $stateParams.utm_campaign
    vm.reg.utm_medium = $stateParams.utm_medium
    vm.reg.utm_source = $stateParams.utm_source

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

  regSuccess = () ->
    Auth.login vm.reg.handle, vm.reg.password, loginSuccess, loginError

  loginSuccess = () ->
    $scope.$parent.main.activate()

    if $state.get vm.retState
      $state.go vm.retState
    else
      $state.go DEFAULT_STATE, {regsuccess: true}

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

  return vm

angular.module('lime-topcoder').controller 'register', [
  '$scope'
  '$state'
  '$stateParams'
  'Auth'
  'Countries'
  'ENV'
  register
]
