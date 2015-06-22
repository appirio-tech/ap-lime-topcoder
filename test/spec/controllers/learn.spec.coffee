'use strict';

describe 'Controller: learn', () ->
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
      if (url.indexOf('/memberCert/registrations') != -1)
        response = 
          status: 200
          data:
            result:
              content:
                userId: 123456789
                programId: 3445
        deferred.resolve(response)
      deferred.promise
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.whenGET('learn/learn.html').respond(200, "")
    $httpBackend.flush()

  describe 'default values of variables', ->
    learn = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'registered should be false by default', ->
      # default value for domain
      expect(learn.registered).to.be.equal false

    it 'registrationSuccess should be false by default', ->
      # default value for registrationSuccess
      expect(learn.registrationSuccess).to.be.equal false

    it 'registrationError should be null by default', ->
      # default value for registrationError
      expect(learn.registrationError).to.be.null

  describe 'for logged in user who is registered for the program', ->
    learn = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'loading flag should in false state', ->
      # default value for domain
      expect(main.loading).to.be.equal false

    it 'registered should be true', ->
      expect(learn.registered).to.be.equal true

    it 'registrationSuccess should false', ->
      # registrationSuccess should be false because it is true only when user has made successful registration request
      expect(learn.registrationSuccess).to.be.equal false

    it 'registrationError should be null by default', ->
      expect(learn.registrationError).to.be.null

  describe 'for logged in user who is not registered for the program', ->
    learn = null
    main = null
    beforeEach () ->
      ApiService.requestHandler.restore()
      sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
        deferred = $q.defer()
        if (url.indexOf('/memberCert/registrations') != -1)
          response = 
            status: 200
            data:
              result: {}
          deferred.resolve(response)
        deferred.promise
      )
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'loading flag should in false state', ->
      # default value for domain
      expect(main.loading).to.be.equal false

    it 'registered should be false', ->
      expect(learn.registered).to.be.equal false

    it 'registrationSuccess should false', ->
      # registrationSuccess should be false because it is true only when user has made successful registration request
      expect(learn.registrationSuccess).to.be.equal false

    it 'registrationError should be null by default', ->
      expect(learn.registrationError).to.be.null

  describe 'registerForProgram for success', ->
    learn = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'should register the user for the program', ->
      learn.registerForProgram()
      $rootScope.$digest()
      # loading flag should be off
      expect(main.loading).to.be.equal false
      expect(learn.registered).to.be.equal true
      # registrationSuccess should be true because user has made successful registration request
      expect(learn.registrationSuccess).to.be.equal true
      expect(learn.registrationError).to.be.null

  describe 'registerForProgram for failure', ->
    learn = null
    main = null
    beforeEach () ->
      ApiService.requestHandler.restore()
      sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
        deferred = $q.defer()
        if (url.indexOf('/memberCert/registrations') != -1)
          response = 
            status: 500
            data:
              result: {}
          deferred.resolve(response)
        deferred.promise
      )
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'should gracefully fail to register', ->
      learn.registerForProgram()
      $rootScope.$digest()
      # loading flag should be off
      expect(main.loading).to.be.equal false
      expect(learn.registered).to.be.equal false
      # registrationSuccess should be true because user has made failed registration request
      expect(learn.registrationSuccess).to.be.equal false
      expect(learn.registrationError).to.not.be.null

  describe 'registerForProgram for failure (exception)', ->
    learn = null
    main = null
    beforeEach () ->
      ApiService.requestHandler.restore()
      sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
        deferred = $q.defer()
        if (url.indexOf('/memberCert/registrations') != -1)
          response = 
            status: 500
            data:
              result: {}
          deferred.reject(response)
        deferred.promise
      )
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      learn = $controller 'learn', {$scope: $scope, $state: ''}
      $scope.$digest()

    it 'should gracefully fail to register', ->
      learn.registerForProgram()
      $rootScope.$digest()
      # loading flag should be off
      expect(main.loading).to.be.equal false
      expect(learn.registered).to.be.equal false
      # registrationSuccess should be true because user has made failed registration request
      expect(learn.registrationSuccess).to.be.equal false
      expect(learn.registrationError).to.not.be.null
