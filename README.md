# FavouriteAds

This is a simple app to display ads imported from a json script through the use of URLSession. Once this data has been 
received, it is displayed in a collection view where a user may select which ads to save for later. I used the pod SDWebImage
to display and cached images. I used NSCoding for local storage and saves ads for viewing offline at a later date.

## Improvements

I beleive I could have used key value coding rather that using arrays as this won't scale with more random input of arrays and some of my efficiency could have been improved.

## How to Use

To add a favourite, just click on the ad you like and it is saved in your favourites tab. Then hit the switch and this should
take you to your favourites. To remove a favourite, simply click on the favourite you want to remove and it will be removed 
on both views.

## Author

* **George Bonnici-Carter**

