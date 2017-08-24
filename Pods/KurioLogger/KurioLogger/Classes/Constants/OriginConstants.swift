//
//  OriginConstants.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/21/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public enum OriginConstants {
    public enum StartApplicationConstants: String {
        case StartApplication = ""
    }
    
    public enum LeaveApplicationConstants {
        case CurrentScreen(screen: String)
    }
    
    public enum ViewWelcomeConstants: String {
        case OpenApplication = "open_application"
    }
    
    public enum ReadArticleConstants {
        public enum ReadArticleStringLiteral: String {
            case ArticleDetail = "article_detail"
            case ArticleList = "article_list"
            case PushNotification = "push_notification"
            case DeepLinking = "deep_linking"
            case Search = "search"
        }
        
        case Topic(articleId: String, topicType: String, topicId: String)
        case ArticleDetail(articleId: String, stringLiteral: ReadArticleStringLiteral)
        case ArticleList(articleId: String, stringLiteral: ReadArticleStringLiteral)
        case PushNotificaiton(articleId: String, stringLiteral: ReadArticleStringLiteral)
        case DeepLinking(articleId: String, stringLiteral: ReadArticleStringLiteral)
        case Search(articleId: String, stringLiteral: ReadArticleStringLiteral)
    }
}
