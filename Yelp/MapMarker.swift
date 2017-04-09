//
//  MapMarker.swift
//  Yelp
//
//  Created by CK on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation
import MapKit

class MapMarker:NSObject,MKAnnotation {
    
    var business:Business
    var coordinate: CLLocationCoordinate2D
    init(business:Business, coordinates : CLLocationCoordinate2D ) {
        self.business = business
        self.coordinate = coordinates
        //CLLocationCoordinate2D(latitude: business.latitude!,longitude: business.longitude!)
        
    }
    
    
    
    

    
}
