'use strict'

MemberCertService = (ENV, ApiService) ->
  registerForProgram: (request) ->
    userId = request.userId
    programId = request.programId

    url = ENV.API_URL + '/memberCert/registrations/' + userId + '/programs/' + programId
    ApiService.requestHandler 'POST', url, null, true

  getProgramForUser: (request) ->
    userId = request.userId
    programId = request.programId

    url = ENV.API_URL + '/memberCert/registrations/' + userId + '/programs/' + programId
    ApiService.requestHandler 'GET', url, null, true

angular.module('lime-topcoder').factory 'MemberCertService', [
  'ENV'
  'ApiService'
  MemberCertService
]