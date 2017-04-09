//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import ICSPullToRefresh
import MBProgressHUD
import MapKit

class BusinessesViewController: UIViewController,UITableViewDataSource , UITableViewDelegate  {
    
    var businesses: [Business]!
    var locationManager:CLLocationManager!

    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var businessTable: UITableView!
    var searchBar: UISearchBar!
    
    @IBOutlet weak var mapBarButton: UIBarButtonItem!
    var selectedIndex:Int?
    
    //MARK : View Controller LifeCycles.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" Business view Controller \(self) has address: \(Unmanaged.passRetained(self).toOpaque())")
        businessTable.rowHeight = UITableViewAutomaticDimension
        businessTable.estimatedRowHeight = 100
        businessTable.delegate = self
        businessTable.dataSource = self
        
        businessTable.addPullToRefreshHandler {
            self.refreshEnded(list:true)
        }
        
        businessTable.addInfiniteScrollingWithHandler {
            self.infiniteScroll(list: true)
        }
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        Styles.styleNav(controller: self)

        navigationItem.titleView = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        determineMyCurrentLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        YelpSettings.shared.printCurrentFilters()
        doSearch(append:false,showProgress: true)
    }
    
    // MARK: Perform the Search.
    
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
                
                self.businessTable.reloadData()
            }
            if(showProgress) {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        )
    }
    
    
    
    //MARK : Refresh Controls - Pull to refresh and Infinite Scroll
    
    func refreshEnded(list:Bool) {
        DispatchQueue.global(qos: .userInitiated).async{
            sleep(1)
            YelpSettings.shared.firstPage()
//            self.businesses = [Business]()
            self.doSearch(append:false,showProgress: false)
            DispatchQueue.main.async { [unowned self] in
                if(list){
                    self.businessTable.pullToRefreshView?.stopAnimating()
                }
            }
        }
    }
    
    func infiniteScroll(list:Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            DispatchQueue.main.async { [unowned self] in
                YelpSettings.shared.nextPage()
                self.doSearch(append:true,showProgress: false)
                if(list){
                    self.businessTable.infiniteScrollingView?.stopAnimating()
                }
            }
        }
    }
    
    
    //MARK : TableView Callbacks
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (businesses?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let businessCell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        businessCell.business = businesses?[indexPath.row]
        businessCell.accessoryType   = .none
        return businessCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
     // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let barButton = sender as? UIBarButtonItem
        if(!businesses.isEmpty && barButton == mapBarButton) {
            let mapNavController = segue.destination as! UINavigationController
            let mapViewController = mapNavController.viewControllers[0] as! MapViewController
            mapViewController.businesses = self.businesses
        }else {
            if(!businesses.isEmpty && !(barButton == filterButton)) {
                let detailController = segue.destination as! BusinessDetailController
                let selectedCell = sender as! BusinessCell
                let indexPath = businessTable.indexPath(for: selectedCell)
                detailController.business = businesses[(indexPath?.row)!]

            }
        }
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


//MARK : Location delegate

extension BusinessesViewController : CLLocationManagerDelegate  {
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        YelpSettings.centeredLatitude = userLocation.coordinate.latitude
        YelpSettings.centerdLongitude = userLocation.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        YelpSettings.resetLocation()
    }
    
}

// MARK : Search Bar Delegates

extension BusinessesViewController: UISearchBarDelegate {
    
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
