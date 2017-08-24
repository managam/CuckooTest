//
//  DeviceService.swift
//  Kurio
//
//  Created by Hendy Christianto on 9/1/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "device"
}

public struct DeviceServiceError: Error {
    enum ErrorConstant {
        case registerDeviceToken
        case unregisterDeviceToken
    }
    
    let domain: ErrorConstant
    let code: Int
    let userInfo: String?
    
    init(domain: ErrorConstant, code: Int, userInfo: String?) {
        self.domain = domain
        self.code = code
        self.userInfo = userInfo
    }
}

public class DeviceService: ParentService {
    deinit {
        debugPrint("Device Service dealloc..");
    }
    
    
    /**
     Register device token to server to receive push notifications.
     
     - parameter params:     parameters required for the kurio api.
                             See http://api-doc.id.kurioapps.com/api.html#device for details.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func registerDeviceToken(_ params: [String: Any],
                                    onComplete: KRSDKComplete?,
                                    onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "POST"
        baseURL = Constants.BASE_SERVICE
        self.params = params
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                
                let errMsg = NSLocalizedString(StringConst.ERROR_REGISTER_DEVICE, comment: "")
                let error = DeviceServiceError(domain: .registerDeviceToken,
                                               code: 1,
                                               userInfo: String(describing: [NSLocalizedDescriptionKey: errMsg]))
                onFailure?(error)
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
     Unregister device token to server to stop receive push notifications.
     
     - parameter params:     parameters required for the kurio api.
                             See http://api-doc.id.kurioapps.com/api.html#device for details.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func unregisterDeviceToken(_ params: [String: Any],
                                      onComplete: KRSDKComplete?,
                                      onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "DELETE"
        baseURL = Constants.BASE_SERVICE
        self.params = params
        
        let task = api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let errMsg = NSLocalizedString(StringConst.ERROR_UNREGISTER_DEVICE, comment: "")
                let error = DeviceServiceError(domain: .registerDeviceToken,
                                               code: 1,
                                               userInfo: String(describing: [NSLocalizedDescriptionKey: errMsg]))
                onFailure?(error)
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
}
