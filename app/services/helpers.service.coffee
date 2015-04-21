'use strict'

Helpers = ($window, $location) ->
  storeById: (object, questions) ->
    angular.forEach questions, (question) ->
      object[question.id] = question

  parseQuestions: (questions) ->
    angular.forEach questions, (question) ->
      index = question.description.indexOf '-'
      selectOne = index > -1

      if selectOne
        question.topic       = question.description.slice 0, index - 1
        question.description = question.description.slice index + 2
        question.guideline   = question.guideline.split '\n'
      else
        question.topic = 'Elaborate'

      if question.guideline[0][0] == '0'
        question.type = 'SELECT_ONE'
      else
        question.type = 'TEXT'

  parseAnswers: (questions, answers) ->
    saved = false
    angular.forEach answers, (answerObject) ->
      questionId = answerObject.scorecardQuestionId
      questions[questionId].answer = answerObject.answer
      questions[questionId].reviewItemId = answerObject.id
      if answerObject.answer != ''
        saved = true

    saved

  compileReviewItems: (questions, review, updating) ->
    reviewItems = []

    for qId, q of questions
      reviewItem =
        reviewId: review.id
        answer  : '' + q.answer

      if updating
        reviewItem.id = q.reviewItemId
      else
        reviewItem.scorecardQuestionId = parseInt qId
        reviewItem.uploadId = review.uploadId

      reviewItems.push reviewItem

    reviewItems

  countCompleted: (reviews) ->
    reviews.reduce((numCompleted, review) ->
      if review.committed == 1
        return numCompleted + 1
      numCompleted
    , 0)

  # Gets a query string parameter by name
  getParameterByName: (name, url) ->
    name    = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]')
    regex   = new RegExp('[\\?&]' + name + '=([^&#]*)')
    results = regex.exec url

    if results == null
      results = ''
    else
      results = $window.decodeURIComponent results[1].replace(/\+/g, ' ')

    results

angular.module('peerReview').factory 'Helpers', [
  '$window'
  '$location'
  Helpers
]
