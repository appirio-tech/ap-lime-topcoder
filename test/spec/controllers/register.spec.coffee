'use strict';

describe 'Controller: register', () ->
  # Since CoffeeScript always uses the var keyword, we need to
  # attach global variables to the window so we can access them from
  # inside functions
  window.$controller
  window.$httpBackend
  window.$q
  window.$rootScope
  window.ChallengeService
  window.ApiService
  window.Auth

  beforeEach(module 'lime-topcoder')


  beforeEach inject (_$controller_,  _$httpBackend_, ChallengeService, ApiService, ENV, $q, $rootScope, Auth) ->
    window.$controller = _$controller_
    window.$httpBackend =  _$httpBackend_;
    window.$q = $q
    window.$rootScope = $rootScope
    window.ApiService = ApiService
    window.Auth = Auth

    sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
      deferred = $q.defer()
      if (url.indexOf('/users') != -1)
        response = 
          status: 200
          data:
              content: ''
        deferred.resolve(response)
      deferred.promise
    )

    sinon.stub(Auth, 'isAuthenticated', () ->
      false
    )

    sinon.stub(Auth, 'login', (username, password, successCallback, errorCallback) ->
      successCallback {uid: 1234567890, name: 'ut'}
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.whenGET('register/register.html').respond(200, "")
    $httpBackend.flush()

  describe 'default values of variables', ->
    register = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope}
      $mainScope.main = main
      $scope = $mainScope.$new()
      register = $controller 'register', {$scope: $scope}
      $scope.$digest()

    it 'domain should be topcoder-dev.com by default', ->
      # default value for domain
      expect(register.domain).to.be.equal 'topcoder-dev.com'

    it 'frm should have default values', ->
      # default value for frm
      expect(register.frm).to.not.be.null
      expect(register.frm.error).to.be.equal false
      expect(register.frm.errorMessage).to.be.empty
      expect(register.frm.countries).to.not.be.null
      expect(register.frm.countries.length).to.be.equal 243

    it 'reg should be empty by default', ->
      # default value for reg
      expect(register.reg).to.be.empty

  describe 'doRegister for success', ->
    register = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      register = $controller 'register', {$scope: $scope}
      $scope.$digest()

    it 'should register the user for topcoder', ->
      register.doRegister()
      $rootScope.$digest()
      # loading flag should be off
      expect(register.registering).to.be.equal false
      expect(register.frm).to.not.be.null
      expect(register.frm.error).to.be.equal false
      expect(register.frm.errorMessage).to.be.empty
      expect(register.reg).to.not.be.empty
      expect(register.reg.regSource).to.be.equal 'apple'
      expect(Auth.login.callCount).to.be.equal 1

  describe 'doRegister for failure', ->
    register = null
    main = null
    beforeEach () ->
      ApiService.requestHandler.restore()
      sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
        deferred = $q.defer()
        if (url.indexOf('/users') != -1)
          response = 
            status: 500
            data:
                error: 'Username already taken'
          deferred.resolve(response)
        deferred.promise
      )
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      register = $controller 'register', {$scope: $scope}
      $scope.$digest()

    it 'should register the user for topcoder', ->
      register.doRegister()
      $rootScope.$digest()
      # loading flag should be off
      expect(register.registering).to.be.equal false
      expect(register.frm).to.not.be.null
      expect(register.frm.error).to.be.equal true
      expect(register.frm.errorMessage).not.to.be.empty
      expect(register.reg).to.not.be.empty
      expect(register.reg.regSource).to.be.equal 'apple'
      expect(Auth.login.callCount).to.be.equal 0

  describe 'doRegister for success but failed login', ->
    register = null
    main = null
    beforeEach () ->
      Auth.login.restore()
      sinon.stub(Auth, 'login', (username, password, successCallback, errorCallback) ->
        errorCallback 'Account not activated'
      )
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope}
      main.loggedInUser = {uid: 1234567}
      $mainScope.main = main
      $scope = $mainScope.$new()
      register = $controller 'register', {$scope: $scope}
      $scope.$digest()

    it 'should register the user for topcoder', ->
      register.doRegister()
      $rootScope.$digest()
      # loading flag should be off
      expect(register.registering).to.be.equal false
      expect(register.frm).to.not.be.null
      expect(register.frm.error).to.be.equal true
      expect(register.frm.errorMessage).not.to.be.empty
      expect(register.reg).to.not.be.empty
      expect(register.reg.regSource).to.be.equal 'apple'
      expect(Auth.login.callCount).to.be.equal 1
