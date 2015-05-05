'use strict'

login = ($scope, Auth, $state, $stateParams, $location) ->
  DEFAULT_STATE = 'landing'
  vm = this
  vm.loggingIn = false
  vm.retState = DEFAULT_STATE

  main = $scope.$parent.main;

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
      # prepares the return state of after successful login, defaults to landing state
      vm.retState = if $stateParams.retState then $stateParams.retState else DEFAULT_STATE
      vm.loggingIn = true
      #authenticate
      Auth.login vm.frm.username.value, vm.frm.password.value, handleSuccess, handleError

  # handles success event of the login action
  handleSuccess = (profile) ->
    vm.loggingIn = false
    main.activate()
    if $state.get vm.retState
      $state.go vm.retState
    else
      $state.go DEFAULT_STATE

  # handles error event of the login action
  handleError = (error) ->
    vm.loggingIn = false
    $scope.$apply () ->
      vm.frm.error = true
      vm.frm.errorMessage = 'Username or password is not correct'

angular.module('lime-topcoder').controller 'login', [
  '$scope'
  'Auth'
  '$state'
  '$stateParams'
  '$location'
  login
]