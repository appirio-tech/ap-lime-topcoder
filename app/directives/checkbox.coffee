'use strict'

dependencies = [
  'lime-topcoder'
]

checkbox = ($window) ->
  {
    require: 'ngModel'
    link : (scope, element, attrs, ngModel) ->
      element.iCheck().on 'ifChecked', (event) ->
        scope.$apply () ->
          ngModel.$setViewValue event.target.checked
      .on 'ifUnchecked', (event) ->
        scope.$apply () ->
          ngModel.$setViewValue event.target.checked
  }

angular.module('app.directives', dependencies).directive 'checkbox', [checkbox]
