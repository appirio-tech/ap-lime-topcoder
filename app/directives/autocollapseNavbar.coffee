'use strict'

autocollapseNavbar = ($window) ->
  {
    link : (scope, element, attrs) ->
      element.on 'click', '.navbar-collapse.in', (e) ->
        # checks if the target is link
        link = if $(e.target).is('a') then $(e.target) else null
        # if target is not link, look for its any of the parents being a link
        link ?= if $(e.target).parents('a').length > 0 then $(e.target).parents('a') else null
        # if target is link and does not have class 'dropdown-toggle', hide menu
        if(link && !link.hasClass('dropdown-toggle'))
          $(this).collapse('hide')

      angular.element('body').on 'click', (e) ->
        clickover = $(e.target)
        # checks if the target is link
        link = if clickover.is('a') then clickover else null
        # if target is not link, look for its any of the parents being a link
        link ?= if clickover.parents('a').length > 0 then clickover.parents('a') else null
        _opened = $(".navbar-collapse").hasClass("in")
        if (_opened == true && !clickover.hasClass("navbar-toggle") && (!link || !link.hasClass("dropdown-toggle")))
            $("button.navbar-toggle").click();
  }

angular.module('app.directives').directive 'autocollapseNavbar', [autocollapseNavbar]
