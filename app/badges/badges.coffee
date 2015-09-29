'use strict'

badges = ($scope, ENV, MemberCertService, $state) ->
  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944, (form) ->
    form.onSuccess () ->
      $state.go 'confirmNewsletter'
      false

  vm = this
  vm.registered = false
  vm.registrationSuccess = false
  vm.registrationError = null
  main = $scope.$parent.main

  vm.checkRegStatus = () ->
    if !main.loggedInUser
      vm.registered = false
      return
    main.loading = true
    request =
      userId: main.loggedInUser.uid
      programId: ENV.LIME_PROGRAM_ID
    MemberCertService.getProgramForUser(request)
    .then (response) ->
      # set off loading flag
      main.loading = false
      registered = false
      if response.status == 200
        result = response.data.result
        program = result?.content
        if program
          vm.registered = true

    .catch (error) ->
      # TODO show error
      main.loading = false
      vm.registered = false

  vm.registerForProgram = () ->
    vm.registrationError = null
    if !main.loggedInUser
      vm.registrationError = 'Please login to participate'
      return
    main.loading = true
    request =
      userId: main.loggedInUser.uid
      programId: ENV.LIME_PROGRAM_ID
    MemberCertService.registerForProgram(request)
    .then (response) ->
      # set off loading flag
      main.loading = false
      if response.status == 200
        vm.registrationSuccess = true
        vm.registered = true
      else
        vm.registrationError = 'Unable to register. Please try after some time.'

    .catch (error) ->
      # TODO show error
      main.loading = false
      vm.registered = false
      vm.registrationSuccess = false
      vm.registrationError = 'Unable to register. Please try after some time.'

  # registers login even handler to handle timing of multiple ajax calls
  main.addLoginEventHandler('badges', vm.checkRegStatus)
  # check status on load
  vm.checkRegStatus()

  return vm

angular.module('lime-topcoder').controller 'badges', [
  '$scope'
  'ENV'
  'MemberCertService'
  '$state'
  badges
]
