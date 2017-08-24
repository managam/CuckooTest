//
//  ImpressionManager.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 4/3/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public final class ImpressionManager {
    private var cache: [ImpressionData]
    
    public init() {
        self.cache = [ImpressionData]()
    }
    
    public func trackImpression(withProperty property: ParentProperty) {
        
        if property is PropertyArticleImpression == false && property is PropertyVideoImpression == false {
            fatalError("Invalid property type for impression.")
        }
        
        var id: String
        var position = 0
        var event: Event
        var tag: Tag
        
        if let articleProperty = property as? PropertyArticleImpression {
            id = articleProperty.articleId
            position = articleProperty.position
            event = .ImpressionArticle
            tag = .ArticleList
        } else {
            let videoProperty = property as! PropertyVideoImpression
            id = videoProperty.videoId
            position = videoProperty.position
            event = .ImpressionVideo
            tag = .VideoList
        }
        
        if cache
            .contains( where: {$0.id == id
                && $0.position == position} ) {
            return
        }
        
        let pair = ImpressionData(id: id, position: position)
        cache.append(pair)
        
        TrackerManager.shared.log(withEvent: event,
                                 property: property,
                                 origin: TrackerManager.shared.currentScreen,
                                 andTag: tag)
    }
    
    public func clearTrackerCache() {
        cache.removeAll()
    }
}

private class ImpressionData {
    let id: String
    let position: Int
    
    init(id: String, position: Int) {
        self.id = id
        self.position = position
    }
}
