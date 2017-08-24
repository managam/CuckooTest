//
//  ImpressionCollectionViewAdapter.swift
//  KurioLogger
//
//  Created by Hendy Christianto on 4/3/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import Foundation
import UIKit

private enum Constants {
    static let TimeDiffInterval = 0.1
    static let MaxSpeedTrack: CGFloat = 200.0
}

public protocol ImpressionTrackerDataSource: class {
    func dataImpression(forIndexPath indexPath: IndexPath) -> ParentProperty?
}

open class ImpressionCollectionViewAdapter<T, C>: NSObject, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public let impressionManager: ImpressionManager
    
    public weak var dataSource: ImpressionTrackerDataSource?
    
    public unowned let collectionView: UICollectionView
    
    private(set) public var isAdapterViewFocused = false
    private(set) public var data = [T]()
    private(set) public var cursor: C?
    
    private var lastOffsetCapture: TimeInterval = 0
    private var lastOffset: CGFloat = 0.0
    
    /// Initialize adapter for stream.
    ///
    /// - Parameters:
    ///   - collectionView: collectionView object
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        self.impressionManager = ImpressionManager()
        
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    open func update(withData data: [T], cursor: C?) {
        self.data = data
        self.cursor = cursor
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
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
        
        collectionView.reloadData()
    }
    
    
    /// When view is refocused, the tracker will clear it's cache,
    /// and begin tracking from the beginning.
    ///
    /// - Parameter focused: flag view focused
    public func onViewFocused(_ focused: Bool) {
        isAdapterViewFocused = focused
        
        if focused {
            impressionManager.clearTrackerCache()
            
            trackImpression()
        }
    }
    
    //MARK: - Private Methods
    public func trackImpression() {
        guard data.isEmpty == false else {
            return
        }
        
        let visibleItems = collectionView.indexPathsForVisibleItems
        
        for indexPath in visibleItems {
            if indexPath.row >= data.count { return }
            
            if let impressionData = dataSource?.dataImpression(forIndexPath: indexPath) {
                impressionManager.trackImpression(withProperty: impressionData)
            }
        }
    }
    
    //MARK: - UICollectionView Delegate
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("numberOfItemsInSection section: not implemented yet")
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("cellForItemAt indexPath: not implemented yet")
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
        fatalError("sizeForItemAt indexPath: not implemented yet")
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fatalError("didSelectItemAt indexPath: not implemented yet")
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView{
        fatalError("viewForSupplementaryElementOfKind: not implemented yet")
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        debugPrint("didEndDisplaying cell", cell)
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
