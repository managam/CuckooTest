//
//  ReadManager.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 4/12/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation


public final class ReadManager {
    public let articleId: String
    public let position: Int
    public let placement: String
    public let placementName: String
    public let publisher: String
    public let articleLength: Int
    
    private(set) public var scrollLength: Int = 0
    private(set) public var timer: TrackerTimer
    
    public init(articleId: String, position: Int, placement: String, placementName: String,
         publisher: String, articleLength: Int) {
        self.articleId = articleId
        self.position = position
        self.placement = placement
        self.placementName = placementName
        self.publisher = publisher
        self.articleLength = articleLength
        
        self.timer = TrackerTimer()
    }
    
    public func setScrollLength(_ scrollLength: Int) {
        if self.scrollLength > scrollLength {
            return
        }
        
        self.scrollLength = scrollLength
    }
    
    public func pauseTracker() {
        timer.pause()
    }
    
    public func resumeTracker() {
        timer.resume()
    }
    
    public func sendArticleReadLog() {
        let property = PropertyRead(withArticleId: articleId,
                                    placement: placement,
                                    placementName: placementName,
                                    position: position,
                                    articleLength: articleLength,
                                    scrollLength: scrollLength,
                                    sessionLength: timer.getDuration(),
                                    publisher: publisher)
        
        KurioTracker.trackArticleReadSession(withProperty: property)
    }
}
