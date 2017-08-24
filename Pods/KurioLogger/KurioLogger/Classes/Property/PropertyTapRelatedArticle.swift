//
//  PropertyTapRelatedArticle.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 4/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public enum RelatedArticleType: String {
    case Related = "related"
    case TopStories = "top_stories"
    case Topic = "topic"
    case RelatedSameSource = "related same source"
}

public final class PropertyTapRelatedArticle: ParentProperty {
    private(set) public var articleId = ""
    private(set) public var placement = ""
    private(set) public var placementName = ""
    private(set) public var parentArticleId = ""
    private(set) public var position = 0
    
    public init(articleId: String, placement: String,
                placementName: String, parentArticleId: String,
                position: Int?) {
        
        self.articleId = articleId
        self.placement = placement
        self.placementName = placementName
        self.parentArticleId = parentArticleId
        
        if let position = position {
            self.position = position
        }
        
        let dictionary: [String: Any] = [
            "article_id": self.articleId,
            "placement": self.placement,
            "placement_name": self.placementName,
            "parent_article_id": self.parentArticleId,
            "position": self.position
        ]
        
        super.init(dictionary: dictionary)
    }
}
