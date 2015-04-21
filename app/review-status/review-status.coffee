###
The review status controller displays pending and completed reviews (if any).
###

'use strict'

reviewStatus = ($scope, $state, $stateParams, ReviewService, Helpers, ENV) ->
  $scope.submissionDownloadPath = ENV.submissionDownloadPath
  $scope.domain       = ENV.domain
  $scope.loaded       = false
  $scope.challengeId  = $stateParams.challengeId || 30049140
  $scope.reviewsDue   = '04/23/2015 at 01:00pm PST'

  $scope.getNextReview = () ->
    if $scope.reviews.length >= 5
      alert 'You may only complete 5 reviews.'
      return

    ReviewService.getNextReview $scope.challengeId
    .then (data) ->
      newReviewId = data.data.result.content

      $state.go 'edit',
        challengeId: $scope.challengeId
        reviewId   : newReviewId

  ReviewService.getUsersPeerReviews $scope.challengeId
  .then (data) ->
    $scope.reviews   = data.data.result.content
    $scope.completed = Helpers.countCompleted $scope.reviews
    $scope.loaded    = true

angular.module('peerReview').controller 'reviewStatus', [
  '$scope'
  '$state'
  '$stateParams'
  'ReviewService'
  'Helpers'
  'ENV'
  reviewStatus
]
