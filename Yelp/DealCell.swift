//
//  DealCell.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class DealCell: UITableViewCell {

    @IBOutlet weak var dealSwitch: UISwitch!
    
    
    //Comes from default settings.
    var dealOn:Bool!  {
        didSet {
            dealSwitch.isOn = dealOn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        let pattern = UIColor(patternImage: #imageLiteral(resourceName: "pattern"))
        dealSwitch.thumbTintColor = pattern
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dealChanged(_ sender: UISwitch) {
        YelpSettings.shared.dealOffered  = sender.isOn
    }

    override func prepareForReuse() {
        dealSwitch.isOn = true
    }
}
