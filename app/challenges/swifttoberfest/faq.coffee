'use strict'

swiftoberfestFaq = ($scope, $stateParams, FaqService, Helpers) ->
  vm = this
  selectedQuestion = $stateParams.question
  vm.questions = FaqService.getQuestions()

  vm.question = Helpers.filterQuestion(vm.questions, selectedQuestion)

  return vm

angular.module('lime-topcoder').controller 'swiftoberfestFaq', [
  '$scope'
  '$stateParams'
  'FaqService'
  'Helpers'
  swiftoberfestFaq
]
