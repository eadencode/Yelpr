//
//  ActivityCell.swift
//  Yelp
//
//  Created by CK on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    @IBOutlet weak var checkinImage: UIImageView!
    
    @IBOutlet weak var dateString: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    
    var businessSelected:Business? {
        didSet {
            if let business = businessSelected {
                checkinImage.isHidden = !business.checkedin
                favImage.isHidden = !business.fav
                businessImage.setImageWith(business.imageURL!)
                businessName.text = business.name
                dateString.text = business.dateString
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        favImage.isHidden = true
        checkinImage.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        checkinImage.isHidden = false
        favImage.isHidden = false
        businessName.text = ""
    }

}
