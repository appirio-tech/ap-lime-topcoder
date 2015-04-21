'use strict'

routes = ($stateProvider, $urlRouterProvider, $httpProvider) ->
  states =
    reviewStatus:
      url         : '/'
      templateUrl : 'review-status/review-status.html'
      controller  : 'reviewStatus'
      authenticate: true
    completed:
      url         : '/:challengeId/reviews/:reviewId/completed'
      templateUrl : 'completed-review/completed-review.html'
      controller  : 'completedReview'
      authenticate: true
    edit:
      url         : '/:challengeId/reviews/:reviewId/edit'
      templateUrl : 'edit-review/edit-review.html'
      controller  : 'editReview'
      authenticate: true

  for name, state of states
    $stateProvider.state name, state

  $urlRouterProvider.otherwise '/'

  $httpProvider.interceptors.push 'HeaderInterceptor'

angular.module('peerReview').config [
  '$stateProvider'
  '$urlRouterProvider'
  '$httpProvider'
  routes
]