'use strict';

describe 'Controller: main', () ->
  # Since CoffeeScript always uses the var keyword, we need to
  # attach global variables to the window so we can access them from
  # inside functions
  window.$controller
  window.$httpBackend
  window.$q
  window.$rootScope
  window.ApiService

  beforeEach(module 'lime-topcoder')


  beforeEach inject (_$controller_,  _$httpBackend_, ApiService, UserService, ENV, $q, $rootScope, Auth) ->
    window.$controller = _$controller_
    window.$httpBackend =  _$httpBackend_;
    window.$q = $q
    window.$rootScope = $rootScope
    window.UserService = UserService
    window.Auth = Auth
    window.ApiService = ApiService

    sinon.stub(Auth, 'isAuthenticated', () ->
      false
    )

    sinon.stub(ApiService, 'requestHandler', (method, url, params) ->
      deferred = $q.defer()
      if (url.indexOf('/user/profile') != -1)
        response = 
          uid: 123456789
          handle: 'tcuser'
          country: 'United States'
          photoLink: '//community.topcoder.com/i/m/vikasrohit.jpeg'
        deferred.resolve(response)
      if (url.indexOf('/user/identity') != -1)
        response = 
          data:
            uid: 123456789
            handle: 'tcuser'
            email: 'tcuser@topcoder.com'
        deferred.resolve(response)
      deferred.promise
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.flush()

  describe 'default values of variables in non logged in view', ->
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: {current: {name: 'ut'}}}
      $mainScope.main = main
      sinon.stub(main, 'updatePhotoLink')
      $mainScope.$digest()

    it 'vm.domain should be initialized to default value', ->
      # default value for domain
      expect(main.domain).to.be.equal 'topcoder-dev.com'

    it 'loggedInUser should be null by default', ->
      # default value for loggedInUser
      expect(main.loggedInUser).to.be.null

    it 'updatePhotoLink should not be called', ->
      expect(main.updatePhotoLink.callCount).to.be.equal 0

    it 'isActive should return true', ->
      active = main.isActive('ut')
      expect(active).to.be.equal true

    it 'isActive should return false', ->
      active = main.isActive('other')
      expect(active).to.be.equal false

  describe 'for logged in user', ->
    main = null
    beforeEach () ->
      Auth.isAuthenticated.restore()
      sinon.stub(Auth, 'isAuthenticated', () ->
        true
      )
      loginHandler = sinon.stub()
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      main.addLoginEventHandler 'ut', loginHandler
      $mainScope.main = main
      sinon.stub(main, 'updatePhotoLink')
      $mainScope.$digest()

    it 'loading flag should in false state', ->
      # default value for domain
      expect(main.loading).to.be.equal false

    it 'loggedInUser should not be null', ->
      # default value for loggedInUser
      expect(main.loggedInUser).not.to.be.null

    it 'updatePhotoLink should be called once', ->
      expect(main.updatePhotoLink.callCount).to.be.equal 1

  describe 'for login event', ->
    main = null
    $mainScope = null
    loginHandler = null
    beforeEach () ->
      loginHandler = sinon.stub()
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      $mainScope.main = main
      sinon.stub(main, 'updatePhotoLink')
      $mainScope.$digest()

    it 'loading flag should in false state', ->
      # default value for domain
      expect(main.loading).to.be.equal false

    it 'loggedInUser should be null', ->
      # default value for loggedInUser
      expect(main.loggedInUser).to.be.null

    it 'updatePhotoLink should not be called', ->
      expect(main.updatePhotoLink.callCount).to.be.equal 0

    it 'should call loginHandler callback once', ->
      Auth.isAuthenticated.restore()
      sinon.stub(Auth, 'isAuthenticated', () ->
        true
      )
      main.addLoginEventHandler 'ut', loginHandler
      # simulates the login event
      main.activate()
      $mainScope.$digest()
      expect(loginHandler.callCount).to.be.equal 1
      expect(main.updatePhotoLink.callCount).to.be.equal 1

    it 'should call UserService.getUsername once', ->
      Auth.isAuthenticated.restore()
      sinon.stub(Auth, 'isAuthenticated', () ->
        true
      )
      sinon.stub(UserService, 'getLoggedInUser', () ->
        deferred = $q.defer()
        deferred.reject('failed')
        deferred.promise
      )
      main.addLoginEventHandler 'ut', loginHandler
      # simulates the login event
      main.activate()
      $mainScope.$digest()
      # it should not call login handler, even if getUsername succeeds after failure of getLoggedInUser
      # because handlers might use more fields than what getUsername provides
      expect(loginHandler.callCount).to.be.equal 0
      # updatePhotoLink call should not be called if getLoggedInUser fails
      expect(main.updatePhotoLink.callCount).to.be.equal 0

      # loggedInUser should have only handle and photo fields set
      expect(main.loggedInUser).not.to.be.null
      expect(main.loggedInUser.handle).to.be.equal 'tcuser'
      # photo should be a hardcoded path to default image
      expect(main.loggedInUser.photo).to.be.equal 'content/images/user.png'
      expect(main.loggedInUser.email).to.be.undefined
      expect(main.loggedInUser.uid).to.be.undefined

    it 'should logout user', ->
      sinon.stub(Auth, 'logout')
      main.logout()

      expect(main.loggedInUser).to.be.null
      expect(Auth.logout.callCount).to.be.equal 1

