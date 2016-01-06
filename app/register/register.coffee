'use strict'

register = ($scope, $state, Auth, Countries, ENV, $location, UtmCookieService, ISO3166) ->
  DEFAULT_STATE = 'landing'

  vm = this
  vm.domain = ENV.domain
  vm.registering = false

  createDropdownModel = (country, index) ->
    text: country.name
    value: country.alpha3

  vm.reg = {}
  vm.frm =
    error: false
    errorMessage: ''
    countries: ISO3166.getAllCountryObjects().map createDropdownModel

  vm.doRegister = () ->
    vm.registering = true
    vm.frm.error = false
    vm.frm.errorMessage = ''
    vm.reg.regSource = 'apple'

    utm = UtmCookieService.getFromCookie()

    vm.reg.utm_campaign = utm.utm_campaign
    vm.reg.utm_medium = utm.utm_medium
    vm.reg.utm_source = utm.utm_source

    Auth.register vm.reg
    .then (data) ->
      console.log('Success')
      console.log data
      vm.registering = false
      __gaTracker = __gaTracker || false
      __gaTracker && __gaTracker('send', 'event', 'register', 'submit')

      if data.data.result.status != 200
        regError data.data.result.content
      else regSuccess()

    .catch (data) ->
      vm.registering = false

      if data.data.result && data.data.result.content
        regError data.data.result.content
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
  'UtmCookieService'
  'ISO3166'
  register
]
