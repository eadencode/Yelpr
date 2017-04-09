//
//  Store.swift
//  Yelp
//
//  Created by CK on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class Store {

    static var favandcheckin:[Business]!
    
    
    class func add(business:Business,checkin:Bool,fav:Bool) {
        
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .none
        let formattedDate = dateformatter.string(from: date)
        business.checkedin = checkin
        business.fav = fav
        business.dateString = formattedDate
        if let safefavandcheckin = favandcheckin {
            let noarr = safefavandcheckin.filter{ $0.name != business.name   }
            if (!noarr.isEmpty) {
                favandcheckin = noarr + [business]
            }
            else {
                favandcheckin = [business]
            }
        }else{
            favandcheckin = [business]
        }
    }
    
    
    
}
