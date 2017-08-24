//
//  ScreenName.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/21/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public enum ScreenNameType {
    case StartApplication
    case LeaveApplication
    case Welcome
    case ArticleList(streamFormat: String)
    case VideoList(streamFormat: String)
    case ArticleDetail(articleId: String)
    case PlacementArticleDetail(articleId: String)
    case PlacementNameArticleDetail
    case PlacementNameRelatedArticle
    case PlacementNameRelatedArticleSameTopic
    case PlacementNameRelatedArticleSameSource
    case VideoDetail(videoId: String)
    case PlacementVideoDetail(videoId: String)
    case PlacementNameVideoDetail
    case PlacementNameVideoSameSource
    case PushNotif
    case PlacementNamePushNotif
    case Deeplinking
    case PlacementNameDeeplinking
    case TopicList
    case SubtopicList(topicGroupId: String)
    case FeaturedTopics(context: String)
    case Settings
    case PromoCode
    case Search
    case SearchKeyword(keyword: String)
    case PlacementNameSearch(keyword: String)
    case SignIn
    case SignUp
    case ForgotPassword
    case ChangePassword
    case MyKurio
    case DontMissIt
    case PlacementNameDontMissIt
    case ChooseLocation
    case TabArticle(streamFormat: String)
    case TabVideo(streamFormat: String)
    case FavoriteList
    case None
}

public final class ScreenName {
    fileprivate init() { }
    
    public static func getScreenNameValue(_ screen: ScreenNameType) -> String {
        switch screen {
        case .StartApplication:
            return "open_application"
        case .LeaveApplication:
            return ""
        case .Welcome:
            return "welcome"
        case .ArticleList(streamFormat: let streamFormat):
            return "article_list/" + streamFormat
        case .VideoList(streamFormat: let streamFormat):
            return "video_list/" + streamFormat
        case .ArticleDetail(articleId: let articleId):
            return "article_detail/" + articleId
        case .PlacementNameRelatedArticle:
            return "Related From Related Article"
        case .PlacementNameArticleDetail:
            return "article_detail"
        case .PlacementNameRelatedArticleSameTopic:
            return "Related From Same Topic"
        case .PlacementNameRelatedArticleSameSource:
            return "Related From Same Source"
        case .PlacementArticleDetail(articleId: let articleId):
            return "article_detail:" + articleId
        case .VideoDetail(videoId: let id):
            return "video_detail/" + id
        case .PlacementVideoDetail(videoId: let id):
            return "video_detail:" + id
        case .PlacementNameVideoDetail:
            return "video_detail"
        case .PlacementNameVideoSameSource:
            return "Related From Same Section"
        case .PushNotif:
            return "notification"
        case .PlacementNamePushNotif:
            return "Notification"
        case .Deeplinking:
            return "deeplinking"
        case .PlacementNameDeeplinking:
            return "Deeplinking"
        case .TopicList:
            return "topics"
        case .SubtopicList(topicGroupId: let topicGroupId):
            return "subtopics/" + topicGroupId
        case .FeaturedTopics(context: let context):
            return context + "/recommended topics"
        case .Settings:
            return "setting"
        case .PromoCode:
            return "promo_code"
        case .Search:
            return "search"
        case .SearchKeyword(keyword: let keyword):
            return "search:" + keyword
        case .PlacementNameSearch(keyword: let keyword):
            return "Search " + keyword
        case .SignIn:
            return "sign in"
        case .SignUp:
            return "sign up"
        case .ForgotPassword:
            return "forgot_password"
        case .ChangePassword:
            return "change_password"
        case .MyKurio:
            return "edit_sources"
        case .DontMissIt:
            return "notification_list"
        case .PlacementNameDontMissIt:
            return "Notification List"
        case .FavoriteList:
            return "favorite_list"
        case .ChooseLocation:
            return "choose_location"
        case .TabArticle(streamFormat: let streamFormat):
            return streamFormat
        case .TabVideo(streamFormat: let streamFormat):
            return streamFormat
        case .None:
            return ""
        }
    }
}
