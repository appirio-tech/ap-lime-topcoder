'use strict'

badges = ($scope, ENV, MemberCertService, $state, UserService) ->
  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944, (form) ->
    form.onSuccess () ->
      $state.go 'confirmNewsletter'
      false

  vm = this
  vm.registered = false
  vm.registrationSuccess = false
  vm.achievements = {}
  vm.hasDeveloperBadge = false
  vm.hasDesignerBadge = false
  vm.hasSYSBadge = false
  vm.registrationError = null
  main = $scope.$parent.main

  vm.getProfile = () ->
    if main.loggedInUser
      UserService.getLoggedInUser().then (response) ->
        vm.achievements = response.data.Achievements
        vm.hasDeveloperBadge = vm.achievements.some (achievement) ->
          achievement.description == 'Received Developer Badge'

        vm.hasDesignerBadge = vm.achievements.some (achievement) ->
          achievement.description == 'Received Designer Badge'

        vm.hasSYSBadge = vm.achievements.some (achievement) ->
          achievement.description == 'Received SYS Badge'

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
  main.addLoginEventHandler('badges', vm.getProfile)
  # check status on load
  vm.checkRegStatus()
  vm.getProfile()

  return vm

angular.module('lime-topcoder').controller 'badges', [
  '$scope'
  'ENV'
  'MemberCertService'
  '$state'
  'UserService'
  badges
]
