//
//  UIImageView+extension.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 02/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func imageFromURL(urlString: String) -> UIImage{
        
        let url = URL(string: urlString)
    
        guard let contentUrl = url,
            let data = try? Data(contentsOf: contentUrl)
        else {
            return UIImage()
        }
        if let image = UIImage(data: data) {
            return image
        }  else
        {
            return UIImage()
        }
    }
}

