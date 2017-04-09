//
//  YelpSettings.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class YelpSettings: NSObject {
    static var shared: YelpSettings = { YelpSettings.init() }()

    static let sections = ["Deals" , "Distance" , "Sort By" , "Category"]
    static let defaultSectionCounts = [0:1 , 1:1 , 2:1 , 3: defaultCategoryCount]
    
    var distances:[YelpDistance] =  [YelpDistance.auto ,YelpDistance.point3 ,YelpDistance.onemile , YelpDistance.five, YelpDistance.twenty]
    var sortModes:[YelpSortMode] = [YelpSortMode.bestMatched ,YelpSortMode.distance ,  YelpSortMode.highestRated]
    var sectionCounts  = [Int:Int]()

    var offset:Int = 0
    var limit:Int = 20
    static var defaultLatitude = 37.785771
    static var defaultLongitude = -122.406165

    static var centeredLatitude = defaultLatitude
    static var centerdLongitude = defaultLongitude
    static let defaultCategoryCount = 4
    static let categories:[[String:String]] = [
        ["name" : "Asian Fusion", "code": "asianfusion"],
        ["name" : "French", "code": "french"],
        ["name" : "Indian", "code": "indpak"],
        ["name" : "Brazilian", "code": "brazilian"],
        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
        ["name" : "British", "code": "british"],
        ["name" : "Chinese", "code": "chinese"],
        ["name" : "Chicken Shop", "code": "chickenshop"],
        ["name" : "Chicken Wings", "code": "chicken_wings"],
        ["name" : "Chilean", "code": "chilean"],
        ["name" : "Mediterranean", "code": "mediterranean"],
        ["name" : "Mexican", "code": "mexican"],
]
//                                 ["name" : "American, New", "code": "newamerican"],
//                                 ["name" : "American, Traditional", "code": "tradamerican"],
//                                 ["name" : "Arabian", "code": "arabian"],
//                                 ["name" : "Argentine", "code": "argentine"],
//                                 ["name" : "Armenian", "code": "armenian"],
//                                 ["name" : "Asturian", "code": "asturian"],
//                                 ["name" : "Australian", "code": "australian"],
//                                 ["name" : "Austrian", "code": "austrian"],
//                                 ["name" : "Baguettes", "code": "baguettes"],
//                                 ["name" : "Bangladeshi", "code": "bangladeshi"],
//                                 ["name" : "Barbeque", "code": "bbq"],
//                                 ["name" : "Basque", "code": "basque"],
//                                 ["name" : "Bavarian", "code": "bavarian"],
//                                 ["name" : "Beer Garden", "code": "beergarden"],
//                                 ["name" : "Beer Hall", "code": "beerhall"],
//                                 ["name" : "Beisl", "code": "beisl"],
//                                 ["name" : "Belgian", "code": "belgian"],
//                                 ["name" : "Bistros", "code": "bistros"],
//                                 ["name" : "Black Sea", "code": "blacksea"],
//                                 ["name" : "Brasseries", "code": "brasseries"],
//                                 ["name" : "Buffets", "code": "buffets"],
//                                 ["name" : "Bulgarian", "code": "bulgarian"],
//                                 ["name" : "Burgers", "code": "burgers"],
//                                 ["name" : "Burmese", "code": "burmese"],
//                                 ["name" : "Cafes", "code": "cafes"],
//                                 ["name" : "Cafeteria", "code": "cafeteria"],
//                                 ["name" : "Cajun/Creole", "code": "cajun"],
//                                 ["name" : "Cambodian", "code": "cambodian"],
//                                 ["name" : "Canadian", "code": "New)"],
//                                 ["name" : "Canteen", "code": "canteen"],
//                                 ["name" : "Caribbean", "code": "caribbean"],
//                                 ["name" : "Catalan", "code": "catalan"],
//                                 ["name" : "Chech", "code": "chech"],
//                                 ["name" : "Cheesesteaks", "code": "cheesesteaks"],
//                                 ["name" : "Comfort Food", "code": "comfortfood"],
//                                 ["name" : "Corsican", "code": "corsican"],
//  
//                                 ["name" : "Delis", "code": "delis"],
//                                 ["name" : "Diners", "code": "diners"],
//                                 ["name" : "Dumplings", "code": "dumplings"],
//                                 ["name" : "Eastern European", "code": "eastern_european"],
//                                 ["name" : "Ethiopian", "code": "ethiopian"],
//                                 ["name" : "Fast Food", "code": "hotdogs"],
//                                 ["name" : "Filipino", "code": "filipino"],
//                                 ["name" : "Fish & Chips", "code": "fishnchips"],
//                                 ["name" : "Fondue", "code": "fondue"],
//                                 ["name" : "Food Court", "code": "food_court"],
//                                 ["name" : "Food Stands", "code": "foodstands"],
//                                 ["name" : "Indonesian", "code": "indonesian"],
//                                 ["name" : "International", "code": "international"],
//                                 ["name" : "Irish", "code": "irish"],
//                                 ["name" : "Island Pub", "code": "island_pub"],
//                                 ["name" : "Israeli", "code": "israeli"],
//                                 ["name" : "Italian", "code": "italian"],
//                                 ["name" : "Japanese", "code": "japanese"],
//                                 ["name" : "Jewish", "code": "jewish"],
//                                 ["name" : "Kebab", "code": "kebab"],
//                                 ["name" : "Korean", "code": "korean"],
//                                 ["name" : "Kosher", "code": "kosher"],
//                                 ["name" : "Kurdish", "code": "kurdish"],
//                                 ["name" : "Laos", "code": "laos"],
//                                 ["name" : "Laotian", "code": "laotian"],
//                                 ["name" : "Latin American", "code": "latin"],
//                                 ["name" : "Live/Raw Food", "code": "raw_food"],
//                                 ["name" : "Lyonnais", "code": "lyonnais"],
//                                 ["name" : "Malaysian", "code": "malaysian"],
//                                 ["name" : "Meatballs", "code": "meatballs"],
//                                 ["name" : "Middle Eastern", "code": "mideastern"],
//                                 ["name" : "Milk Bars", "code": "milkbars"],
//                                 ["name" : "Modern Australian", "code": "modern_australian"],
//                                 ["name" : "Modern European", "code": "modern_european"],
//                                 ["name" : "Mongolian", "code": "mongolian"],
//                                 ["name" : "Moroccan", "code": "moroccan"],
//                                 ["name" : "New Zealand", "code": "newzealand"],
//                                 ["name" : "Night Food", "code": "nightfood"],
//                                 ["name" : "Norcinerie", "code": "norcinerie"],
//                                 ["name" : "Open Sandwiches", "code": "opensandwiches"],
//                                 ["name" : "Oriental", "code": "oriental"],
//                                 ["name" : "Pakistani", "code": "pakistani"],
//                                 ["name" : "Parent Cafes", "code": "eltern_cafes"],
//                                 ["name" : "Parma", "code": "parma"],
//                                 ["name" : "Persian/Iranian", "code": "persian"],
//                                 ["name" : "Peruvian", "code": "peruvian"],
//                                 ["name" : "Pita", "code": "pita"],
//                                 ["name" : "Pizza", "code": "pizza"],
//                                 ["name" : "Polish", "code": "polish"],
//                                 ["name" : "Portuguese", "code": "portuguese"],
//                                 ["name" : "Potatoes", "code": "potatoes"],
//                                 ["name" : "Poutineries", "code": "poutineries"],
//                                 ["name" : "Pub Food", "code": "pubfood"],
//                                 ["name" : "Rice", "code": "riceshop"],
//                                 ["name" : "Romanian", "code": "romanian"],
//                                 ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
//                                 ["name" : "Rumanian", "code": "rumanian"],
//                                 ["name" : "Russian", "code": "russian"],
//                                 ["name" : "Salad", "code": "salad"],
//                                 ["name" : "Sandwiches", "code": "sandwiches"],
//                                 ["name" : "Scandinavian", "code": "scandinavian"],
//                                 ["name" : "Scottish", "code": "scottish"],
//                                 ["name" : "Seafood", "code": "seafood"],
//                                 ["name" : "Serbo Croatian", "code": "serbocroatian"],
//                                 ["name" : "Signature Cuisine", "code": "signature_cuisine"],
//                                 ["name" : "Singaporean", "code": "singaporean"],
//                                 ["name" : "Slovakian", "code": "slovakian"],
//                                 ["name" : "Soul Food", "code": "soulfood"],
//                                 ["name" : "Soup", "code": "soup"],
//                                 ["name" : "Southern", "code": "southern"],
//                                 ["name" : "Spanish", "code": "spanish"],
//                                 ["name" : "Steakhouses", "code": "steak"],
//                                 ["name" : "Sushi Bars", "code": "sushi"],
//                                 ["name" : "Swabian", "code": "swabian"],
//                                 ["name" : "Swedish", "code": "swedish"],
//                                 ["name" : "Swiss Food", "code": "swissfood"],
//                                 ["name" : "Tabernas", "code": "tabernas"],
//                                 ["name" : "Taiwanese", "code": "taiwanese"],
//                                 ["name" : "Tapas Bars", "code": "tapas"],
//                                 ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
//                                 ["name" : "Tex-Mex", "code": "tex-mex"],
//                                 ["name" : "Thai", "code": "thai"],
//                                 ["name" : "Traditional Norwegian", "code": "norwegian"],
//                                 ["name" : "Traditional Swedish", "code": "traditional_swedish"],
//                                 ["name" : "Trattorie", "code": "trattorie"],
//                                 ["name" : "Turkish", "code": "turkish"],
//                                 ["name" : "Ukrainian", "code": "ukrainian"],
//                                 ["name" : "Uzbek", "code": "uzbek"],
//                                 ["name" : "Vegan", "code": "vegan"],
//                                 ["name" : "Vegetarian", "code": "vegetarian"],
//                                 ["name" : "Venison", "code": "venison"],
//                                 ["name" : "Vietnamese", "code": "vietnamese"],
//                                 ["name" : "Wok", "code": "wok"],
//                                 ["name" : "Wraps", "code": "wraps"],
//                                 ["name" : "Yugoslav", "code": "yugoslav"]]
    
    
    
    var dealOffered:Bool = true
    var selectedDistance:YelpDistance = YelpDistance.auto
    var selectedCategories:[String] = []
    var selectedSortBy:YelpSortMode = YelpSortMode.bestMatched
    var searchTerm:String! = ""
    
    func fullCounts() {
        sectionCounts = [0:1 , 1:distances.count , 2:sortModes.count , 3: YelpSettings.categories.count]
    }
    
    func defaultCounts() {
        sectionCounts = YelpSettings.defaultSectionCounts
    }
    
    override init() {
         sectionCounts = [0:1 , 1:distances.count , 2:sortModes.count , 3: YelpSettings.categories.count]
    }
    
    func removeCategory(categoryToFilter:String) {
        selectedCategories  = selectedCategories.filter{ $0 != categoryToFilter    }
    }
    
    func firstPage() {
        offset = 0
        limit = 20
    }

    func nextPage() {
        offset = offset + limit
        limit = 20
    }

    
    func printCurrentFilters() {
        print("Deals : \(dealOffered)")
        print("Distance : \(selectedDistance)")
        print("Sort By \(selectedSortBy)")
        print("Categories \(selectedCategories)")
        print("Search Term \(searchTerm)")
    }
    
    func copied() -> YelpSettings {
        let newYelpSettings = YelpSettings.init()
        newYelpSettings.dealOffered = dealOffered
        newYelpSettings.selectedDistance = selectedDistance
        newYelpSettings.selectedCategories = selectedCategories
        newYelpSettings.selectedSortBy = selectedSortBy
        newYelpSettings.searchTerm = searchTerm
        newYelpSettings.distances = distances
        newYelpSettings.sortModes = sortModes
        newYelpSettings.sectionCounts = sectionCounts
        newYelpSettings.offset = offset
        newYelpSettings.limit  = limit
        return newYelpSettings
    }
    
    
    class func resetLocation() {
        centerdLongitude = defaultLongitude
        centeredLatitude = defaultLatitude
    }
    func startLocationTracking() {
        
    }
    
}
