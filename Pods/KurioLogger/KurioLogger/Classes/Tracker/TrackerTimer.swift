//
//  TrackerTimer.swift
//  KurioLogger
//
//  Created by Managam Silalahi on 4/5/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation

public class TrackerTimer {
    // Total Duration in seconds
    private var totalDuration = 0
    private var startTimestamp = NSDate().timeIntervalSince1970
    private var isStarted = false
    
    public init() {}
    
    public func resume() {
        if canStart() == false { return }
        startTimestamp = NSDate().timeIntervalSince1970
        isStarted = true
    }
    
    public func pause() {
        if canPause() == false { return }
        totalDuration += getDeltaTime()
        isStarted = false
    }
    
    func stop() {
        pause()
        startTimestamp = 0
    }
    
    public func getDuration() -> Int {
        stop()
        return totalDuration
    }
    
    private func canPause() -> Bool {
        if isStarted == false {
            debugPrint("Pausing tracker when already stopped")
            return false
        }
        return true
    }
    
    private func canStart() -> Bool {
        if isStarted {
            debugPrint("Resuming tracker when already starting")
            return false
        }
        return true
    }
    
    private func getDeltaTime() -> Int {
        let deltaTime = NSDate().timeIntervalSince1970 - startTimestamp
        
        if deltaTime < 0 {
            #if DEBUG
                fatalError("Delta time is minus!")
            #else
                debugPrint("Delta time tracker is minus")
                return 0
            #endif
        }
        
        return Int(deltaTime)
    }
}
