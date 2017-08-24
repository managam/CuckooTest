//
//  ImpressionTableViewAdapter.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 8/11/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation


private enum Constants {
    static let TimeDiffInterval = 0.1
    static let MaxSpeedTrack: CGFloat = 200.0
    static let OnFocusedDelay = 0.8
}

open class ImpressionTableViewAdapter<T, C>: NSObject, UITableViewDelegate, UITableViewDataSource {
    public let impressionManager: ImpressionManager
    
    public weak var dataSource: ImpressionTrackerDataSource?
    
    public unowned let tableView: UITableView
    
    private(set) public var isAdapterViewFocused = false
    private(set) public var data = [T]()
    private(set) public var cursor: C?
    
    private var lastOffsetCapture: TimeInterval = 0
    private var lastOffset: CGFloat = 0.0
    
    /// Initialize adapter for stream.
    ///
    /// - Parameters:
    ///   - tableView: table view object
    public init(tableView: UITableView) {
        self.tableView = tableView
        
        self.impressionManager = ImpressionManager()
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    open func update(withData data: [T], cursor: C?, isFromCache: Bool) {
        self.data = data
        self.cursor = cursor
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            if isFromCache {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if self?.isAdapterViewFocused ?? false {
                    // Track data
                    self?.trackImpression()
                }
            }
        }
    }
    
    open func append(withData data: [T], cursor: C?) {
        self.data.append(contentsOf: data)
        self.cursor = cursor
        
        tableView.reloadData()
    }
    
    public func insert(object: T, at index: Int) {
        self.data.insert(object, at: index)
    }
    
    
    /// When view is refocused, the tracker will clear it's cache,
    /// and begin tracking from the beginning.
    ///
    /// - Parameter focused: flag view focused
    public func onViewFocused(_ focused: Bool) {
        isAdapterViewFocused = focused
        
        if focused {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.OnFocusedDelay,
                                          execute: { [weak self] in
                                            self?.impressionManager.clearTrackerCache()
                
                                            self?.trackImpression()
            })
        }
    }
    
    public func getCount() -> Int {
        return data.count
    }
    
    
    //MARK: - Private Methods
    public func trackImpression() {
        guard data.isEmpty == false else {
            return
        }
        
        guard let visibleItems = tableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleItems {
            if indexPath.row >= data.count { return }
            
            if let impressionData = dataSource?.dataImpression(forIndexPath: indexPath) {
                impressionManager.trackImpression(withProperty: impressionData)
            }
        }
    }
    
    //MARK: - UITableView Delegate
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("numberOfRowsInSection section: not implemented yet")
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("cellForRowAt indexPath: not implemented yet")
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fatalError("didSelectRowAt indexPath: not implemented yet")
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Do nothing, impl on subclass
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Do nothing, impl on subclass
    }
    
    
    //MARK: - UIScrollView Delegate
    
    /// Track impression on scroll
    ///
    /// - Parameter scrollView: scrollView
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        let timeDiff = currentTime - lastOffsetCapture
        
        if timeDiff < Constants.TimeDiffInterval {
            return
        }
        
        let distance = currentOffset - lastOffset
        
        // Track
        if distance <= Constants.MaxSpeedTrack {
            trackImpression()
        }
        
        lastOffsetCapture = currentTime
        lastOffset = currentOffset
    }
}
