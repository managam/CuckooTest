//
//  TrackerManager.swift
//  Logger
//
//  Created by Managam Silalahi on 3/14/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import KurioPuree

public final class TrackerManager {
    private(set) var currentScreen: ScreenNameType
    
    private static var sharedInstance: TrackerManager?
    private let logger: Logger
        
    class var shared: TrackerManager {
        if let sharedLogger = sharedInstance {
            return sharedLogger
        }
        
        fatalError("Trying to call shared Logger without calling setup(withOutput:)")
    }
    
    private init(withFilter filter: Filter.Type,
                 output: BufferedOutput.Type,
                 logLimit: Int,
                 flushInterval: Int,
                 maxRetryCount: Int) {
        
        let outputSettings = [BufferedOutput.SettingsLogLimitKey: logLimit,
                              BufferedOutput.SettingsFlushIntervalKey: flushInterval,
                              BufferedOutput.SettingsMaxRetryCountKey: maxRetryCount]
        
        let configuration = LoggerConfiguration.defaultConfiguration()
        configuration.filterSettings = [FilterSetting(filter: filter, tagPattern: "kurio.**")]
        configuration.outputSettings = [OutputSetting(output: output, tagPattern: "kurio.**", settings: outputSettings)]
        
        logger = Logger(configuration: configuration)
        currentScreen = .StartApplication
    }
    
    /// Launch and set initial state from push notification.
    func launchFromPushNotification() {
        currentScreen = .PushNotif
    }
    
    /// Launch and set initial state from deeplinking.
    func launchFromDeeplinking() {
        currentScreen = .Deeplinking
    }
    
    /// Setup initialization for singleton manager.
    ///
    /// - Parameters:
    ///   - filter: your custom Filter type class
    ///   - output: your custom BufferedOutput type class
    public class func setup(withFilter filter: Filter.Type,
                            output: BufferedOutput.Type,
                            logLimit: Int = 10,
                            flushInterval: Int = 10,
                            maxRetryCount: Int = 5) {
        sharedInstance = TrackerManager(withFilter: filter,
                                        output: output,
                                        logLimit: logLimit,
                                        flushInterval: flushInterval,
                                        maxRetryCount: maxRetryCount)
    }
        
    /// Logging with event.
    ///
    /// - Parameters:
    ///   - event: event
    ///   - property: property string
    ///   - origin: origin screen name the event happened.
    ///   - tag: tag string
    func log(withEvent event: Event,
             property: Any,
             origin: ScreenNameType,
             andTag tag: Tag) {
        guard let propertyObject = checkValidProperty(property) else { return }
        
        logger.post(["action": event.rawValue,
                     "property": propertyObject,
                     "origin": ScreenName.getScreenNameValue(origin)],
                    tag: tag.rawValue)
    }
    
    /// Logging with screen view. Will tell the Logger your current screen on the app.
    ///
    /// - Parameters:
    ///   - screenView: action view screen
    ///   - screenName: the name string of current action view screen
    ///   - property: property string
    ///   - origin: the origin screen when you call this method.
    ///   - tag: tag string
    func log(withScreenView screenView: ScreenView,
             screenNameType: ScreenNameType,
             property: Any,
             origin: ScreenNameType,
             andTag tag: Tag) {
        guard let propertyObject = checkValidProperty(property) else { return }
        
        logger.post(["action": screenView.rawValue,
                     "property": propertyObject,
                     "origin": ScreenName.getScreenNameValue(origin)],
                    tag: tag.rawValue)
        
        currentScreen = screenNameType
    }
    
    
    // MARK: - Private Methods
    private func checkValidProperty(_ property: Any) -> Any? {
        var propertyObject = property
        
        if !(propertyObject is String) && !(propertyObject is ParentProperty) && !(propertyObject is Bool) && !(propertyObject is [String: Any]) {
            debugPrint("Unsupported property log type. Only String and ParentProperty supported.", propertyObject)
            return nil
        }
        
        if let prop = property as? ParentProperty {
            propertyObject = prop.dictionary
        }
        
        return propertyObject
    }
}
