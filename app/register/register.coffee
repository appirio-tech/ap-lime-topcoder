'use strict'

register = ($scope, Auth, Countries) ->
  vm = this
  vm.registering = false

  createDropdownModel = (country, index) ->
    {text: country, value: index}
  
  vm.reg = {country: {value: -1, text: "Select Country"}}
  vm.frm =
    error: false
    errorMessage: ''
    countries: Countries.all.map createDropdownModel

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
    (form[field].$dirty || form.$submitted) && form[field].$invalid

  vm.handleAgree = () ->
    console.log(vm.frm.agree);
    vm.frm.agree = !vm.frm.agree

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