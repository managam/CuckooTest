//
//  NotificationService.swift
//  KurioSDK
//
//  Created by Managam Silalahi on 8/3/17.
//  Copyright © 2017 PT. Kurio. All rights reserved.
//

import Foundation

private enum Constants {
    static let BASE_SERVICE = "notifications"
    static let DEFAULT_NUM = 20
}

public class NotificationService: ParentService {
    
    deinit {
        debugPrint("Notification Service dealloc..")
    }
    
    public func getNotificationList(_ num: Int = Constants.DEFAULT_NUM,
                                    onComplete: KRSDKComplete?,
                                    onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        
        params = [String: Any]()
        
        baseURL = Constants.BASE_SERVICE
        
        if num == 0 {
            params!["num"] = NSNumber(value: Constants.DEFAULT_NUM)
        } else {
            params!["num"] = NSNumber(value: num)
        }
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [[String: Any]] {
                onComplete?(["data": result])
            }
        }?.resume()
    }
}
