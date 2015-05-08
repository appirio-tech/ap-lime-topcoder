'use strict'

requiredDropdown = ($window) ->
  {
    require: 'ngModel'
    link : (scope, element, attrs, ngModel) ->
      ngModel.$validators.requiredDropdown = (modelValue, viewValue) ->
        console.log 'validating' + JSON.stringify viewValue
        console.log 'validating' + JSON.stringify modelValue
        if ngModel.$isEmpty(modelValue) 
          # consider empty models to be valid
          true

        if viewValue && viewValue.value >= 0 
          # it is valid
          true

        # it is invalid
        false
  }
angular.module('app.directives').directive 'requiredDropdown', [requiredDropdown]