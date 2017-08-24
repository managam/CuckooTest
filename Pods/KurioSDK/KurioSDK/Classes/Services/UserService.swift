//
//  UserService.swift
//  Kurio
//
//  Created by Hendy Christianto on 9/5/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

private struct Constants {
    static let BaseService = "user"
    static let UrlChangePassword = BaseService + "/changepassword"
    static let UrlForgotPassword = BaseService + "/forgotpassword"
    
    static let EmailParam = "email"
    static let OldPasswordParam = "old_password"
    static let NewPasswordParam = "new_password"
    static let UrlAddAttributes = BaseService + "/attributes"
    
    static let UrlUserLocation = BaseService + "/location"
}

public struct UserServiceError: Error {
    enum ErrorConstant {
        case getUserDetailError
        case updateUserEmail
        case changePasswordError
        case forgotPasswordError
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

public class UserService: ParentService {
    deinit {
        debugPrint("User Service dealloc..");
    }
    
    
    /**
     Get logged in user details. It will return all user details, including referral_link,
     axis, name, and others.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func getUserDetail(_ onComplete: KRSDKComplete?,
                              onFailure: KRSDKFailure?) -> URLSessionDataTask? {
        HTTPMethod = "GET"
        baseURL = Constants.BaseService
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
    
    
    /**
     Update user email. Can be only used when the user type is email.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func updateUserEmail(_ email: String, onComplete: KRSDKComplete?,
                                onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.BaseService
        params = [Constants.EmailParam: email]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if var err = error, err._code != NSURLErrorCancelled {
                
                let errMsg = NSLocalizedString(StringConst.ERROR_UPDATE_EMAIL, comment: "")
                
                err = UserServiceError(domain: .updateUserEmail, code: err._code, userInfo: errMsg)
                
                onFailure?(err)
                
                return
            }
            
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
            }?.resume()
    }
    
    
    
    /**
     Change user password. Can be only used when the user type is email.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func changePassword(_ oldPassword: String, newPassword: String,
                               onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.UrlChangePassword
        params = [Constants.OldPasswordParam: oldPassword,
                  Constants.NewPasswordParam: newPassword]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?, error: Error?) in
            if var err = error, err._code != NSURLErrorCancelled {
                let errMsg = NSLocalizedString(StringConst.ERROR_CHANGE_PASSWORD_WRONG_OLD, comment: "")
                err = UserServiceError(domain: .changePasswordError, code: err._code, userInfo: errMsg)
                onFailure?(err)
                return
            }
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
            }?.resume()
    }
    
    
    /**
     Send password to user email. Can be only used when the user type is email.
     
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func forgotPassword(_ email: String, onComplete: KRSDKComplete?,
                               onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.UrlForgotPassword
        params = [Constants.EmailParam: email]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?, error: Error?) in
            if var err = error, err._code != NSURLErrorCancelled {
                let errMsg = NSLocalizedString(StringConst.ERROR_FORGOT_PASSWORD, comment: "")
                err = UserServiceError(domain: .forgotPasswordError, code: err._code, userInfo: errMsg)
                onFailure?(err)
                return
            }
            if let result = responseObject as? [String: Any] {
                onComplete?(result)
            }
            }?.resume()
    }
    
    public func addUserAttributes(_ attributes: [String: Any], onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        baseURL = Constants.UrlAddAttributes
        params = attributes
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?, error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                return
            }
            
            if let result = response as? HTTPURLResponse, result.statusCode == 200 {
                debugPrint("Adding user attributes success: \(attributes)")
            }
            }?.resume()
    }
    
    /**
     Send user's latitude and longitude to the server.
     
     - parameter lat: latitude of user's location
     - parameter long: longitude of user' location
     - parameter onComplete: handler when the request success.
     - parameter onFailure:  handler when the request failed.
     */
    public func sendUserLocation(_ lat: Double, long: Double,
                                 onComplete: KRSDKComplete?, onFailure: KRSDKFailure?) {
        HTTPMethod = "POST"
        
        baseURL = Constants.UrlUserLocation
        
        params = ["longitude": long,
                  "latitude": lat]
        
        api.requestKurioAPI(self) { (response: URLResponse, responseObject: Any?,
            error: Error?) in
            if let err = error, err._code != NSURLErrorCancelled {
                onFailure?(err)
                
                return
            }
            
            onComplete?(nil)
            
        }?.resume()
    }
}
