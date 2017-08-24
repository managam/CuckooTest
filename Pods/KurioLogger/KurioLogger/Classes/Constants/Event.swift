//
//  Event.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/21/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

enum Event: Int {
    case Leave = 5
    case TapOriginalView = 6
    case TapURL = 7
    case Share = 9
    case ChangeFontSize = 10
    case Favorite = 11
    case Unfavorite = 12
    case TapImage = 15
    case FollowTopic = 20
    case UnfollowTopic = 21
    case TogglePushNotif = 36
    case ToggleNightMode = 37
    case ToggleShowImage = 38
    case ToggleParallax = 39
    case SubmitPromoCode = 41
    case InvalidatePromoCode = 42
    case InviteFriends = 43
    case SendFeedback = 44
    case RateKurio = 45
    case Logout = 46
    case Login = 48
    case TapGetStarted = 54
    case TapAutoDetect = 61
    case TapManualLocation = 62
    case SelectManualLocation = 63
    case ImpressionArticle = 100
    case ArticleReadSession = 102
    case TappedArticleMoreFromRelatedArticle = 106
    case TappedArticleMoreFromTopics = 107
    case ImpressionVideo = 109
    case VideoClick = 110
    case VideoStart = 111
    case VideoStop = 112
    case TappedArticleMoreFromSameSource = 114
    case TappedVideoMoreFromSameSection = 117
}
