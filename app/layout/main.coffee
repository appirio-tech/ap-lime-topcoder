'use strict'

main = ($scope, $state, ENV, AuthService, UserService) ->
  vm = this
  vm.domain = ENV.domain

  vm.loggedInUser = null
  vm.loading = false

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
    if $state.current.name == state
      true
    else
      false

  loginHandlers = {}
  vm.addLoginEventHandler = (name, handler) ->
    loginHandlers[name] = handler

  vm.activate = () ->
    if AuthService.isAuthenticated()
      vm.loading = true
      UserService.getLoggedInUser()
      .then (data) ->
        vm.loading = false
        vm.loggedInUser = data.data
        for name of loginHandlers
          handler = loginHandlers[name]
          if (handler && typeof handler == 'function')
            handler vm.loggedInUser
        vm.updatePhotoLink()
      .catch (error) ->
        vm.loading = false
        UserService.getUsername()
        .then (data) ->
          vm.loggedInUser =
            handle: data.data.handle
            photo: 'content/images/user.png'

  vm.activate()
  return vm

angular.module('lime-topcoder').controller 'main', [
  '$scope'
  '$state'
  'ENV'
  'Auth'
  'UserService'
  main
]