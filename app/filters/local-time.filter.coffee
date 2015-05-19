'use strict'

localTime = () ->
  timezone = jstz.determine().name()

  (input) ->
    moment(input).tz(timezone).format 'MM/DD/YY hh:mm A z'

angular.module('lime-topcoder').filter 'localTime', localTime
