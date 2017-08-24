//
//  PropertyArticleImpression.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/15/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public final class PropertyArticleImpression: ParentProperty {
    private(set) public var articleId = ""
    private(set) public var placement = ""
    private(set) public var placementName = ""
    private(set) public var position = 0
    
    public init(articleId: String, placement: String, placementName: String, position: Int) {
        
        self.articleId = articleId
        self.placement = placement
        self.placementName = placementName
        self.position = position
        
        let dictionary: [String: Any] = [
            "article_id": articleId,
            "placement": placement,
            "placement_name": placementName,
            "position": position
        ]
        
        super.init(dictionary: dictionary)
    }
}
