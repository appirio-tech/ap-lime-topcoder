'use strict'

Helpers = (ENV) ->
  formatArray: (data) ->
    formatField = (key) ->
      challenge[key] = challenge[key].join ', '

    formatField 'technologies' for challenge in data
    formatField 'platforms' for challenge in data

  processChallenge: (challenge) ->
    if (challenge.challengeCommunity == 'design')
      if (!challenge.technologies)
        challenge.technologies = 'iOS Design'

      if (!challenge.platforms)
        challenge.platforms = 'iOS'

    id = challenge.challengeId
    type = if challenge.challengeCommunity then '/?type=' + challenge.challengeCommunity else ''

    challenge.url = "https://www.#{ ENV.domain }/challenge-details/#{ id }#{ type }"

    if challenge.reviewType && challenge.reviewType == 'PEER'
      challenge.icon = 'peer'
      challenge.thumb = 'content/images/svg/SYS-IOS-Swift-Ready-06.svg'
    else
      challenge.icon = 'swift'
      challenge.thumb = 'content/images/svg/Challenger-Developer-06.svg'

angular.module('lime-topcoder').factory 'Helpers', [
  'ENV'
  Helpers
]
