//
//  ServiceManager.swift
//  Kurio
//
//  Created by Hendy Christianto on 8/12/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation
import UIKit

private struct Constants {
    static let KURIO_CLIENT_ID = "3"
    static let KURIO_CLIENT_SECRET = "KPVuHNFpbREyqTxjceU7"
}

public class ServiceManager: AFHTTPSessionManager {
    
    public static let api = ServiceManager()
    public var accessToken: String?
    public var config: Config
    public var interceptor: ((Int) -> Void)?
    
    //MARK: - Initialization API
    
    convenience init() {
        let conf = URLSessionConfiguration.default
        conf.httpCookieAcceptPolicy = .never
        conf.httpCookieStorage = nil
        conf.urlCache = nil
        self.init(baseURL: nil, sessionConfiguration: conf)
    }
    
    override init(baseURL url: URL?, sessionConfiguration configuration: URLSessionConfiguration?) {
        self.config = Config(production: true, logApi: false)
        super.init(baseURL: url, sessionConfiguration: configuration)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Service dealloc..");
    }
    
    //MARK: - Kurio HTTP Header
    
    fileprivate func setHeader(_ request: URLRequest) -> URLRequest {
        var urlRequest = request
        if let token = accessToken {
            urlRequest.addValue(String(format: "Bearer %@", token), forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue(userAgent(), forHTTPHeaderField: "User-Agent")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(Constants.KURIO_CLIENT_ID, forHTTPHeaderField: "X-Kurio-Client-ID")
        urlRequest.addValue(Constants.KURIO_CLIENT_SECRET, forHTTPHeaderField: "X-Kurio-Client-Secret")
        urlRequest.addValue("ios", forHTTPHeaderField: "X-OS")
        
        if let bundleId = Bundle.main.bundleIdentifier {
            urlRequest.addValue(bundleId, forHTTPHeaderField: "X-App-Name")
        }
        
        urlRequest.addValue(appVersion(), forHTTPHeaderField: "X-App-Version")
        
        debugPrint("Request Header")
        debugPrint("=======================================")
        debugPrint(urlRequest.allHTTPHeaderFields ?? "request.allHTTPHeaderFields may become nil")
        
        return urlRequest
    }
    
    public func userAgent() -> String {
        var appBuildVersion = ""
        if let info = Bundle.main.infoDictionary {
            appBuildVersion = info["CFBundleVersion"] as! String
        }
        let OSVersion = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.model
        return String(format: "Kurio/%@ Build %@ (%@; %@)", appVersion(), appBuildVersion,
                      OSVersion, deviceModel)
    }
    
    public func appVersion() -> String {
        guard let info = Bundle.main.infoDictionary else {
            return ""
        }
        return info["CFBundleShortVersionString"] as! String
    }
    
    //MARK: - API Method
    
    /**
     Request to API Kurio Server with Base URL extension ex: article/article_list/1
     
     - parameter service:           the service kurio
     - parameter completionHandler: completion after get response from server
     
     - returns: NSURLSessionDataTask
     */
    func requestKurioAPI(_ service: ParentService,
                         completionHandler: ((URLResponse, Any?, Error?) -> Void)?) -> URLSessionDataTask? {
        var url: URL?
        
        if service.HTTPMethod! == "GET" {
            url = URL(string: (config.serverUrl + service.getHTTPGetBaseURL()))
        } else {
            url = URL(string: (config.serverUrl + service.baseURL!))
        }
        
        if url == nil {
            debugPrint("Invalid url")
            return nil
        }
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = service.HTTPMethod!
        urlRequest.httpBody = service.getHTTPBody() as Data?
        
        urlRequest = setHeader(urlRequest)
        debugPrint("URL : ", urlRequest.url ?? "urlRequest.url may become nil")
        
        return self.dataTask(with: urlRequest as URLRequest,
                             completionHandler: { (response: URLResponse,
                                object: Any?,
                                error: Error?) in
                                
                                if self.tasks.count == 0 {
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                } else {
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                }
                                
                                if self.config.logApi {
                                    debugPrint("API RESPONSE")
                                    if let err = error {
                                        debugPrint("==========================================")
                                        debugPrint("OPERATION FAILED")
                                        debugPrint("------------------------------------------")
                                        debugPrint(err.localizedDescription)
                                        debugPrint("===========================================")
                                    } else {
                                        debugPrint("==========================================")
                                        debugPrint("Params : ", service.params ?? "service.params may become nil")
                                        debugPrint("-------------------------------------------")
                                        debugPrint(object ?? "object may becom nil")
                                        debugPrint("===========================================")
                                    }
                                }
                                
                                if let httpResponse = response as? HTTPURLResponse {
                                    self.interceptor?(httpResponse.statusCode)
                                }
                                
                                completionHandler?(response, object, error)
        })
    }
}

