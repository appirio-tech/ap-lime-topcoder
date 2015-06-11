'use strict'

dependencies = [
  'lime-topcoder'
]

# https://github.com/xialeistudio/angular-icheck

checkbox = () ->
  restrict: 'EA'
  transclude: true
  require: 'ngModel'
  replace: true
  template: '<div class="angular-icheck">\n    <div class="checkbox"></div>\n    <div class="label" ng-transclude></div>\n</div>'
  link: (scope, ele, attrs, ctrl) ->
    box = angular.element(ele[0].querySelector('.checkbox'))
    ele.bind 'click', ->
      box.toggleClass 'checked'
      ctrl.$setViewValue box.hasClass('checked')
      return

    ctrl.$render = ->
      if ctrl.$viewValue
        box.addClass 'checked'
      else
        box.removeClass 'checked'
      return

    return

angular.module('app.directives', dependencies).directive 'checkbox', [checkbox]
