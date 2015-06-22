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
    else if challenge.challengeCommunity == 'design'
      challenge.icon = 'design'
    else
      challenge.icon = 'dev'

angular.module('lime-topcoder').factory 'Helpers', [
  'ENV'
  Helpers
]
