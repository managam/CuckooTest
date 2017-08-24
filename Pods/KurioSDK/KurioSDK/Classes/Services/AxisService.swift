//
//  AxisService.swift
//  Kurio
//
//  Created by Hendy Christianto on 9/15/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "axis"
    static let FORMAT_AXIS_SYNC = BASE_SERVICE + "/me"
    static let FORMAT_FOLLOW_UNFOLLOW = BASE_SERVICE + "/%@/follow"
    static let FORMAT_VIDEO_AXIS = FORMAT_AXIS_SYNC + "?entity=video"
}

public class AxisService: ParentService {
    
    deinit {
        debugPrint("Axis Service dealloc..")
    }
    
    
    /**
     Follow a topic or axis.
     
     - parameter subscriptionStreamFormat:  the category stream format (<type>:<id>), eg: topic:40, source:100, topic:99.
     - parameter onComplete:        handler when the request success.
     - parameter onFailure:         handler when the request failed.
     */
    public func followAxis(_ subscriptionStreamFormat: String,
                           onComplete: KRSDKComplete?,
                           onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "POST"
        baseURL = String(format: Constants.FORMAT_FOLLOW_UNFOLLOW, subscriptionStreamFormat)
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any],
                let data = result["data"] as? [String: Any],
                (data["success"] as? Bool) == true {
                onComplete?(result)
            }
        }
        
        task?.resume()
        
        return task
    }
    
    
    /**
     Unfollow a topic or axis.
     
     - parameter subscriptionStreamFormat:  the category stream format (<type>:<id>), eg: topic:40, source:100, topic:99.
     - parameter onComplete:        handler when the request success.
     - parameter onFailure:         handler when the request failed.
     */
    public func unfollowAxis(_ subscriptionStreamFormat: String, onComplete: KRSDKComplete?,
                             onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "DELETE"
        baseURL = String(format: Constants.FORMAT_FOLLOW_UNFOLLOW, subscriptionStreamFormat)
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any],
                let data = result["data"] as? [String: Any],
                (data["success"] as? Bool) == true {
                onComplete?(result)
            }
        }
        
        task?.resume()
        
        return task
    }
    
    
    /**
     Join logged in user axis or followed topics and sync to server.
     
     - parameter axisArray:  axis array in json format.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func joinAxis(_ axisArray: [[String: Any]], onComplete: KRSDKComplete?,
                         onFailure: KRSDKFailure?) {
        HTTPMethod = "PUT"
        baseURL = Constants.FORMAT_AXIS_SYNC
        params = ["data": axisArray ]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
            
            }?.resume()
    }
    
    /**
     Get logged in user article and video subscriptions.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    
    public func getUserSubscriptions(_ onComplete: KRSDKSubscriptionsComplete?,
                                     onFailure: KRSDKFailure?) {
        
        var articleSubscriptions: [String: Any]?
        var videoSubscriptions: [String: Any]?
        var apiError: Error?
        
        let apiGroup = DispatchGroup()
        
        // Request article subscriptions
        apiGroup.enter()
        
        getUserAxis({ (response) in
            if let response = response {
                articleSubscriptions = response
            }
            
            apiGroup.leave()
        }) { (error) in
            if let error = error {
                apiError = error
            }
            
            apiGroup.leave()
        }
        
        // Request video subscriptions
        apiGroup.enter()
        
        getUserVideoAxis({ (response) in
            if let response = response {
                videoSubscriptions = response
            }
            
            apiGroup.leave()
        }) { (error) in
            if let error = error {
                apiError = error
            }
            
            apiGroup.leave()
        }
        
        apiGroup.notify(queue: DispatchQueue.main) {
            if let error = apiError {
                onFailure?(error)
            } else {
                onComplete?(articleSubscriptions,
                            videoSubscriptions)
            }
        }
    }
    
    /**
     Get logged in user article axis or followed topics.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getUserAxis(_ onComplete: KRSDKComplete?,
                            onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        baseURL = Constants.FORMAT_AXIS_SYNC
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
            
            }?.resume()
    }
    
    /**
     Get logged in user video axis or followed topics.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getUserVideoAxis(_ onComplete: KRSDKComplete?, onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        baseURL = Constants.FORMAT_VIDEO_AXIS
        
        api.requestKurioAPI(self) { (response, object, error) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                return
            }
            
            if let result = object as? [String: Any] {
                onComplete?(result)
            }
            }?.resume()
    }
}
