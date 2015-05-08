'use strict'

localTime = () ->
  timezone = jstz.determine().name()

  (input) ->
    moment(input).tz(timezone).format 'M/D/YY h:mm A z'

angular.module('lime-topcoder').filter 'localTime', localTime
