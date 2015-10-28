'use strict'

FaqService = () ->
  questions = [{
      slug: 'do-i-need-to-sign-up-before-swiftoberfest-begins',
      title: 'Do I need to sign up before Swiftoberfest begins?',
      answer: 'Nope. New members are welcome to join anytime during Swiftoberfest, and you can participate in as few or as many challenges as you’d like. However, the sooner you complete the <a href="/challenges/type/peer">Show Your Skills</a> challenge &mdash; and the more real-world challenges you compete in &mdash; the more chances you’ll have to win some of our great Swiftoberfest prizes!',
      overflowedAnswer: 'Nope. New members are welcome to join anytime during Swiftoberfest, and you can participate in as few or as many challenges as you’d like. However, the sooner you complete the...'
    },
    {
      slug: 'am-i-required-to-earn-badges-to-participate-in-ios-challenges',
      title: 'Am I required to earn badges to participate in iOS challenges?',
      answer: 'No, you only need to be a Topcoder member to participate in any of the iOS challenges. However, the first 200 members who earn the Swift/iOS Ready! badge will win an exclusive Swiftoberfest 2015 t-shirt, which was designed by a Topcoder member.',
      overflowedAnswer: 'No, you only need to be a Topcoder member to participate in any of the iOS challenges. However, the first 200 members...'
    },
    {
      slug: 'how-do-swiftoberfest-challenges-differ-from-other-ios-challenges',
      title: 'How do Swiftoberfest challenges differ from other iOS challenges?',
      answer: 'During Swiftoberfest we’re working with 10 select customers to design, prototype, and build Swift/iOS apps by the end of 2015. You can earn leaderboard points by participating in challenges specific to these customers, and if you’re a top finisher on the leaderboard you can win great prizes like an Apple TV or MacBook Pro. Show Your Skills challenges as well as iOS challenges not related to Swiftoberfest are not eligible for leaderboard points. All Swiftoberfest challenges include Swiftoberfest in the title to help you differentiate them from all other iOS challenges.',
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
      title: 'If I signup at ios.topcoder.com will I be a full Topcoder member?',
      answer: 'Yes! By registering here, you’ll automatically be a member of the 850,000+ Topcoder community and can participate in any other design, development, or data science challenges that interest you. But you’ll also be a member of topcoder’s exclusive iOS Community and eligible to earn badges and compete for Swiftoberfest prizes.',
      overflowedAnswer: 'Yes! By registering here, you’ll automatically be a member of the 850,000+ Topcoder community and can participate in any other design, development, or data science challenges ...'
    },
    {
      slug: 'i-am-already-a-topcoder-member-am-i-eligible-to-participate-in-swiftoberfest-and-the-ios-developer-community',
      title: 'I’m already a Topcoder member. Am I eligible to participate in Swiftoberfest and the iOS Community?',
      answer: 'Absolutely! Simply login to ios.topcoder.com with your Topcoder account and click the Start Competing button to earn your iOS Community Participant badge. Visit the <a href="/badges">Badges</a> page to track your progress across all available badges. Note that you must earn the Participant badge to be eligible to win any Swiftoberfest prizes.',
      overflowedAnswer: 'Absolutely! Simply login to ios.topcoder.com with your Topcoder account and click the Start Competing button to earn your iOS Community Participant badge. Visit the Badges page...'
    },
    {
      slug: 'how-do-the-prize-drawings-work',
      title: 'How do the prize drawings work?',
      answer: 'Swiftoberfest 2015 t-shirt<br/>The first 200 members who earn the Swift/iOS Ready! badge automatically win a Swiftoberfest 2015 t-shirt. Winners will be contacted via email to get a delivery address and shirt size. Please note that delivery can take up to 60 days depending on your location.<br/><br/>Monthly Swiftoberfest Leaderboard Prizes<br/>Every month throughout Swiftoberfest we’ll have a separate leaderboard that tracks Swiftoberfest points earned by members who compete in challenges that launched that month. The monthly leaderboard will refresh at the beginning of each new month of Swiftoberfest to give you additional chances to earn prizes. Note that final leaderboard standings for any given month cannot be calculated until all challenges launched in that month have been completed.<br/><br/>Once all challenges that launched in October have completed, the top five members on the October leaderboard will win a new Apple TV. Once all challenges that launched in November have completed, the top three members on the November leaderboard will win an Apple Watch. Once all challenges that launched in December have completed, the top three members on the December leaderboard will win an iPad.<br/><br/>In order to earn Swiftoberfest leaderboard points your submission must pass review. See the Leaderboard section above for additional details on leaderboard points. Members located in countries where prize cannot be delivered will be offered cash value of the prize.<br/><br/>Overall Swiftoberfest Leaderboard Prize <br/>In addition to the monthly Swiftoberfest prizes, we’re also giving away one MacBook Pro to the top ios.topcoder.com member on the overall Swiftoberfest leaderboard when the final Swiftoberfest challenge has been completed, or after all Swiftoberfest challenges launched prior to January 1, 2016 have completed, whichever comes first. Swiftoberfest points earned in October, November, and December all count towards the overall leaderboard. See the Leaderboard section above for additional details on leaderboard points. Members located in countries where prize cannot be delivered will be offered cash value of the prize. ',
      overflowedAnswer: 'Swiftoberfest 2015 t-shirt: The first 200 members who earn the Swift/iOS Ready! badge automatically win a Swiftoberfest 2015 t-shirt. Winners will be contacted via email to get a delivery address and ...'
    }
  ]

  getQuestions: () ->
    return questions

angular.module('lime-topcoder').factory 'FaqService', [
  FaqService
]
