//
//  BusinessDetailController.swift
//  Yelp
//
//  Created by CK on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit
class BusinessDetailController: UIViewController {

    @IBOutlet weak var mainBusinessImageView: UIImageView!
    @IBOutlet weak var businessCard: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mainBusinessName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var checkinButton: UIButton!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var dollarsLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingsStarImage: UIImageView!

    var business:Business!
    var fav:Bool = false
    var chk:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessCard.backgroundColor = UIColor.white
        businessCard.alpha = 3;
        businessCard.layer.borderColor = UIColor.red.cgColor
        businessCard.layer.borderWidth = 1
        favButton.layer.cornerRadius = 19
        checkinButton.layer.cornerRadius = 19
        
    }
    
    @IBAction func favList(_ sender: Any) {
        fav = true
        Store.add(business: business,checkin: chk  , fav: fav)
    }
    
    @IBAction func checkInList(_ sender: Any) {
        chk  = true
        Store.add(business: business,checkin: chk  , fav: fav)
    }
    
    func reloadMap() {
        var takeAroundCoordinates:CLLocationCoordinate2D?
        let marker = MapMarker.init(business: business, coordinates: CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!))
    
        takeAroundCoordinates = CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!)

        self.mapView.addAnnotation(marker)
        
        let clLocationCordinate = takeAroundCoordinates//CLLocationCoordinate2D(latitude: YelpSettings.centeredLatitude, longitude: YelpSettings.centerdLongitude)
        
        self.mapView.showsUserLocation = true
        let zoomLevel:Int = 15
        let span = MKCoordinateSpanMake(0, 360 / pow(2, Double(zoomLevel)) * Double(mapView.frame.size.width) / 256)
        mapView.setRegion(MKCoordinateRegionMake(clLocationCordinate!, span), animated: true)
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        mainBusinessName.text = business.name
        milesLabel.text = business.distance
        dollarsLabel.text = "$$"
        fullAddress.text = business.address
        if let reviewCount = business.reviewCount {
            numberOfReviewsLabel.text = "\(reviewCount) Reviews"
        }
        if let rImageUrl = business.ratingImageURL
        {
            ratingsStarImage.setImageWith(rImageUrl)
        }
        categoriesLabel.text = business.categories
        mainBusinessImageView.setImageWith(business.imageURL!)
        fullAddress.text = business.fullAddress
        reloadMap()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
