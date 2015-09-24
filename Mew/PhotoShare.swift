//
//  PhotoShare.swift
//  Mew
//
//  Copyright © 2015 Mew. All rights reserved.
//

import Foundation
class PhotoShare {
    static let sharedInstance = PhotoShare()
    
    var gameScore: Int = 0
    
    internal var selectedInfo : NSMutableArray = NSMutableArray()
    
    
    // METHODS
    private init() {

        selectedInfo.removeAllObjects()
        
    }
}
