//
//  Config.swift
//  KurioSDK
//
//  Created by Hendy Christianto on 11/25/16.
//  Copyright © 2016 PT. Kurio. All rights reserved.
//

import Foundation


public class Config {
    
    let production: Bool
    let logApi: Bool
    let serverUrl: String
    
    init(production: Bool, logApi: Bool) {
        self.production = production
        self.logApi = logApi
        
        if production {
            serverUrl = "https://api.kurioapps.com/v1/"
        } else {
            serverUrl = "http://staging-api.sg.kurioapps.com/v1/"
        }
    }
}
