//
//  LocationService.swift
//  Pods
//
//  Created by Managam Silalahi on 8/3/17.
//
//

import Foundation
import AFNetworking

private struct Constants {
    static let BASE_SERVICE = "location"
}

public class LocationService: ParentService {
    
    deinit {
        debugPrint("Location Service dealloc..");
    }
    
    public func getLocations(_ onComplete: KRSDKComplete?,
                             onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        baseURL = Constants.BASE_SERVICE
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            var result = [String: Any]()
            result["data"] = responseObject
            
            onComplete?(result)
        }
        
        task!.resume()
        
        return task
    }
}
