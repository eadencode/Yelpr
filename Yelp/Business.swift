//
//  Business.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let distanceMetersVal : Double?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    let latitude:Double?
    let longitude:Double?
    let fullAddress:String?
    var fav:Bool = false
    var checkedin:Bool = false
    var dateString:String?
    var closed:Bool?
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        var lat = 37.785771
        var lon = -122.406165
        var fullAddress = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
            let coordinates = location!["coordinate"] as? NSDictionary
            if(coordinates != nil) {
                lat = coordinates!["latitude"] as! Double
                lon = coordinates!["longitude"] as! Double
            }
            
            if let displayAddress = location!["display_address"]  {
                let arr = displayAddress as! NSArray
                for lineOf in arr {
                    fullAddress = fullAddress + (lineOf as! String)
                }
            }
        }
        self.address = address
        self.latitude = lat
        self.longitude = lon
        self.fullAddress = fullAddress
        self.closed = dictionary["is_closed"] as? Bool
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distanceMetersVal = distanceMeters?.doubleValue
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
            distanceMetersVal = 5
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    

    class func searchWithFilter(_ filter: YelpSettings, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
      _ = YelpClient.sharedInstance.searchWithTerm(filter, completion: completion)
    }
}
