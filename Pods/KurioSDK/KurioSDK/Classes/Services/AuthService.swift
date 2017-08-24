//
//  AuthService.swift
//  Kurio
//
//  Created by Hendy Christianto on 10/10/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BASE_SERVICE = "auth"
    
    static let SOCIAL_SERVICE = BASE_SERVICE + "/social/"
}

public enum AuthType: String {
    case Facebook = "facebook"
    case Twitter = "twitter"
    case Google = "google"
    case Email = "email"
}

public struct AuthServiceError: Error {
    enum ErrorConstant {
        case authGuestError
        case loginEmailError
        case signUpEmailError
        case socialMediaAuthError
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

public class AuthService: ParentService {
    deinit {
        debugPrint("Auth Service dealloc..");
    }
    
    
    /**
     Authenticate as guest, to get access_token used for KurioSDK.
     When this method called, it will set access_token to the ServiceManager
     
     - parameter params:     parameters required for the kurio api.
     See http://api-doc.id.kurioapps.com/api.html#authentication-login-as-guest-post for details.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func authGuest(_ params: [String: Any],
                          onComplete: KRSDKComplete?,
                          onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.BASE_SERVICE + "/guest"
        self.params = params
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any] {
                if let token = result["token"] as? [String: Any] {
                    self.api.accessToken = token["access_token"] as? String
                }
                
                onComplete?(result)
            }
            
            }?.resume()
    }
    
    
    /**
     Login with email.
     When this method called, it will set access_token to the ServiceManager
     
     - parameter email:      user email.
     - parameter password:   user password.
     - parameter uuid:       unique identifier generated from the device.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func loginEmail(_ email: String,
                           password: String,
                           uuid: String,
                           onComplete: KRSDKComplete?,
                           onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.BASE_SERVICE + "/login"
        params = ["email": email,
                  "password": password,
                  "uuid": uuid]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if var err = error, err._code != NSURLErrorCancelled {
                if let result = responseObject as? [String: Any],
                    let code = result["code"] as? Int {
                    
                    err = AuthServiceError(domain: .loginEmailError,
                                           code: code,
                                           userInfo: nil)
                    onFailure?(err)
                    return
                }
                
                onFailure?(err)
                return
            }
            
            if let result = responseObject as? [String: Any] {
                if let token = result["token"] as? [String: Any] {
                    self.api.accessToken = token["access_token"] as? String
                }
                
                onComplete?(result)
            }
            
            }?.resume()
    }
    
    
    /**
     Sign up using email.
     When this method called, it will set access_token to the ServiceManager
     
     - parameter email:            user email.
     - parameter password:         user password.
     - parameter fullname:         user fullname.
     - parameter remoteNotifToken: push notification token generated from the device.
     - parameter uuid:             unique identifier generated from the device.
     - parameter onComplete:       handler when the request success.
     - parameter onFailure:        handler when the request failed.
     */
    public func signUpEmail(_ email: String,
                            password: String,
                            fullname: String,
                            remoteNotifToken: String,
                            uuid: String,
                            onComplete: KRSDKComplete?,
                            onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.BASE_SERVICE + "/signup"
        params = ["email": email ,
                  "password": password ,
                  "name": fullname ,
                  "device_token": remoteNotifToken ,
                  "uuid": uuid ]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if var err = error, err._code != NSURLErrorCancelled {
                if let result = responseObject as? [String: Any],
                    let code = result["code"] as? Int {
                    err = AuthServiceError(domain: .signUpEmailError, code: code, userInfo: nil)
                    
                    onFailure?(err)
                    return
                }
                
                onFailure?(err)
                return
            }
            
            if let result = responseObject as? [String: Any] {
                if let token = result["token"] as? [String: Any] {
                    self.api.accessToken = token["access_token"] as? String
                }
                
                onComplete?(result)
            }
            
            }?.resume()
    }
    
    
    /**
     Connect Kurio with specific social media. When the social media account never
     registered or first time connect, server will attempt to register the account.
     Otherwise, it will attempt to login the account.
     When this method called, it will set access_token to the ServiceManager
     
     - parameter type:       user social media type. (facebook, twitter, google)
     - parameter params:     parameters required for the kurio api.
     See http://api-doc.id.kurioapps.com/api.html#authentication for details.
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func socialMediaAuth(_ type: AuthType,
                                params: [String: Any],
                                onComplete: KRSDKComplete?,
                                onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        
        switch type {
        case .Facebook, .Twitter, .Google:
            baseURL = Constants.SOCIAL_SERVICE + type.rawValue
        default:
            fatalError("Unsupported type social auth")
        }
        
        self.params = params
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            
            if var err = error, err._code != NSURLErrorCancelled {
                
                if let result = responseObject as? [String: Any],
                    let code = result["code"] as? Int {
                    err = AuthServiceError(domain: .socialMediaAuthError, code: code, userInfo: nil)
                    
                    onFailure?(err)
                    return
                }
                
                onFailure?(err)
                return
            }
            
            if let result = responseObject as? [String: Any] {
                if let token = result["token"] as? [String: Any] {
                    self.api.accessToken = token["access_token"] as? String
                }
                
                onComplete?(result)
            }
            
            }?.resume()
    }
}
