'use strict'

UtmCookieService = ($cookies) ->
  COOKIE_NAME = 'topcoder_utm'
  current_date = new Date()
  COOKIE_EXPIRATION = new Date(current_date.getFullYear(), current_date.getMonth() + 1, current_date.getDate())

  publicFunctions = {}

  setInCookie = (queryParams) ->
    $cookies.putObject(COOKIE_NAME, queryParams, {expires:COOKIE_EXPIRATION})

  publicFunctions.getFromCookie = () ->
    return $cookies.getObject(COOKIE_NAME) || {}

  publicFunctions.setFromUrl = (queryParams) ->
    cookieUtm = {}

    # Get the utm query parameters from the URL
    cookieUtm.utm_campaign = queryParams.utm_campaign
    cookieUtm.utm_medium = queryParams.utm_medium
    cookieUtm.utm_source = queryParams.utm_source

    # Check if we have utm values - if not read from the cookie
    if !cookieUtm.utm_campaign || !cookieUtm.utm_medium || !cookieUtm.utm_source
      cookieValue = publicFunctions.getFromCookie()

      # Give preference to the values retrieved from the URL
      cookieUtm.utm_campaign = cookieUtm.utm_campaign || cookieValue.utm_campaign
      cookieUtm.utm_medium = cookieUtm.utm_medium || cookieValue.utm_medium
      cookieUtm.utm_source = cookieUtm.utm_source || cookieValue.utm_source

      #Store the values back in the cookie in case the URL query params have new values
      setInCookie(cookieUtm)
    else
      setInCookie(cookieUtm)

  publicFunctions

angular.module('lime-topcoder').factory 'UtmCookieService', [
  '$cookies'
  UtmCookieService
]
