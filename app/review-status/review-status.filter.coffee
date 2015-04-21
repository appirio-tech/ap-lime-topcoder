'use strict'

angular.module('peerReview').filter 'reviewStatus', () ->
  (input) ->
    status = 'Not Submitted'
    if input == 1
      status = 'Completed'
    status
