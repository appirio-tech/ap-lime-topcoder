'use strict'

register = ($scope, $state, Auth, Countries, ENV, $location, $cookies) ->
  DEFAULT_STATE = 'landing'
  COOKIE_NAME = 'topcoder_utm'
  current_date = new Date()
  COOKIE_EXPIRATION = new Date(current_date.getFullYear(), current_date.getMonth() + 1, current_date.getDate())

  vm = this
  vm.domain = ENV.domain
  vm.registering = false

  query_params = $location.search()
  utm = {}

  # Get the utm query parameters from the URL
  utm.utm_campaign = query_params.utm_campaign
  utm.utm_medium = query_params.utm_medium
  utm.utm_source = query_params.utm_source

  # Check if we have utm values - if not read from the cookie
  if !utm.utm_campaign || !utm.utm_medium || !utm.utm_source
    cookieValue = $cookies.getObject(COOKIE_NAME) || {}

    # Give preference to the values retrieved from the URL
    utm.utm_campaign = utm.utm_campaign || cookieValue.utm_campaign
    utm.utm_medium = utm.utm_medium || cookieValue.utm_medium
    utm.utm_source = utm.utm_source || cookieValue.utm_source

    #Store the values back in the cookie in case the URL query params have new values
    $cookies.putObject(COOKIE_NAME, utm, {expires:COOKIE_EXPIRATION})
  else
    $cookies.putObject(COOKIE_NAME, utm, {expires:COOKIE_EXPIRATION})

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

    vm.reg.utm_campaign = utm.utm_campaign
    vm.reg.utm_medium = utm.utm_medium
    vm.reg.utm_source = utm.utm_source

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

    GO_TO_STATE = if ($state.get vm.retState) then ($state.get vm.retState).url else ($state.get DEFAULT_STATE).url

    if (!$scope.$$phase)
      $scope.$apply () ->
        ($location.path GO_TO_STATE) .search('regsuccess', 'true')

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
  'Auth'
  'Countries'
  'ENV'
  '$location'
  '$cookies'
  register
]
