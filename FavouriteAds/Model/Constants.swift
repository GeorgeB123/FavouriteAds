//
//  Constants.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 01/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//
import CoreGraphics
import UIKit

//MARK: Constants

struct Constants {
    
    static let cellHeightFactor = CGFloat(3)
    static let cellWidthFactor = CGFloat(2.1)
    static let krone = ",-"
    static let urlForAdsJson = "https://gist.githubusercontent.com/3lvis/3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"
    static let baseImageUrl = "https://images.finncdn.no/dynamic/480x360c/"
    static let cellEdgeConstraints = CGFloat(2.5)
    static let cornerRadius = CGFloat(10)
    static let favouriteHeart = #imageLiteral(resourceName: "fillHeart")
    static let emptyHeart = #imageLiteral(resourceName: "clearHeart")
    static let arrayEndIndexOffset = 1
    static let startIndex = 0
    static let allAdsTitle = "Alle"
    static let favouriteAdTitle = "Kun favoritter"
    static let zeroKrones = "0,-"
    static let free = "Gis bort"
    
}
