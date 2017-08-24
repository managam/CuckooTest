//
//  FeedService.swift
//  Kurio
//
//  Created by Hendy Christianto on 8/12/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

private struct Constants {
    static let BASE_SERVICE = "feed"
    static let FORMAT_GEO_FEED = BASE_SERVICE + "/geolocation"
    static let FORMAT_SEARCH = BASE_SERVICE + "/search:%@"
    static let DEFAULT_REQUEST_NUM: Int = 20
}

import Foundation

public class FeedService: ParentService {
    
    deinit {
        debugPrint("Feed Service dealloc..");
    }
    
    
    /**
     Get article feed streams.
     
     - parameter streamFormat: the category stream format (<type>:<id>), eg: topic:40, source:100, topic:99.
     - parameter cursor:           identifier cursor, taken from server and used for pagination.
     - parameter detail:           when true, server will return stream, including the article details.
     - parameter num:              number of articles to be fetched in one request.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getArticleList(_ streamFormat: String,
                               cursor: String,
                               detail: Bool,
                               num: Int,
                               onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        params = [String: Any]()
        
        HTTPMethod = "GET"
        
        if cursor.isEmpty == false {
            params!["cursor"] = cursor
        }
        
        if num == 0 {
            params!["num"] = NSNumber(value: Constants.DEFAULT_REQUEST_NUM)
        } else {
            params!["num"] = NSNumber(value: num)
        }
        
        params!["detail"] = String(detail)
        
        baseURL = Constants.BASE_SERVICE + "/" + streamFormat
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(responseObject as? [String: Any])
        }
        
        task!.resume()
        
        return task
    }
    
    
    /**
     Get article geolocation feed streams.
     
     - parameter locationId: (Optional) id of location if not automatic detection location
     - parameter cursor:           identifier cursor, taken from server and used for pagination.
     - parameter detail:           when true, server will return stream, including the article details.
     - parameter num:              number of articles to be fetched in one request.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    
    public func getArticleListGeoLocation(locationId: Int?,
                                          cursor: String,
                                          detail: Bool,
                                          num: Int,
                                          onComplete: KRSDKComplete?,
                                          onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        params = [String: Any]()
        
        HTTPMethod = "GET"
        
        if cursor.isEmpty == false {
            params!["cursor"] = cursor
        }
        
        if num == 0 {
            params!["num"] = NSNumber(value: Constants.DEFAULT_REQUEST_NUM)
        } else {
            params!["num"] = NSNumber(value: num)
        }
        
        params!["detail"] = String(detail)
        
        baseURL = Constants.FORMAT_GEO_FEED
        
        if let locationId = locationId, locationId > 0 {
            baseURL = "\(Constants.FORMAT_GEO_FEED):\(locationId)"
        }
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(responseObject as? [String: Any])
        }
        
        task!.resume()
        
        return task
    }
    
    
    /**
     Get article feed streams, based on the keyword.
     
     - parameter keyword:    the keyword used to search specific article
     - parameter cursor:     identifier cursor, taken from server and used for pagination.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getArticleListWithKeyword(_ keyword: String,
                                          cursor: String,
                                          onComplete: KRSDKComplete?,
                                          onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        params = [String: Any]()
        
        if cursor.isEmpty == false {
            params!["cursor"] = cursor
        }
        
        guard let encodedKeyword = keyword
            .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return nil
        }
        
        baseURL = String(format: Constants.FORMAT_SEARCH, encodedKeyword)
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
        }
        
        task!.resume()
        
        return task
    }
    
}
