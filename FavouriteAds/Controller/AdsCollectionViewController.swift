//
//  AdsCollectionViewController.swift
//  FavouriteAds
//
//  Created by George Bonnici-Carter on 01/02/2018.
//  Copyright © 2018 George Bonnici-Carter. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class AdsCollectionViewController: UICollectionViewController {
    
    var ads = [Ad]()
    var favouriteAds = [SavedAd]()
    let mySwitch = UISwitch(frame: .zero)
    
    @IBOutlet weak var adTitle: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adTitle.title = Constants.allAdsTitle
        switchConfig()
        if let savedAds = loadAds() {
            self.favouriteAds = savedAds
        }
        Ad.fetchAds(matching: Constants.urlForAdsJson) { ads in
            DispatchQueue.main.async {
                self.ads = ads
                self.collectionView?.reloadData()
            }
        }

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!mySwitch.isOn){
            return self.favouriteAds.count
        } else {
            return self.ads.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as? AdCell else {
            fatalError("Cell does not exist")
        }
        if(mySwitch.isOn) {
            animateFavourites(adIndex: indexPath.row)
            cell.adLocation.text = self.ads[indexPath.row].location
            cell.adTitle.text = self.ads[indexPath.row].title
            cell.adPrice.text = String().convertToFree(price: self.ads[indexPath.row].price.description + Constants.krone)
            cell.adImage.sd_setImage(with: URL(string: self.ads[indexPath.row].photoUrl), placeholderImage: UIImage())
            isFavouriteAd(heart: self.ads[indexPath.row].isFavourite, cell: cell)
        } else {
            cell.adLocation.text = self.favouriteAds[indexPath.row].location
            cell.adTitle.text = self.favouriteAds[indexPath.row].title
            cell.adPrice.text = String().convertToFree(price: self.favouriteAds[indexPath.row].price.description + Constants.krone)
            cell.adImage.image = self.favouriteAds[indexPath.row].image
            isFavouriteAd(heart: self.favouriteAds[indexPath.row].isFavourite, cell: cell)
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(mySwitch.isOn) {
            if let indexToRemove = self.ads[indexPath.row].referenceAdIndex,
                self.ads[indexPath.row].isFavourite {
                self.ads[indexPath.row].isFavourite = false
                self.ads[indexPath.row].referenceAdIndex = nil
                self.favouriteAds.remove(at: indexToRemove)
                updateFavouriteAdReference(deletedAdIndex: indexToRemove)
            } else {
                self.ads[indexPath.row].isFavourite = true
                let savedAd = SavedAd(price: self.ads[indexPath.row].price, location: self.ads[indexPath.row].location, title: self.ads[indexPath.row].title, image: self.ads[indexPath.row].image, referenceAdIndex: indexPath.row)
                self.favouriteAds.append(savedAd)
                self.ads[indexPath.row].referenceAdIndex = self.favouriteAds.count - Constants.arrayEndIndexOffset
                self.favouriteAds[self.favouriteAds.count - Constants.arrayEndIndexOffset].image = UIImage().imageFromURL(urlString: self.ads[indexPath.row].photoUrl)
            }
            collectionView.reloadItems(at: [indexPath])
        } else {
            self.favouriteAds[indexPath.row].isFavourite = false
            if(self.ads.count > Constants.startIndex) {
                self.ads[self.favouriteAds[indexPath.row].referenceAdIndex].isFavourite = false
            }
            self.favouriteAds.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        saveAdToFavourites()
    }
    
    //MARK: Actions
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        collectionView?.reloadData()
        if(mySwitch.isOn) {
            adTitle.title = Constants.allAdsTitle
        } else {
            adTitle.title = Constants.favouriteAdTitle
        }
    }
}

//MARK: Private functions

extension AdsCollectionViewController  {
    
    private func switchConfig() {
        mySwitch.isOn = true
        mySwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: mySwitch)
        navigationItem.rightBarButtonItem = switch_display
    }
    
    private func isFavouriteAd(heart: Bool, cell: AdCell) {
        if(heart) {
            cell.favouriteIcon.image = Constants.favouriteHeart
        } else {
            cell.favouriteIcon.image = Constants.emptyHeart
        }
    }
    
    private func animateFavourites(adIndex: Int) {
        var count = Constants.startIndex
        for ads in self.favouriteAds {
            if(adIndex == ads.referenceAdIndex) {
                self.ads[adIndex].referenceAdIndex = count
                self.ads[adIndex].isFavourite = true
            }
            count += 1
        }
    }
    
    func updateFavouriteAdReference(deletedAdIndex: Int) {
        if(deletedAdIndex < self.favouriteAds.count && self.ads.count > Constants.startIndex) {
            for index in deletedAdIndex...self.favouriteAds.count - Constants.arrayEndIndexOffset {
                guard var referencePoint = self.ads[self.favouriteAds[index].referenceAdIndex].referenceAdIndex else {
                    break
                }
                referencePoint -= 1
                self.ads[self.favouriteAds[index].referenceAdIndex].referenceAdIndex = referencePoint
            }
        }
    }
    
    func saveAdToFavourites() {
        _ = NSKeyedArchiver.archiveRootObject(favouriteAds, toFile: SavedAd.ArchiveURL.path)
    }
    
    private func loadAds() -> [SavedAd]?  {
        guard let savedAd = NSKeyedUnarchiver.unarchiveObject(withFile: SavedAd.ArchiveURL.path) as? [SavedAd] else {
            return nil
        }
        return savedAd
    }
}
