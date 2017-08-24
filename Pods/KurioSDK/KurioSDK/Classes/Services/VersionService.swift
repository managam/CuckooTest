//
//  VersionService.swift
//  Kurio
//
//  Created by Hendy Christianto on 10/18/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "version"
}

public class VersionService: ParentService {
    deinit {
        debugPrint("Version Service dealloc..")
    }
    
    
    /**
     Checking compatibility and minimum version to server to maintain
     app version.
     
     - parameter onComplete:   handler when the request success.
     - parameter onFailure:    handler when the request failed.
     */
    public func checkVersion(_ onComplete: KRSDKComplete?,
                             onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        baseURL = Constants.BASE_SERVICE
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(responseObject as? [String: Any])
        }!.resume()
    }
}
