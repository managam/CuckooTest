//
//  TrackerOutput.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 3/14/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import KurioPuree

open class TrackerOutput: BufferedOutput {
    
    open var backgroundTask = UIBackgroundTaskIdentifier()
    
    required public init(logger: Logger, tagPattern: String) {
        super.init(logger: logger, tagPattern: tagPattern)
    }
    
    override open func configure(_ settings: [String : Any]) {
        super.configure(settings)
    }
    
    override open func suspend() {
        let application = UIApplication.shared
        backgroundTask = application.beginBackgroundTask(withName: "kurio.logger.bgtask", expirationHandler: {
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        })
        
        DispatchQueue.global().async {
            self.flush()
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        }
    }
    
    open func sendLogs(_ logs: [Any],  completion: @escaping (_: Bool) -> Void) {
        let logData: Data? = try? JSONSerialization.data(withJSONObject: logs, options: [])
        #if DEBUG
            let json = try! JSONSerialization.jsonObject(with: logData!, options: [])

            print("\n=====================================\n" +
                "Sending : \(json)" +
                "\n=====================================\n")
            completion(true)
        #else
            var request = URLRequest(url: URL(string: TrackerAPIConstants.URL)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
            request.httpBody = logData
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("3", forHTTPHeaderField: "X-Kurio-Client-ID")
            request.addValue("KPVuHNFpbREyqTxjceU7", forHTTPHeaderField: "X-Kurio-Client-Secret")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let response = response {
                    debugPrint("\n=====================================\n" +
                               "Log Response : \(response)" +
                               "\n=====================================\n")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if error != nil || httpResponse.statusCode != 200 {
                        completion(false)
                        
                        return
                    }
                }
                
                debugPrint("Logs sent...")
                
                completion(true)
            })
        #endif
    }
}
