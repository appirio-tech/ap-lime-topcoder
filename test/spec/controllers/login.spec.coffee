'use strict';

describe 'Controller: login', () ->
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

    sinon.stub(Auth, 'login', (username, password, successCallback, errorCallback) ->
      if username == 'ut' && password == 'ut'
        successCallback {}
      else
        errorCallback 'Invalid username or password'
    )
    
    $httpBackend.whenGET('landing/landing.html').respond(200, "")
    $httpBackend.whenGET('login/login.html').respond(200, "")
    $httpBackend.whenGET('learn/learn.html').respond(200, "")
    $httpBackend.flush()

  describe 'default values for variables', ->
    login = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      $mainScope.main = main
      $scope = $mainScope.$new()
      login = $controller 'login', {$scope: $scope, Auth: Auth}
      $scope.$digest()

    it 'vm.domain should be initialized to default dev domain', ->
      # default value for domain
      expect(login.domain).to.be.equal 'topcoder-dev.com'

    it 'vm.retState should be initialized to default dev domain', ->
      # default value for retState
      expect(login.retState).to.be.equal 'landing'
    
    it 'vm.loggingIn should be initialized to default dev domain', ->
      # default value for loggingIn
      expect(login.loggingIn).to.be.equal false

  describe 'doLogin method', ->
    login = null
    main = null
    beforeEach () ->
      $mainScope = $rootScope.$new()
      main = $controller 'main', {$scope: $mainScope, $state: ''}
      sinon.stub(main, 'activate', () ->
        console.log 'successfully activated'
      )
      $mainScope.main = main
      $scope = $mainScope.$new()
      login = $controller 'login', {$scope: $scope, Auth: Auth}
      $scope.$digest()

    it 'should show error message for empty username', ->
      login.frm.username.value = ''
      login.frm.password.value = 'ut'
      login.doLogin()
      expect(login.frm.username.error).to.be.equal true
      expect(login.frm.username.errorMessage).to.be.equal 'required'
      expect(login.frm.password.error).to.be.equal false
      expect(Auth.login.callCount).to.equal(0)

    it 'should show error message for empty password', ->
      login.frm.username.value = 'ut'
      login.frm.password.value = ''
      login.doLogin()
      expect(login.frm.username.error).to.be.equal false
      expect(login.frm.password.error).to.be.equal true
      expect(login.frm.password.errorMessage).to.be.equal 'required'
      expect(Auth.login.callCount).to.equal(0)

    it 'should show error message for incorrect username', ->
      login.frm.username.value = 'wrong'
      login.frm.password.value = 'ut'
      login.doLogin()
      expect(login.frm.username.error).to.be.equal false
      expect(login.frm.password.error).to.be.equal false
      expect(Auth.login.callCount).to.equal(1)
      expect(login.frm.error).to.be.equal true
      expect(login.frm.errorMessage).to.be.equal 'Username or password is not correct'

    it 'should show error message for incorrect password', ->
      login.frm.username.value = 'ut'
      login.frm.password.value = 'wrong'
      login.doLogin()
      expect(login.frm.username.error).to.be.equal false
      expect(login.frm.password.error).to.be.equal false
      expect(Auth.login.callCount).to.equal(1)
      expect(login.frm.error).to.be.equal true
      expect(login.frm.errorMessage).to.be.equal 'Username or password is not correct'

    it 'should call success call back and call main.activate for correct credentials', ->
      login.frm.username.value = 'ut'
      login.frm.password.value = 'ut'
      login.doLogin()
      expect(login.frm.username.error).to.be.equal false
      expect(login.frm.password.error).to.be.equal false
      expect(Auth.login.callCount).to.equal(1)
      expect(login.frm.error).to.be.equal false
      expect(login.frm.errorMessage).to.be.empty
      expect(main.activate.callCount).to.equal(1)
      expect($state.current.name).to.be.equal 'landing'

    it 'should redirect to specified state', ->
      login.frm.username.value = 'ut'
      login.frm.password.value = 'ut'
      $stateParams.retState = 'learn'
      login.doLogin()
      expect(login.frm.username.error).to.be.equal false
      expect(login.frm.password.error).to.be.equal false
      expect(Auth.login.callCount).to.equal(1)
      expect(login.frm.error).to.be.equal false
      expect(login.frm.errorMessage).to.be.empty
      expect(main.activate.callCount).to.equal(1)
      expect(login.retState).to.be.equal 'learn'
      # TODO check why $state is not chaning its state
      #expect($state.current.name).to.be.equal 'learn'
