//
//  VideoService.swift
//  KurioSDK
//
//  Created by Managam Silalahi on 2/10/17.
//  Copyright © 2017 PT. Kurio. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "videofeed"
    static let DEFAULT_REQUEST_NUM: Int = 10
    static let BASE_SERVICE_VIDEO_DETAIL = "video"
    static let FORMAT_EXPAND_VIDEO_HASH = BASE_SERVICE_VIDEO_DETAIL + "/hash"
    static let FORMAT_RELATED_VIDEOS = BASE_SERVICE_VIDEO_DETAIL + "/%@/related"
    static let DEFAULT_REQUEST_RELATED_VIDEOS_NUM: Int = 5
}

public class VideoService: ParentService {
    
    deinit {
        debugPrint("Video Service dealloc...")
    }
    
    /**
     Get video detail using video's id.
     
     - parameter id:               the video category id.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getVideoDetail(videoId: String,
                               onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        baseURL = Constants.BASE_SERVICE_VIDEO_DETAIL + "/\(videoId)"
        
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
     Get video detail using hash which is video's short url.
     
     - parameter hash:             the video's short url as string.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getVideoDetail(hash: String,
                               onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        baseURL = Constants.FORMAT_EXPAND_VIDEO_HASH + "/\(hash)"
        
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
     Get related videos.
     
     - parameter id:                the video's id.
     - parameter tag:               Information current tab
     Example: top_videos, category:news
     - parameter num:               Number of Videos to be returned per feed (default 5)
     - parameter onComplete:        handler when the request success.
     - parameter onFailure:         handler when the request failed.
     */
    public func getRelatedVideos(videoId: String,
                                 streamItem: String,
                                 num: Int,
                                 onComplete: KRSDKComplete?,
                                 onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        params = [String: Any]()
        HTTPMethod = "GET"
        
        if streamItem.isEmpty == false, let tab = streamItem.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            params!["tab"] = tab
        }
        
        if num == 0 {
            params!["num"] = NSNumber(value: Constants.DEFAULT_REQUEST_RELATED_VIDEOS_NUM)
        } else {
            params!["num"] = NSNumber(value: num)
        }
        
        baseURL = String(format: Constants.FORMAT_RELATED_VIDEOS, videoId)
        
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

