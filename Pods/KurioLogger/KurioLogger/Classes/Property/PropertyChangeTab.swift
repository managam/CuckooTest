//
//  PropertyChangeTab.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/15/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public final class PropertyChangeTab: ParentProperty {
    private(set) public var fromStreamFormat = ""
    private(set) public var toStreamFormat = ""
    
    public init(fromStreamFormat: String,
                fromPosition: Int,
                toStreamFormat: String,
                toPosition: Int,
                transitionType: TransitionType) {
        
        self.fromStreamFormat = fromStreamFormat
        self.toStreamFormat = toStreamFormat
        
        let dictionary: [String: Any] = [
            "from_topic": fromStreamFormat,
            "to_topic": toStreamFormat,
            "from_position": fromPosition,
            "to_position": toPosition,
            "transition_type": transitionType.rawValue
        ]
        
        super.init(dictionary: dictionary)
    }
}
