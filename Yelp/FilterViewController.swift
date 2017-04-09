//
//  FilterViewController.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var settingsTable: UITableView!
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    var sectionCounts = YelpSettings.defaultSectionCounts
    var categoryExpandedState = false
    var filterSettings: YelpSettings = YelpSettings.init()
    var filterSettingsPrevious: YelpSettings = YelpSettings.init()
    var fromList:Bool = true
    override func viewDidLoad() {
    
        super.viewDidLoad()
        settingsTable.delegate = self
        settingsTable.dataSource = self
        
        settingsTable.rowHeight = UITableViewAutomaticDimension
        settingsTable.estimatedRowHeight = 75
        settingsTable.separatorStyle = .none
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
      filterSettings = YelpSettings.shared.copied()
      settingsTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return YelpSettings.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCounts[section]!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if(section == 0 ) {
                return 0
        }
        return 35
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (YelpSettings.sections[section])
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryExpansionAction = ((indexPath.row == 3 ) && indexPath.section == 3) || (indexPath.row == 0 && indexPath.section == 3)
        let distanceExpansionAction = (indexPath.section == 1 && indexPath.row == 0 )
        let sortByExpansionAction = (indexPath.section == 2 && indexPath.row == 0)
        let sectionsToExpand  = distanceExpansionAction || sortByExpansionAction || categoryExpansionAction
        if(indexPath.section < 3  || categoryExpansionAction) {
            reCount(indexPath: indexPath)
            if(categoryExpansionAction) {
                categoryExpandedState = !categoryExpandedState
            }
            if(sectionsToExpand) {
                tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
            }
        }
        

    }

    func reCount(indexPath:IndexPath) {
        let existingCount = sectionCounts[indexPath.section]
        if(existingCount == YelpSettings.defaultSectionCounts[indexPath.section]) {
            sectionCounts[indexPath.section] = filterSettings.sectionCounts[indexPath.section]
            
        }else{
            sectionCounts[indexPath.section] = YelpSettings.defaultSectionCounts[indexPath.section]
        }
//        filterSettings.sectionCounts = sectionCounts
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let existingCount = sectionCounts[indexPath.section]
        let unexpanded:Bool = (existingCount == YelpSettings.defaultSectionCounts[indexPath.section])
        if(indexPath.section == 0 ) {
            cell = tableView.dequeueReusableCell(withIdentifier: "dealCell") as! DealCell
        }
        if(indexPath.section == 1 ) {
            
            let  distanceCell = tableView.dequeueReusableCell(withIdentifier: "distanceCell") as! DistanceCell
            distanceCell.indexPath = indexPath.row
            distanceCell.distance = filterSettings.distances[indexPath.row]
            distanceCell.delegate = self
            if(indexPath.row == 0 && !unexpanded) {
                distanceCell.selectButton()
            }
            return distanceCell
        }
        if(indexPath.section == 2) {
            let sortCell = tableView.dequeueReusableCell(withIdentifier: "sortbyCell") as! SortByCell
            sortCell.index = indexPath.row
            sortCell.sortMode = filterSettings.sortModes[indexPath.row]
            sortCell.delegate = self
            if(indexPath.row == 0 && !unexpanded) {
                sortCell.selectButton()
            }
            return sortCell
        }
        if(indexPath.section == 3) {
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
            categoryCell.index = indexPath.row
            categoryCell.delegate = self
            if(indexPath.row == 3 && !categoryExpandedState) {
               let seAllcell = tableView.dequeueReusableCell(withIdentifier: "seeallCell") as! SeeAllCell
               return seAllcell
            }
            return categoryCell
        }
        return cell
    }

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(_ sender: Any) {
        filterSettings = filterSettingsPrevious.copied()
        dismiss(animated: true, completion: nil)
//        YelpSettings.shared = filterSettings
    }
    
    @IBAction func unwind(_ sender: Any) {
        YelpSettings.shared = filterSettings.copied()
        filterSettings.offset = 0
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === searchButton else {
            print("Search button is not clicked")
            return
        }
        
        if(fromList) {
            
        }
        
        //update search settings.
        
    }
    
}




extension FilterViewController : DistanceProtocol ,SortByProtocol ,CatgoryProtocol {
    
    func reloadSectionsAsDistanceChanged(row:Int,selectedDistance:YelpDistance) {
        let distancesSorted = [selectedDistance]
        filterSettings.distances  = filterSettings.distances.filter{ $0 != selectedDistance   }
        filterSettings.distances = distancesSorted + filterSettings.distances

        let indexPath = IndexPath(row: 0, section: 1)
        reCount(indexPath: indexPath)
        self.settingsTable.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        filterSettings.selectedDistance = selectedDistance
    }
    
    func reloadSectionsAsSortByChanged(row: Int,selectedSortby:YelpSortMode) {
        let sortedBySorted = [selectedSortby]
        filterSettings.sortModes  = filterSettings.sortModes.filter{ $0 != selectedSortby   }
        filterSettings.sortModes = sortedBySorted + filterSettings.sortModes
        let indexPath = IndexPath(row: 0, section: 2)
        reCount(indexPath: indexPath)
        self.settingsTable.reloadSections(IndexSet(IndexPath(row: row, section: 2)), with: UITableViewRowAnimation.fade)
        
        filterSettings.selectedSortBy = selectedSortby
    }
    
    func categorySelected(selected:Bool ,name: String, code: String) {
        if(selected) {
            filterSettings.selectedCategories  = filterSettings.selectedCategories.filter{ $0 != code   }
            filterSettings.selectedCategories.append(code)
        }
        else{
            filterSettings.removeCategory(categoryToFilter: code)
        }
        
        CategoryCell.selectedCategories = filterSettings.selectedCategories

    }


}
