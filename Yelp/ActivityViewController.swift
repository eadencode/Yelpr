//
//  ActivityViewController.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var activityView: UITableView!

    var businesses:[Business]?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.delegate  = self
        activityView.dataSource = self
        activityView.rowHeight = UITableViewAutomaticDimension
        activityView.estimatedRowHeight = 100
        // Do any additional setup after loading the view.
        businesses = Store.favandcheckin
        
    }

    override func viewDidAppear(_ animated: Bool) {
        businesses = Store.favandcheckin
        activityView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as! ActivityCell
        if(businesses != nil ) {
            if let businessSelected = businesses?[indexPath.row] {
                cell.businessSelected = businessSelected
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numOfRows = businesses?.count {
            return numOfRows
        }
        return  0
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
