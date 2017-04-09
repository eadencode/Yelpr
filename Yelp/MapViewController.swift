//
//  MapViewController.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit


import MBProgressHUD

class MapViewController: UIViewController ,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var listBarButton: UIBarButtonItem!
    var businesses: [Business]!
    var searchBar: UISearchBar!
    
    var businessName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        // Do any additional setup after loading the view.
        Styles.styleNav(controller: self)
        navigationItem.titleView = searchBar
        self.mapView.delegate = self
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.reloadInputViews()
        doSearch(append: false, showProgress: true)
        reloadMap()
    }
    
    
    // MARK : Perform the search
    func doSearch(append:Bool, showProgress:Bool) {
        if(showProgress) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        Business.searchWithFilter(YelpSettings.shared, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let newbusinesses = businesses  {
                if(append){
                    self.businesses = self.businesses! + newbusinesses
                }else {
                    self.businesses = newbusinesses
                }
                
                self.reloadMap()
            }
            if(showProgress) {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        )
    }
    
    //MARK : Reload the map.
    
    func reloadMap() {
        var takeAroundCoordinates:CLLocationCoordinate2D?
        var doOnce:Bool = false
        
        for business in businesses        {
            let marker = MapMarker.init(business: business, coordinates: CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!))
            if(!doOnce){
                takeAroundCoordinates = CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!)
                businessName = business.name
            }
            doOnce = true
            self.mapView.addAnnotation(marker)
        }
        let clLocationCordinate = takeAroundCoordinates
        // TODO: Use below if user location is available
        
        // CLLocationCoordinate2D(latitude: YelpSettings.centeredLatitude, longitude: YelpSettings.centerdLongitude)
        // self.mapView.showsUserLocation = false
        let zoomLevel:Int = 14
        let span = MKCoordinateSpanMake(0, 360 / pow(2, Double(zoomLevel)) * Double(mapView.frame.size.width) / 256)
        
        mapView.setRegion(MKCoordinateRegionMake(clLocationCordinate!, span), animated: true)
        

    }

    @IBAction func navigateToList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinIdentifier = "Pin"
        if(annotation is MKUserLocation)
        {
            return nil;
        }
        let marker = annotation as! MapMarker
       
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier)
        
        if annotationView == nil{
            if(marker.business.name == businessName ) {
                annotationView = CustomMapView(annotation: marker, reuseIdentifier: pinIdentifier,business:marker.business,add:true)
                annotationView?.setSelected(true, animated: true)

            }else {
                 annotationView = CustomMapView(annotation: marker, reuseIdentifier: pinIdentifier,business:marker.business,add:false)
            }
        }else{
            annotationView?.annotation = annotation
        }
//        addSubViewsForMarker(annotationView: annotationView!, marker: marker)
        annotationView?.image = #imageLiteral(resourceName: "pinimage")
        annotationView?.annotation = marker
//        annotationView?.canShowCallout = true
        annotationView?.isEnabled = true
        return annotationView
    }

}
// SearchBar methods
extension MapViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        YelpSettings.shared.searchTerm = ""
        
        doSearch(append: false,showProgress: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        YelpSettings.shared.searchTerm = searchBar.text
        searchBar.resignFirstResponder()
        
        doSearch(append: false,showProgress: true)
    }
}
