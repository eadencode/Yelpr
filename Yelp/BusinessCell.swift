//
//  BusinessCell.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var dollars: UILabel!
    @IBOutlet weak var reviewsNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var reviewsImage: UIImageView!
    @IBOutlet weak var categories: UILabel!
    
    var business : Business! {
        didSet {
            businessName.text = business.name
            distance.text = business.distance
            dollars.text = "$$"
            address.text = business.address
            if let reviewCount = business.reviewCount {
                reviewsNumber.text = "\(reviewCount) Reviews"
            }
            if let bImageUrl = business.imageURL {
                businessImage.setImageWith(bImageUrl)
            }
            if let rImageUrl = business.ratingImageURL
            {
                reviewsImage.setImageWith(rImageUrl)
            }
            categories.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        businessImage.layer.cornerRadius = 4
        businessImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
