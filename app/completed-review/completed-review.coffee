###
The completedReview controller displays a completed review.
###

'use strict'

completedReview = ($scope, $stateParams, ScorecardService, ReviewService, UserService, Helpers, $q, ENV) ->
  $scope.submissionDownloadPath = ENV.submissionDownloadPath
  $scope.domain    = ENV.domain
  challengeId      = $stateParams.challengeId
  $scope.loaded    = false
  $scope.scorecard =
    questions: {}
  $scope.stats =
    lastModified: '03.06.2015 01:55 EST'

  promises = [
    UserService.getUsername()
    ReviewService.getReview challengeId, $stateParams.reviewId
    ScorecardService.getScorecard challengeId
  ]

  $q.all promises
  .then (response) ->
    user      = response[0].data.result.content
    review    = response[1].data.result.content
    scorecard = response[2].data.result.content

    $scope.stats.username         = user.handle
    $scope.stats.submissionId     = review.submissionId
    $scope.stats.uploadId         = review.uploadId
    $scope.review                 = review
    $scope.scorecard.templateName = scorecard.name
    scorecardId                   = scorecard.id

    ScorecardService.getScorecardQuestions challengeId, scorecardId
    .then (data) ->
      # Store each question in $scope.scorecard.questions.
      # Key is the question id, value is the question itself.
      questions = data.data.result.content

      Helpers.storeById $scope.scorecard.questions, questions
      Helpers.parseQuestions $scope.scorecard.questions

      ReviewService.getReviewItems challengeId, $stateParams.reviewId
    .then (data) ->
      answers = data.data.result.content
      # Store answers at their corresponding question
      Helpers.parseAnswers $scope.scorecard.questions, answers

      $scope.loaded = true

  $scope.submit = () ->
    $state.go 'reviewStatus'


angular.module('peerReview').controller 'completedReview', [
  '$scope'
  '$stateParams'
  'ScorecardService'
  'ReviewService'
  'UserService'
  'Helpers'
  '$q'
  'ENV'
  completedReview
]