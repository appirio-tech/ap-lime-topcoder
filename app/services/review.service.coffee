'use strict'

ReviewService = (ENV, ApiService) ->
  API_URL = ENV.API_URL + '/challenges/'

  getUsersPeerReviews: (challengeId) ->
    url = API_URL + challengeId + '/reviews'
    ApiService.requestHandler 'GET', url

  getReview: (challengeId, reviewId) ->
    url = API_URL + challengeId + '/reviews/' + reviewId
    ApiService.requestHandler 'GET', url

  getReviewItems: (challengeId, reviewId) ->
    url = API_URL + challengeId + '/reviews/' + reviewId + '/reviewItems'
    ApiService.requestHandler 'GET', url

  getNextReview: (challengeId) ->
    url = API_URL + challengeId + '/assignNextReview'
    ApiService.requestHandler 'PUT', url

  saveReviewItems: (body, challengeId, reviewId, isPreviouslySaved) ->
    method = if isPreviouslySaved then 'PUT' else 'POST'
    url = API_URL + challengeId + '/reviews/' + reviewId + '/reviewItems'
    ApiService.requestHandler method, url, JSON.stringify body

  markAsCompleted: (challengeId, reviewId) ->
    url = API_URL + challengeId + '/reviews/' + reviewId
    body =
      committed: 1
    ApiService.requestHandler 'PUT', url, JSON.stringify body

angular.module('peerReview').factory 'ReviewService', [
  'ENV'
  'ApiService'
  ReviewService
]
