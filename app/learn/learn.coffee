'use strict'

learn = ($state) ->
  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944, (form) ->
    form.onSuccess () ->
      $state.go 'confirmNewsletter'
      false

angular.module('lime-topcoder').controller 'learn', [
  '$state'
  learn
]
