//
//  DistanceCell.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit


protocol DistanceProtocol  {
    func reloadSectionsAsDistanceChanged(row:Int,selectedDistance:YelpDistance)
}

class DistanceCell: UITableViewCell {

    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    var checked:Bool = false
    
    var distance:YelpDistance!  {
        didSet {
            distanceLabel.text = distance.toDistance()
        }
    }
    
    var indexPath:Int!{
        didSet {
            if(indexPath != 0 ) {
                readyForSelection()
            }else{
                distanceButton.setImage(#imageLiteral(resourceName: "arrowdown"), for: UIControlState.normal)
            }
        }
    }
    var delegate:DistanceProtocol?
    
    var selectedDistance  : Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        distanceButton.setImage(#imageLiteral(resourceName: "arrowdown"), for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func tapDistance(_ sender: Any) {
        let selectedDistance = distance
        if(checked){
            distanceButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
        }else{
            distanceButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
        }
        checked = !checked
        delegate?.reloadSectionsAsDistanceChanged(row: indexPath,selectedDistance: selectedDistance!)
//        YelpSettings.shared.selectedDistance = YelpSettings.distanceNumbers[selectedDistance]!
    }
    
    func readyForSelection() {
        distanceButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
    }
    
    override func prepareForReuse() {
        distanceButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
    }
    
    func selectButton() {
         distanceButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
    }
    
   
}
