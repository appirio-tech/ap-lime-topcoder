'use strict'

autocollapseNavbar = ($window) ->
  {
    link : (scope, element, attrs) ->
      element.on 'click', '.navbar-collapse.in', (e) ->
        if( $(e.target).is('a') || $(e.target).parents('a'))
          $(this).collapse('hide')
  }

angular.module('app.directives').directive 'autocollapseNavbar', [autocollapseNavbar]
