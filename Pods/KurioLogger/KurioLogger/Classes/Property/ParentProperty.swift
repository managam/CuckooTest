//
//  ParentProperty.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/15/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

@objc public class ParentProperty: NSObject {
    private(set) var dictionary: [String: Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        super.init()
    }
    
    func updateDictionary(value: Any, forKey key: String) {
        dictionary.updateValue(value, forKey: key)
    }
}
