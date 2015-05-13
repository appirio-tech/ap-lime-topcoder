'use strict'

MarketoService = (ApiService) ->
  sendEmail: (body) ->
    # Needs to be a server-side POST, not front-end:
    # for key, value of body
    #   body[key] = encodeURIComponent value

    # url = 'http://app-abc.marketo.com/index.php/leadCapture/save'
    # ApiService.requestHandler 'POST', url, JSON.stringify body, true


angular.module('lime-topcoder').factory 'MarketoService', [
  'ApiService'
  MarketoService
]
