//
//  SearchService.swift
//  Kurio
//
//  Created by Hendy Christianto on 9/9/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "search/recommendation"
}

import Foundation

public class SearchService: ParentService {
    
    deinit {
        debugPrint("Search Service dealloc..")
    }
    
    
    /**
     Get recommended keywords for search.
     
     - parameter params:     parameters required for the kurio api.
                             See http://api-doc.id.kurioapps.com/api.html#search-search-recommendation-get for details.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getRecommendedKeywords(_ params: [String: Any],
                                       onComplete: KRSDKComplete?,
                                       onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        baseURL = Constants.BASE_SERVICE
        self.params = params
        
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
