//
//  PropertyVideoClick.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 4/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public class PropertyVideoClick: ParentProperty {
    private(set) public var videoId = ""
    private(set) public var placement = ""
    private(set) public var placementName = ""
    private(set) public var position = 0
    
    public init(videoId: String,
                placement: String,
                placementName: String,
                position: Int) {
        
        self.videoId = videoId
        self.placement = placement
        self.placementName = placementName
        self.position = position
        
        let dictionary: [String: Any] = [
            "video_id": videoId,
            "placement": placement,
            "placement_name": placementName,
            "position": position
        ]
        
        super.init(dictionary: dictionary)
    }
}
