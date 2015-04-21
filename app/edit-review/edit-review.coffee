###
The editReview controller fetches the scorecard template and any
answers saved but not submitted.
###

'use strict'

editReview = ($scope, $state, $stateParams, ReviewService, ScorecardService, UserService, Helpers, $q, ENV) ->
  $scope.submissionDownloadPath = ENV.submissionDownloadPath
  $scope.domain       = ENV.domain
  challengeId         = $stateParams.challengeId
  $scope.loaded       = false
  $scope.saved        = false
  $scope.scorecard    =
    questions: {}
  $scope.stats        =
    lastModified: '03.06.2015 01:56 EST'

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
      questions = data.data.result.content

      # Store each question in $scope.scorecard.questions.
      # Key is the question id, value is the question itself.
      Helpers.storeById $scope.scorecard.questions, questions
      Helpers.parseQuestions $scope.scorecard.questions

      ReviewService.getReviewItems challengeId, $stateParams.reviewId
    .then (data) ->
      answers = data.data.result.content
      # Store answers at their corresponding question and return true
      # if there are saved answers
      $scope.saved = Helpers.parseAnswers $scope.scorecard.questions, answers

      $scope.loaded = true

  $scope.submitReviewItems = () ->
    body = Helpers.compileReviewItems $scope.scorecard.questions, $scope.review, $scope.saved

    promises = [
      ReviewService.saveReviewItems body, challengeId, $stateParams.reviewId, $scope.saved
      ReviewService.markAsCompleted challengeId, $stateParams.reviewId
    ]

    $q.all promises
    .then (response) ->
      $state.go 'reviewStatus'

  $scope.saveReviewForLater = () ->
    body = Helpers.compileReviewItems $scope.scorecard.questions, $scope.review, $scope.saved

    ReviewService.saveReviewItems(body, challengeId, $stateParams.reviewId, $scope.saved)
    .then (data) ->
      $state.go 'reviewStatus'

angular.module('peerReview').controller 'editReview', [
  '$scope'
  '$state'
  '$stateParams'
  'ReviewService'
  'ScorecardService'
  'UserService'
  'Helpers'
  '$q'
  'ENV'
  editReview
]