//
//  AdsCollectionViewController+Extension.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 06/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit

//MARK: UICollectionViewDelegate

extension AdsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/Constants.cellWidthFactor, height: collectionView.bounds.size.height/Constants.cellHeightFactor)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.cellEdgeConstraints, left: Constants.cellEdgeConstraints, bottom: Constants.cellEdgeConstraints, right: Constants.cellEdgeConstraints)
    }
    
}
