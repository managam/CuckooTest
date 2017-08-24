//
//  ArticleService.swift
//  Kurio
//
//  Created by Hendy Christianto on 8/16/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "article"
    static let GEOLOCATION = "geolocation"
    static let FORMAT_ARTICLE_FAVORITE = BASE_SERVICE + "/%@/favorite"
    static let FORMAT_RELATED_ARTICLES = BASE_SERVICE + "/%@/related"
}

public class ArticleService: ParentService {
    deinit {
        debugPrint("Article Service dealloc..");
    }
    
    
    /**
     Get related articles on specified article id.
     
     - parameter articleId:        article id
     - parameter subscriptionStreamFormat: the category stream format (<type>:<id>), eg: topic:40, source:100, topic:99.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getRelatedArticles(_ articleId: String,
                                   streamFormat: String,
                                   onComplete: KRSDKComplete?,
                                   onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        let currentStream = streamFormat
            .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        params = ["tab": currentStream! ]
        baseURL = String(format: Constants.FORMAT_RELATED_ARTICLES, articleId)
        
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
     Get related articles on specified article id.
     
     - parameter articleId:        article id
     - parameter locationId:       id of current location, eg: 19 = DKI Jakarta.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func getRelatedGeoArticles(_ articleId: String,
                                      locationId: Int?,
                                      onComplete: KRSDKComplete?,
                                      onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        
        var streamFormat = Constants.GEOLOCATION.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let locationId = locationId, locationId > 0 {
            streamFormat = "\(streamFormat!):\(locationId)"
        }
        
        params = ["tab": streamFormat]
        baseURL = String(format: Constants.FORMAT_RELATED_ARTICLES, articleId)
        
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
     Get article details on specified article id.
     
     - parameter articleId:  article id
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getArticleDetail(_ articleId: String,
                                 onComplete: KRSDKComplete?,
                                 onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        baseURL = Constants.BASE_SERVICE + "/" + articleId
        
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
     Favorite an article on specified article id.
     
     - parameter articleId:  article id
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func favoriteArticle(_ articleId: String,
                                onComplete: KRSDKComplete?,
                                onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "POST"
        
        baseURL = String(format: Constants.FORMAT_ARTICLE_FAVORITE, articleId)
        
        let task = api.requestKurioAPI(self, completionHandler: { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return
            }
            
            if let result = responseObject as? [String: Any],
                let data = result["data"] as? [String: Any],
                (data["success"] as? Bool) == true {
                onComplete?(result)
            }
        })
        
        task?.resume()
        
        return task
    }
    
    
    /**
     Unfavorite an article on specified article id.
     
     - parameter articleId:  article id
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func unfavoriteArticle(_ articleId: String,
                                  onComplete: KRSDKComplete?,
                                  onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "DELETE"
        
        baseURL = String(format: Constants.FORMAT_ARTICLE_FAVORITE, articleId)
        
        let task = api.requestKurioAPI(self, completionHandler: { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return
            }
            
            if let result = responseObject as? [String: Any],
                let data = result["data"] as? [String: Any],
                (data["success"] as? Bool) == true {
                onComplete?(result)
            }
        })
        
        task?.resume()
        
        return task
    }
}
