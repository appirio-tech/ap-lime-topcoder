'use strict'

swiftoberfestInfo = ($scope, $stateParams, FaqService) ->
  vm = this
  vm.shown = []
  vm.questions = FaqService.getQuestions()

  vm.toggleDisplay = (slug) ->
    console.log(slug)
    for q in vm.questions
      if (q.slug == slug)

        if (vm.shown.indexOf(slug) == -1)

          vm.shown.push(slug)

        else

          vm.shown.splice(vm.shown.indexOf(slug), 1)

  vm.isNotVisible = (slug) ->
    vm.shown.indexOf(slug) == -1

  return vm

angular.module('lime-topcoder').controller 'swiftoberfestInfo', [
  '$scope'
  '$stateParams'
  'FaqService'
  swiftoberfestInfo
]
