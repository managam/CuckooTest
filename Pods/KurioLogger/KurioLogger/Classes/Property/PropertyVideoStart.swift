//
//  PropertyVideoStart.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 8/10/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation


public final class PropertyVideoStart: ParentProperty {
    private(set) public var videoId = ""
    private(set) public var placement = ""
    private(set) public var placementName = ""
    private(set) public var position = 0
    private(set) public var videoTimeLength: TimeInterval = 0
    private(set) public var startSecond: TimeInterval = 0
    private(set) public var transitionType: PlaybackType = .notSet
    private(set) public var publisher = ""
    
    
    public init(videoId: String,
                placement: String,
                placementName: String,
                position: Int,
                videoTimeLength: TimeInterval,
                startSecond: TimeInterval,
                transitionType: PlaybackType,
                publisher: String) {
        
        self.videoId = videoId
        self.placement = placement
        self.placementName = placementName
        self.position = position
        self.videoTimeLength = videoTimeLength
        self.startSecond = startSecond
        self.transitionType = transitionType
        self.publisher = publisher
        
        let dictionary: [String: Any] = [
            "video_id": videoId,
            "placement": placement,
            "placement_name": placementName,
            "position": position,
            "video_time_length": videoTimeLength,
            "start_second": startSecond,
            "transition_type": transitionType.rawValue,
            "publisher": publisher
        ]
        
        super.init(dictionary: dictionary)
    }
}
