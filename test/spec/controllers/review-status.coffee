'use strict';

describe 'Controller: reviewStatus', () ->
  # Since CoffeeScript always uses the var keyword, we need to
  # attach global variables to the window so we can access them from
  # inside functions
  window.$controller

  beforeEach(module 'peerReview')


  beforeEach inject (_$controller_) ->
    window.$controller = _$controller_

  describe '$scope.reviewScorecards', ->
    it 'should be initialized to an empty array', ->
      $scope = {}
      controller = $controller 'reviewStatus', {$scope: $scope}
      expect($scope.reviewScorecards).to.be.empty
