'use strict'

login = ($scope, Auth, $stateParams, $location) ->
  vm = this

  vm.frm =
    username: 
      value: ''
    password:
      value: ''
    error: false
    errorMessage: ''

  vm.isAuth = Auth.isAuthenticated

  vm.doLogin = () ->
    # error variables reset
    error = false
    vm.frm.username.error = false
    vm.frm.password.error = false

    # set appropriate validation flags on form fields
    if vm.frm.username.value.trim().length == 0
      error = true
      vm.frm.username.error = true
      vm.frm.username.errorMessage = 'required'

    if vm.frm.password.value.trim().length == 0
      error = true
      vm.frm.password.error = true
      vm.frm.password.errorMessage = 'required'

    # if all is well, call auth service for login
    if error == false
      # prepares landing page URL as default return URL
      landingUrl = $location.absUrl().substring(0, $location.absUrl().indexOf($location.url())) + '/'
      # prepare return URL from query string or use default
      retUrl = if $stateParams.retUrl then $stateParams.retUrl else landingUrl
      #authenticate
      Auth.login(vm.frm.username.value, vm.frm.password.value, retUrl, handleError)

  handleError = (error) ->
    $scope.$apply () ->
      vm.frm.error = true
      vm.frm.errorMessage = 'Username or password is not correct'

angular.module('lime-topcoder').controller 'login', [
  '$scope'
  'Auth'
  '$stateParams'
  '$location'
  login
]