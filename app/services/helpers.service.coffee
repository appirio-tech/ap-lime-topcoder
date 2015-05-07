'use strict'

Helpers = () ->
  formatArray: (data) ->
    formatField = (key) ->
      challenge[key] = challenge[key].join ', '

    formatField 'technologies' for challenge in data
    formatField 'platforms' for challenge in data

angular.module('lime-topcoder').factory 'Helpers', [
  Helpers
]
