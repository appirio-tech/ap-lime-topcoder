'use strict'

FaqService = () ->
  questions = [{
      slug: 'do-i-need-to-sign-up-before-swiftoberfest-begins',
      title: 'Do I need to sign up before Swiftoberfest begins?',
      answer: 'Nope. New members are welcome to join anytime during Swiftoberfest, and you can participate in as few or as many challenges as you’d like. However, the sooner you complete the <a href="/challenges/type/peer">Show Your Skills</a> challenge - and the more real-world challenges you compete in - the more chances you’ll have to win some of our great Swiftoberfest prizes!',
      overflowedAnswer: 'Nope. New members are welcome to join anytime during Swiftoberfest, and you can participate in as few or as many challenges as you’d like. However, the sooner you complete the...'
    },
    {
      slug: 'am-i-required-to-earn-badges-to-participate-in-ios-challenges',
      title: 'Am I required to earn badges to participate in iOS challenges?',
      answer: 'No, you only need to be a topcoder member to participate in any of the iOS challenges. However, members who complete the <a href="/challenges/type/peer">Show Your Skills</a> challenge and earn the Swift/iOS Ready! badge can win great educational prizes via weekly drawings.',
      overflowedAnswer: 'No, you only need to be a topcoder member to participate in any of the iOS challenges. However, members who complete the...'
    },
    {
      slug: 'how-do-swiftoberfest-challenges-differ-from-other-ios-challenges',
      title: 'How do Swiftoberfest challenges differ from other iOS challenges?',
      answer: 'During Swiftoberfest we’re working with 10 select customers to design, prototype, and build Swift/iOS apps by the end of 2015. You can earn leaderboard points by participating in challenges specific to these customers, and if you’re a top finisher on the leaderboard you can win great prizes like an Apple TV or MacBook Pro. Show Your Skills challenges as well as iOS challenges not related to Swiftoberfest are not eligible for leaderboard points. All Swiftoberfest challenges include #swiftoberfest in the name to help you differentiate them from all other iOS challenges.',
      overflowedAnswer: 'During Swiftoberfest we’re working with 10 select customers to design, prototype, and build Swift/iOS apps by the end of 2015. You can earn leaderboard points by participating in challenges specific...'
    },
    {
      slug: 'i-am-new-to-topcoder-what-is-it-all-about',
      title: 'I’m new to topcoder. What’s it all about?',
      answer: 'Topcoder gathers the world’s experts in design, development and data science to work on interesting and challenging problems. Members are provided with opportunities to demonstrate their expertise, improve their skills, and win cash, while helping real world organizations solve real world problems. For more information, check out the <a href="https://www.topcoder.com/community/how-it-works/">How it Works</a> page on topcoder.',
      overflowedAnswer: 'Topcoder gathers the world’s experts in design, development and data science to work on interesting and challenging problems. Members are provided with opportunities to demonstrate their expertise...'
    },
    {
      slug: 'if-i-signup-at-ios-topcoder-com-will-i-be-a-full-topcoder-member',
      title: 'If I signup at ios.topcoder.com will I be a full topcoder member?',
      answer: 'Yes! By registering here, you’ll automatically be a member of the 850,000+ topcoder community and can participate in any other design, development, or data science challenges that interest you. But you’ll also be a member of topcoder’s exclusive iOS Community and eligible to earn badges and compete for Swiftoberfest prizes.',
      overflowedAnswer: 'Yes! By registering here, you’ll automatically be a member of the 850,000+ topcoder community and can participate in any other design, development, or data science challenges ...'
    },
    {
      slug: 'i-am-already-a-topcoder-member-am-i-eligible-to-participate-in-swiftoberfest-and-the-ios-developer-community',
      title: 'I’m already a topcoder member. Am I eligible to participate in Swiftoberfest and the iOS Community?',
      answer: 'Absolutely! Simply login to ios.topcoder.com with your topcoder account and click the Start Competing button to earn your iOS Community Participant badge. Visit the Badges page to track your progress across all available badges. Note that you must earn the Participant badge to be eligible to win any Swiftoberfest prizes.',
      overflowedAnswer: 'Absolutely! Simply login to ios.topcoder.com with your topcoder account and click the Start Competing button to earn your iOS Community Participant badge. Visit the Badges page...'
    },
    {
      slug: 'how-do-the-prize-drawings-work',
      title: 'How do the prize drawings work?',
      answer: 'Swiftoberfest 2015 t-shirt <br> The first 200 members to complete the Show Your Skills challenge and earn the Swift/iOS Ready! badge automatically win a Swiftoberfest 2015 t-shirt. Winners will be contacted via email to get a delivery address. Please note that delivery can take up to 60 days depending on your location.<br><br>______ [education prize] <br> Starting on October 9, we’re raffling off a ______ amongst all members who have earned the Swift/iOS Ready! badge. We’ll continue to raffle off an additional _____ every week until all Swiftoberfest challenges are complete, and unless you win an earlier drawing you will be eligible for every subsequent drawing. That means that the sooner you earn your badge, the more chances you have to win!<br><br>Apple TV <br> We’re giving away five new-model Apple TVs to the top five ios.topcoder.com members on the Swiftoberfest leaderboard as of 5:00 Eastern time on Friday, October 30. In order to earn Swiftoberfest leaderboard points you must finish in the top 10 places for at least one Swiftoberfest real-world challenge. See the Leaderboard section above for additional details on leaderboard points. Eligible topcoder members can win only one Apple TV in the October drawing. Members located in countries where prize cannot be delivered will be offered cash value of the prize.<br><br>MacBook Pro [need details on processor, memory, etc.] <br> We’re giving away one MacBook Pro to the top ios.topcoder.com member on the Swiftoberfest leaderboard when the final Swiftoberfest challenge has been completed. In order to earn Swiftoberfest leaderboard points you must finish in the top 10 places for at least one Swiftoberfest real-world challenge. See the Leaderboard section above for additional details on leaderboard points. Members located in countries where prize cannot be delivered will be offered cash value of the prize.',
      overflowedAnswer: 'Swiftoberfest 2015 t-shirt: The first 200 members who earn the Swift/iOS Ready! badge automatically win a Swiftoberfest 2015 t-shirt. Winners will be contacted via email to get a delivery address and ...'
    }
  ]

  getQuestions: () ->
    return questions

angular.module('lime-topcoder').factory 'FaqService', [
  FaqService
]
