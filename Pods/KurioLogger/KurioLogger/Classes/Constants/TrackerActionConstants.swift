//
//  TrackerActionConstants.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/21/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

enum TrackerActionConstants: Int {
    case StartApplication = 1
    case LeaveApplication // 2
    case ViewWelcome // 3
    case ReadArticle // 4
    case LeaveArticle // 5
    case TappedArticleOriginalView // 6
    case TappedArticleURL // 7
    case TappedMoreArticles // 8
    case ShareArticle // 9
    case ChangeFontSize // 10
    case FavoriteArticle // 11
    case UnfavoriteArticle // 12
    case SwipeNextArticleDetail // 13
    case SwipeBackArticleDetail // 14
    case TappedArticleImage // 15
    case TappedArticleVideo // 16
    case ViewSearch // 17
    case ViewSearchArticle // 18
    case ViewSearchTopics // 19
    case FollowTopic // 20
    case UnfollowTopic // 21
    case ViewCircularAxis // 22
    case ViewFollowedArticleList // 23
    case ViewUnFollowedArticleList // 24
    case ViewRelatedTopics // 25
    case ViewEditSources // 26
    case MuteSource // 27
    case ViewTrendingList // 28
    case ViewTrendingDetail // 29
    case ReadTwitterArticle // 30
    case ViewTopics // 31
    case OpenSubtopics // 32
    case ViewMyKurio // 33
    case ViewEditMyKurio // 34
    case ViewSettings // 35
    case TogglingPushNotification // 36
    case TogglingNightMode // 37
    case TogglingShowImage // 38
    case TogglingParallaxEffect // 39
    case ViewPromoCode // 40
    case SubmitPromoCode // 41
    case InvalidatePromoCode // 42
    case InviteFriends // 43
    case SendFeedback // 44
    case RateKurioApplication // 45
    case LogoutAccount // 46
    case ViewSignIn // 47
    case LoginAccount // 48
    case ViewSignUp // 49
    case ViewForgotPassword // 50
    case ViewChangePassword // 51
    case TappedOnBoarding // 52
    case DismissOnBoarding // 53
    case TappedGetStarted // 54
    case ViewFavorites = 56 // 56
    case ViewDontMissIt // 57
    case ArticleImpression = 100 // 100
    case ArticleReadSession = 102 // 102
    case ChangeTab = 105 // 105
    case TapRelatedArticle // 106
    case TapRelatedTopics // 107
    case TapRelatedSameSource = 114 // 114
}
