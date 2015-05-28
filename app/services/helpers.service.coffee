'use strict'

Helpers = () ->
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
    
    if challenge.reviewType and challenge.reviewType is 'PEER'
      challenge.icon = 'peer'
      challenge.thumb = 'content/images/peer-swift-challenge.png'
    else
      challenge.icon = 'swift'
      challenge.thumb = 'content/images/swift-challenge-1.png'

angular.module('lime-topcoder').factory 'Helpers', [
  Helpers
]
