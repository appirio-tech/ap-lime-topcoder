'use strict'

main = ($scope, ENV, AuthService, UserService) ->
  vm = this

  vm.loggedInUser = null

  vm.updatePhotoLink = () ->
    user = vm.loggedInUser
    if (user && user.photoLink != '') 
      if (user.photoLink.indexOf('//') != -1)
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
      UserService.getLoggedInUser()
      .then (data) ->
        vm.loggedInUser = data.data
        vm.updatePhotoLink()
      .catch (error) ->
        console.log error

  vm.activate()

angular.module('lime-topcoder').controller 'main', [
  '$scope'
  'ENV'
  'Auth'
  'UserService'
  main
]