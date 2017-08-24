//
//  ExploreService.swift
//  Kurio
//
//  Created by Hendy Christianto on 9/14/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "explore"
    static let FORMAT_SUBTOPIC = BASE_SERVICE + "/group/%@"
    static let FORMAT_TOPICSANDSOURCES = BASE_SERVICE + "/search"
}

public class ExploreService: ParentService {
    
    deinit {
        debugPrint("Explore Service dealloc..")
    }
    
    
    /**
     Get topic list, including featured topics and recommended topics.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getTopicList(_ onComplete: KRSDKComplete?,
                             onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        baseURL = Constants.BASE_SERVICE
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(responseObject as? [String: Any])
        }
        
        task?.resume()
        
        return task
    }
    
    
    /**
     Get subtopic list on specified topic group id.
     
     - parameter topicGroupId: topic group id.
     - parameter onComplete:   handler when the request success.
     - parameter onFailure:    handler when the request failed.
     */
    public func getSubtopicsWithTopicGroup(_ topicGroupId: String,
                                           onComplete: KRSDKComplete?,
                                           onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        baseURL = String(format: Constants.FORMAT_SUBTOPIC, topicGroupId)
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(responseObject as? [String: Any])
        }
        
        task?.resume()
    }
    
    public func getTopicsAndSources(withKeyword keyword: String,
                                    onComplete: @escaping KRSDKComplete,
                                    onFailure: @escaping KRSDKFailure) -> URLSessionDataTask? {
        HTTPMethod = "POST"
        baseURL = Constants.FORMAT_TOPICSANDSOURCES
        params = ["keyword": keyword]
        
        let task = api.requestKurioAPI(self) { (response, responseObject, error) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure(err)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return
            }
            
            if let result = responseObject as? [String: Any] {
                onComplete(result)
            }
        }
        
        task?.resume()
        
        return task
    }
}
