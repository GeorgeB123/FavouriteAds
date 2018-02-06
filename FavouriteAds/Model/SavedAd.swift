//
//  savedAd.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 03/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

class SavedAd: NSObject, NSCoding {
    
    //MARK: Properties
    
    let price: Int
    let location: String
    let title: String
    let referenceAdIndex: Int
    var isFavourite = true
    var image = UIImage()

    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("favouriteAds")
    
    //MARK: Initialization
    
    init(price: Int, location: String, title: String, image: UIImage, referenceAdIndex: Int) {
        self.price = price
        self.location = location
        self.title = title
        self.image = image
        self.referenceAdIndex = referenceAdIndex
    }

    //MARK: Properkeys to archive
    
    struct PropertyKeys {
        static let price = "price"
        static let location = "locatiom"
        static let title = "title"
        static let referenceAdIndex = "referenceAdIndex"
        static let image = "image"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKeys.title)
        aCoder.encode(price, forKey: PropertyKeys.price)
        aCoder.encode(location, forKey: PropertyKeys.location)
        aCoder.encode(referenceAdIndex, forKey: PropertyKeys.referenceAdIndex)
        aCoder.encode(image, forKey: PropertyKeys.image)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKeys.title) as? String,
            let location = aDecoder.decodeObject(forKey: PropertyKeys.location) as? String,
            let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage
            else {
                return nil
        }
        let price = aDecoder.decodeInteger(forKey: PropertyKeys.price)
        let referenceAdIndex = aDecoder.decodeInteger(forKey: PropertyKeys.referenceAdIndex)
        self.init(price: price, location: location, title: title, image: image, referenceAdIndex: referenceAdIndex)
    }
}


