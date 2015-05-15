'use strict'

learn = () ->
  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944

angular.module('lime-topcoder').controller 'learn', [
  learn
]
