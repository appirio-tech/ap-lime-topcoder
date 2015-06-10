'use strict';

describe 'Controller: challenges', () ->
  # Since CoffeeScript always uses the var keyword, we need to
  # attach global variables to the window so we can access them from
  # inside functions
  window.$controller
  window.$httpBackend
  window.$q
  window.$rootScope
  window.ApiService
  window.$state
  window.$stateParams

  beforeEach(module 'lime-topcoder')


  beforeEach inject (_$controller_,  _$httpBackend_, ApiService, ENV, $q, $rootScope, Auth, $state, $stateParams) ->
    window.$controller = _$controller_
    window.$httpBackend =  _$httpBackend_;
    window.$q = $q
    window.$rootScope = $rootScope
    window.ApiService = ApiService
    window.Auth = Auth
    window.$state = $state
    window.$stateParams = $stateParams

    sinon.stub(Auth, 'isAuthenticated', () ->
      false
    )

    sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
      deferred = $q.defer()
      if (params.review == 'PEER')
        deferred.resolve(JSON.parse(JSON.stringify(peerChallenges)))
      else if (params.review == 'COMMUNITY,INTERNAL')
        deferred.resolve(JSON.parse(JSON.stringify(nonPeerChallenges)))
      else
        all = peerChallenges.concat(nonPeerChallenges)
        deferred.resolve(JSON.parse(JSON.stringify(all)))
      deferred.promise
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.whenGET('challenges/challenges.html').respond(200, "")
    $httpBackend.whenGET('learn/learn.html').respond(200, "")
    $httpBackend.flush()

  describe 'default values for variables', ->
    challenges = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      $mainScope.main = main
      $scope = $mainScope.$new()
      $stateParams.type = 'all'
      challenges = $controller 'challenges', {$scope: $scope, Auth: Auth, $stateParams: $stateParams}
      $scope.$digest()

    it 'vm.domain should be initialized to default value', ->
      # default value for domain
      expect(challenges.domain).to.be.equal 'topcoder-dev.com'

    it 'vm.pageIndex should be initialized to default value', ->
      # default value for pageIndex
      expect(challenges.pageIndex).to.be.equal 1
    
    it 'vm.pageSize should be initialized to default value', ->
      # default value for pageSize
      expect(challenges.pageSize).to.be.equal 10

  describe 'challenges initialization for type all', ->
    challenges = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      sinon.stub(main, 'activate', () ->
        console.log 'successfully activated'
      )
      $mainScope.main = main
      $scope = $mainScope.$new()
      $stateParams.type = 'all'
      challenges = $controller 'challenges', {$scope: $scope, Auth: Auth, $stateParams: $stateParams}
      $scope.$digest()

    it 'should redirect to specified state', ->
      expect(challenges.challenges).to.be.exist
      expect(challenges.challenges).to.have.length 1
      expect(challenges.challenges[0].reviewType).to.be.equal 'COMMUNITY'
      # hasMore should be false until paging is supported by the api
      expect(challenges.hasMore).to.be.equal false

  describe 'challenges initialization for type peer', ->
    challenges = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      sinon.stub(main, 'activate', () ->
        console.log 'successfully activated'
      )
      $mainScope.main = main
      $scope = $mainScope.$new()
      $stateParams.type = 'peer'
      challenges = $controller 'challenges', {$scope: $scope, Auth: Auth, $stateParams: $stateParams}
      $scope.$digest()

    it 'should redirect to specified state', ->
      expect(challenges.challenges).to.be.exist
      expect(challenges.challenges).to.have.length 1
      expect(challenges.challenges[0].reviewType).to.be.equal 'PEER'
      # hasMore should be false until paging is supported by the api
      expect(challenges.hasMore).to.be.equal false
