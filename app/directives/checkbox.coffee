'use strict'

dependencies = [
  'lime-topcoder'
]

checkbox = ($window) ->
  link = (scope, element, attrs) ->
    element.iCheck();

angular.module('app.directives', dependencies).directive 'checkbox', [checkbox]
