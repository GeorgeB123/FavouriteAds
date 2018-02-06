//
//  AdCell.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 02/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
    
    @IBOutlet weak var adImage: UIImageView!
    
    @IBOutlet weak var adTitle: UITextField!
    
    @IBOutlet weak var adLocation: UITextField!
    
    @IBOutlet weak var adPrice: UITextField!
    
    @IBOutlet weak var favouriteIcon: UIImageView!
    
    var isFavourite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.adPrice.isUserInteractionEnabled = false
        self.adLocation.isUserInteractionEnabled = false
        self.adTitle.isUserInteractionEnabled = false
        self.adTitle.borderStyle = UITextBorderStyle.none
        self.adLocation.borderStyle = UITextBorderStyle.none
        self.adPrice.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.adPrice.textColor = UIColor.white
        self.adPrice.layer.cornerRadius = Constants.cornerRadius
        self.adPrice.clipsToBounds = true
        self.adImage.layer.cornerRadius = Constants.cornerRadius
        self.adImage.clipsToBounds = true

    }
    
}
