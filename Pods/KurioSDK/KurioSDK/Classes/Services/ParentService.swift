//
//  ParentService.swift
//  Kurio
//
//  Created by Hendy Christianto on 8/15/16.
//  Copyright © 2016 merahputih. All rights reserved.
//

import Foundation

public typealias KRSDKComplete = ([String: Any]?) -> Void
public typealias KRSDKSubscriptionsComplete = (_ articleSubscriptions: [String: Any]?, _ videoSubscriptions:[String: Any]?) -> Void
public typealias KRSDKFailure = (Error?) -> Void

public class ParentService {
    internal(set) var baseURL: String?
    internal(set) var HTTPMethod: String?
    internal(set) var params: [String: Any]?
    
    let api = ServiceManager.api
    
    public init () { }
    
    func getHTTPGetBaseURL() -> String {
        var reqString = baseURL!
        let enumerator = params?.keys
        
        if let keys = enumerator {
            for key in keys {
                if reqString.range(of: "?") == nil {
                    reqString += "?"
                }
                
                var paramString = params![key] as? String
                
                if paramString == nil {
                    paramString = (params![key] as? NSNumber)?.stringValue
                }
                
                if paramString == "" || paramString == "(null)" {
                    continue
                }
                
                reqString += String(format: "%@=%@&", key, paramString!)
            }
        }
        
        if reqString.characters.last == "&" {
            reqString = String(reqString.characters.dropLast())
        }
        
        return reqString
    }
    
    func getHTTPBody() -> Data? {
        if HTTPMethod! == "GET" {
            return nil
        }
        
        if let parameter = params {
            var body: Data?
            do {
                body = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch let error {
                print("Error parsing data to body : ", error.localizedDescription)
            }
            
            return body
        }
        
        return nil
    }
    
}
