//
//  NetworkUtils.swift
//  KurioSDK
//
//  Created by Hendy Christianto on 11/25/16.
//  Copyright © 2016 PT. Kurio. All rights reserved.
//

import Foundation
import AFNetworking
import CoreTelephony

enum NetworkType: String {
    case AccessWifi = "Wifi"
    case AccessEdge = "Edge"
    case AccessGPRS = "GPRS"
    case AccessLTE = "LTE"
    case Access3G = "3G"
    case AccessHSPA = "HSPA"
    case AccessOthers = "Others"
}

class NetworkUtils {
    fileprivate init() { }
    
    static func getNetworkType() -> NetworkType {
        let reachability = AFNetworkReachabilityManager.shared()
        
        reachability.startMonitoring()
        
        if reachability.networkReachabilityStatus == .reachableViaWiFi {
            return .AccessWifi
        }
        
        reachability.stopMonitoring()
        
        let telephonyInfo = CTTelephonyNetworkInfo()
        guard let currentSignal = telephonyInfo.currentRadioAccessTechnology else {
            return .AccessOthers
        }
        
        if currentSignal == CTRadioAccessTechnologyEdge {
            return .AccessEdge
        } else if currentSignal == CTRadioAccessTechnologyGPRS {
            return .AccessGPRS
        } else if currentSignal == CTRadioAccessTechnologyLTE {
            return .AccessLTE
        } else if currentSignal == CTRadioAccessTechnologyWCDMA {
            return .Access3G
        } else if currentSignal == CTRadioAccessTechnologyHSDPA ||
            currentSignal == CTRadioAccessTechnologyHSUPA {
            return .AccessHSPA
        }
        
        return .AccessOthers
    }
}
