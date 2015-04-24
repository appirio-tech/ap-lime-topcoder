'use strict'

register = ($scope) ->
  vm = this
  vm.reg = null
  vm.doRegister = () ->
    console.log(vm.reg)
    # TODO call user service for registration

  vm.hasError = (field) ->
    form = $scope.frm
    return (form[field].$dirty || form.$submitted) && form[field].$invalid

angular.module('lime-topcoder').controller 'register', [
  '$scope'
  register
]