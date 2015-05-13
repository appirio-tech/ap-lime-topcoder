'use strict'

landing = ($scope, ChallengeService, MarketoService, Helpers, ENV) ->
  $scope.domain = ENV.domain
  $scope.email = ''

  $scope.postForm = (email) ->
    console.log 'email ', email
    console.log 'scope ', $scope.email
    body =
      formid    : 'FO1944A1ZN1972LA1'
      munchkinId: '921-UOU-112'
      Email     : email

    MarketoService.sendEmail body
    .then (result) ->
      console.log 'result of send: ', result
      # in success do this:
      # $scope.email = '' - might not need this if doing below
      # set form to pristine in success


  ChallengeService.getChallenges()
  .then (response) ->
    $scope.challenges = response.data.data.slice 0, 3
    Helpers.formatArray $scope.challenges

angular.module('lime-topcoder').controller 'landing', [
  '$scope'
  'ChallengeService'
  'MarketoService'
  'Helpers'
  'ENV'
  landing
]
