//
//  VideoFeedService.swift
//  KurioSDK
//
//  Created by admin on 8/10/17.
//  Copyright © 2017 PT. Kurio. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "videofeed"
    static let DEFAULT_REQUEST_NUM: Int = 10
}

public class VideoFeedService: ParentService {
    
    deinit {
        debugPrint("Video Feed Service dealloc...")
    }
    
    /**
     Get video feed streams.
     
     - parameter id:               the video category id.
     - parameter cursor:           identifier cursor, taken from server and used for pagination.
     - parameter num:              number of articles to be fetched in one request.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getVideoList(streamFormat: String,
                             cursor: String,
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
}
