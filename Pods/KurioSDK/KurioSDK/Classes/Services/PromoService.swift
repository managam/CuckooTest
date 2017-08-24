//
//  PromoService.swift
//  KurioSDK
//
//  Created by Managam Silalahi on 8/3/17.
//  Copyright © 2017 PT. Kurio. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "promo"
    static let URL_SUBMIT_PROMO = BASE_SERVICE + "/submit"
    static let URL_CLEAR_PROMO = BASE_SERVICE + "/%@/clear"
}

public class PromoService: ParentService {
    deinit {
        debugPrint("Promo Service dealloc..")
    }
    
    public func getAllSubmittedPromoCode(_ onComplete: KRSDKComplete?,
                                         onFailure: KRSDKFailure?) {
        HTTPMethod = "GET"
        
        baseURL = Constants.BASE_SERVICE
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any],
                let promoDatas = result["data"] as? [[String : Any]] {
                
                onComplete?(["data": promoDatas])
                
            }
            }?.resume()
    }
    
    public func submitPromoCode(_ params: [String: Any],
                                onComplete: KRSDKComplete?,
                                onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        
        baseURL = Constants.URL_SUBMIT_PROMO
        
        self.params = params
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any],
                let promoDictionary = result["data"] as? [String: Any] {
                
                onComplete?(["data": promoDictionary])
                
            }
            
            }?.resume()
    }
    
    public func clearPromoCode(_ promoId: String,
                               onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        
        baseURL = String(format: Constants.URL_CLEAR_PROMO, promoId)
        
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
}
