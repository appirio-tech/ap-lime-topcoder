'use strict'

main = ($scope, $state, ENV, AuthService, UserService) ->
  vm = this

  vm.loggedInUser = null
  vm.loggingIn = false

  vm.updatePhotoLink = () ->
    user = vm.loggedInUser
    if user && user.photoLink != ''
      if user.photoLink.indexOf('//') != -1
        user.photo = user.photoLink
      else
        user.photo = ENV.photoLinkLocation + user.photoLink
    else
      user.photo = ENV.photoLinkLocation + '/i/m/nophoto_login.gif'

  vm.logout = () ->
    AuthService.logout()
    vm.loggedInUser = null

  vm.isActive = (state) ->
    console.log 'checking state'
    console.log 'current state is: ', $state.current.name
    console.log 'checking tab: ', state
    if $state.current.name == state
      console.log 'that is the current state'
      true
    false

  vm.activate = () ->
    if AuthService.isAuthenticated()
      vm.loggingIn = true
      UserService.getLoggedInUser()
      .then (data) ->
        vm.loggingIn = false
        vm.loggedInUser = data.data
        vm.updatePhotoLink()
      .catch (error) ->
        vm.loggingIn = false
        UserService.getUsername()
        .then (data) ->
          vm.loggedInUser = {
            "handle": data.data.handle,
            "photo": "content/images/user.png"
          }

  vm.activate()

angular.module('lime-topcoder').controller 'main', [
  '$scope'
  '$state'
  'ENV'
  'Auth'
  'UserService'
  main
]