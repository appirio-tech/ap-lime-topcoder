'use strict'

Auth = (ENV, $window, AuthToken, $state, $stateParams, $location, $timeout, ApiService) ->
  auth0 = new Auth0
    domain: ENV.auth0Domain
    clientID: ENV.clientId
    callbackURL: ENV.auth0Callback

  login: (username, password, successCallback, errorCallback) ->
    auth0.signin
      connection: 'LDAP',
      scope: 'openid profile',
      username: username,
      password: password,
    , (err, profile, id_token, access_token, state) ->
      if (err)
        console.log 'err', err
        errorCallback err
      else
        AuthToken.setToken id_token
        successCallback profile, id_token, access_token, state

  logout: () ->
    AuthToken.removeToken()
    $state.transitionTo $state.current, $stateParams,
      reload: true
      inherit: false
      notify: true

  register: (reg) ->
    # api params
    # required: ["firstName", "lastName", "handle", "country", "email"],
    # optional: ["password", "socialProviderId", "socialUserName", "socialEmail", "socialEmailVerified", "regSource", "socialUserId", "utm_source", "utm_medium", "utm_campaign"]
    url = ENV.API_URL + '/users/'

    body =
      options:
        afterActivationURL: 'https://ios.' + ENV.domain
      param:
        handle: reg.handle
        firstName: reg.firstName
        lastName: reg.lastName
        country:
          isoAlpha3Code: reg.country.value
        email: reg.email
        age: reg.age
        utmSource: reg.utm_source
        utmMedium: reg.utm_medium
        utmCampaign: reg.utm_campaign
        regSource: reg.regSource
        credential:
          password: reg.password
    ApiService.requestHandler 'POST', url, JSON.stringify body, true

  isAuthenticated: () ->
    !!AuthToken.getToken()

angular.module('lime-topcoder').factory 'Auth', [
  'ENV'
  '$window'
  'AuthToken'
  '$state'
  '$stateParams'
  '$location'
  '$timeout'
  'ApiService'
  Auth
]
