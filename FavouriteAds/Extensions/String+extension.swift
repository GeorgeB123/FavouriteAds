//
//  String+extension.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 06/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import Foundation

extension String {
    
    public func convertToFree(price: String) -> String {
        if(price == Constants.zeroKrones) {
            return Constants.free
        }
        return price
    }
    
}
