'use strict';

describe 'Controller: landing', () ->
  # Since CoffeeScript always uses the var keyword, we need to
  # attach global variables to the window so we can access them from
  # inside functions
  window.$controller
  window.$httpBackend
  window.$q
  window.$rootScope
  window.ChallengeService
  window.ApiService

  beforeEach(module 'lime-topcoder')


  beforeEach inject (_$controller_,  _$httpBackend_, ChallengeService, ApiService, ENV, $q, $rootScope) ->
    window.$controller = _$controller_
    window.$httpBackend =  _$httpBackend_;
    window.$q = $q
    window.$rootScope = $rootScope
    window.ApiService = ApiService
    #window.ChallengeService = ChallengeService

    sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
      deferred = $q.defer()
      if (params.review == 'PEER')
        deferred.resolve(peerChallenges)
      else
        deferred.resolve(nonPeerChallenges)
      deferred.promise
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.flush()

  describe '$scope.domain', ->
    it 'should be initialized to default dev domain', ->
      $scope = $rootScope.$new()
      landing = $controller 'landing', {$scope: $scope, $state: ''}
      # default value for domain
      expect(landing.domain).to.be.equal 'topcoder-dev.com'

  describe '$scope.challenges', ->
    it 'should be initialized to array of length 2', ->
      $scope = $rootScope.$new()

      landing = $controller 'landing', {$scope: $scope, $state: ''}
      $scope.$digest()
      # default value for challenges
      expect(landing.challenges).to.be.exist
      expect(landing.challenges).to.have.length 2
