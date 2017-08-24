//
//  TrackerFilter.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/14/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import KurioPuree

open class TrackerFilter: Filter {
    required public init(logger: Logger, tagPattern: String?) {
        super.init(logger: logger, tagPattern: tagPattern)
    }
    
    override open func configure(_ settings: [String: Any]) {
        super.configure(settings)
    }
}
