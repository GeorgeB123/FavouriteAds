//
//  Ad.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 01/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

struct Ad {
    
    //MARK: Properties
    
    let photoUrl: String
    let price: Int
    let location: String
    let title: String
    var referenceAdIndex: Int?
    var isFavourite = false
    var image = UIImage()
    
    //MARK: Initialization
    
    init(photoUrl: String, price: Int, location: String, title: String, image: UIImage) {
        self.photoUrl = photoUrl
        self.price = price
        self.location = location
        self.title = title
        self.image = image
    }
    
}

//MARK: Private Functions

extension Ad {
    
    static func parse(_ json: [String: Any]) -> Ad? {
        
        var photoUrl = ""
        var price = Int()
        var location = ""
        var title = ""
        
        if let imageInformation = json["image"] as? [String: Any],
            let url = imageInformation["url"] as? String {
            photoUrl = Constants.baseImageUrl + url
        }
        if let priceInformation = json["price"] as? [String: Any],
            let value = priceInformation["value"] as? Int {
            price = value
        }
        
        if let placeName = json["location"] as? String {
            location = placeName
        }
        if let description = json["description"] as? String {
            title = description
        }
        
        return Ad(photoUrl: photoUrl , price: price , location: location, title: title, image: UIImage())
    }
    
    static func fetchAds(matching query: String, completion: @escaping ([Ad]) -> Void) {
        let session = URLSession.shared
        guard let queryString = URL(string: Constants.urlForAdsJson) else {
            return
        }
        var request = URLRequest(url: queryString)
        request.httpMethod = "GET"
        session.dataTask(with: request as URLRequest, completionHandler: { data,_,_ in
            var ads: [Ad] = []
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let adArray = json?["items"] as? NSArray
                else {
                    return
            }
            for case let result in adArray {
                if let adToAppend = result as? [String: Any],
                    let parsedAd = Ad.parse(adToAppend) {
                    ads.append(parsedAd)
                }
            }
            completion(ads)
        }).resume()
    }
}

