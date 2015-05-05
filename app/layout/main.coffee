'use strict'

main = ($scope, ENV, AuthService, UserService) ->
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
        console.log error

  vm.activate()

angular.module('lime-topcoder').controller 'main', [
  '$scope'
  'ENV'
  'Auth'
  'UserService'
  main
]