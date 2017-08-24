//
//  PropertyRead.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/15/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public class PropertyRead: ParentProperty {
    private(set) public var articleId = ""
    private(set) public var placement = ""
    private(set) public var placementName = ""
    private(set) public var position = 0
    private(set) public var articleLength = 0
    private(set) public var scrollLength = 0
    private(set) public var sessionLength = 0
    private(set) public var publisher = ""
    
    public init(withArticleId articleId: String, placement: String, placementName: String,
                position: Int, articleLength: Int,
                scrollLength: Int, sessionLength: Int, publisher: String) {
        
        self.articleId = articleId
        self.placement = placement
        self.placementName = placementName
        self.position = position
        self.articleLength = articleLength
        self.scrollLength = scrollLength
        self.sessionLength = sessionLength
        self.publisher = publisher
        
        let dictionary: [String: Any] =
            ["article_id": articleId,
             "placement": placement,
             "placement_name": placementName,
             "position": position,
             "article_length": articleLength,
             "scroll_length": scrollLength,
             "session_length": sessionLength,
             "publisher": publisher]
        
        super.init(dictionary: dictionary)
    }
}
