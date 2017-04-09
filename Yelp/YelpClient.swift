//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

enum YelpSortMode: Int {
    case bestMatched = 0, distance, highestRated
//    var sortModes:[String] = ["Best Match" ,"Distance" ,  "Highest Rated"]

    func toSortby() -> String {
        switch self {
        case .bestMatched:
            return "Best Match"
        case .distance:
            return "Distance"
        case .highestRated:
            return "Highest Rated"
        }
    }
}

enum YelpDistance: Double  {
    case auto = 0 , point3 = 0.3  , onemile = 1 , five = 5.0 , twenty = 20
    
//    var distances:[String] =  ["Auto" ,"0.3 miles" ,"1 mile" , "5 miles" , "20 miles"]

    func toDistance() -> String {
        switch self {
        case .auto:
            return "Auto"
        case .point3:
            return "0.3 miles"
        case .onemile:
            return "1 mile"
        case .five:
            return "5 miles"
        case .twenty:
            return "20 miles"
        }
    }
}


class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    //MARK: Shared Instance
    
    static let sharedInstance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    var limit = 20
    var offset = 0
    
    func searchWithTerm(_ filter: YelpSettings, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        limit = filter.limit
        offset = filter.offset
        return searchWithTerm(filter.searchTerm, sort: filter.selectedSortBy, categoriesArg: filter.selectedCategories,distanceArg:filter.selectedDistance, dealsArg: filter.dealOffered, completion: completion)
    }
    
    func searchWithTerm(_ termArg: String, sort: YelpSortMode?, categoriesArg: [String]?,distanceArg: YelpDistance?, dealsArg: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        
        let deals = dealsArg
        let categories = categoriesArg
        let distance = distanceArg?.rawValue
        let term = termArg
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "ll": "\(YelpSettings.centeredLatitude),\(YelpSettings.centerdLongitude)" as AnyObject]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals! as AnyObject?
        }
        if(distance != nil && distance != 0 ) {
            parameters["radius_filter"] = (distance!*1609.34) as AnyObject?
        }
        
        parameters["limit"] = limit as AnyObject?
        parameters["offset"] = offset as AnyObject?
        
        print(parameters)
        
        return self.get("search", parameters: parameters,
                        success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                            if let response = response as? [String: Any]{
                                let dictionaries = response["businesses"] as? [NSDictionary]
                                do {
                                    let jsonData = try JSONSerialization.data(withJSONObject: dictionaries ?? [:], options: .prettyPrinted)
                                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])

//                                    print(decoded)
                                } catch {
                                    print(error.localizedDescription)
                                }
                                if dictionaries != nil {
                                    completion(Business.businesses(array: dictionaries!), nil)
                                }
                            }
                        },
                        failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                            completion(nil, error)
                        })!
    }
}
