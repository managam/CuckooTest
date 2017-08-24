//
//  AdsService.swift
//  Kurio
//
//  Created by Hendy Christianto on 8/16/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "ads"
    static let FORMAT_ADS = BASE_SERVICE + "/%@/%d...%d"
    static let FORMAT_ADS_STREAM = BASE_SERVICE + "/%@:%@/%d...%d"
}

public class AdsService: ParentService {
    deinit {
        debugPrint("Ads Service dealloc..");
    }
    
    
    /**
     Get Ads on specified axis id and type. The ads is specified per position in
     the article streams.
     
     - parameter axisId:     axis id or category id
     - parameter axisType:   axis type or category type, eg: topic, source
     - parameter from:       request position start index in the streams.
     - parameter to:         request position end index in the streams.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getAdsOnStream(_ axisId: String,
                        axisType: String,
                        from: Int,
                        to: Int,
                        onComplete: KRSDKComplete?,
                        onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        if axisId != "top_stories" && axisId != "favorites" {
            baseURL = String(format: Constants.FORMAT_ADS_STREAM, axisId, axisId, from, to)
        } else {
            baseURL = String(format: Constants.FORMAT_ADS, axisId, from, to)
        }
        
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
        
        task?.resume()
        
        return task
    }
}
