//
//  CategoryCell.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit


protocol CatgoryProtocol  {
    
    func categorySelected(selected:Bool , name:String , code:String)
}


class CategoryCell: UITableViewCell {

    @IBOutlet weak var categorySelected: UISwitch!
    @IBOutlet weak var category: UILabel!
    
    var categoryCode:String?
    var delegate: CatgoryProtocol?
    static var selectedCategories:[String]?
    var index:Int! {
        didSet {
            let indexedCategory = YelpSettings.categories[index]
            category.text = indexedCategory["name"]
            categoryCode = indexedCategory["code"]
            if let categories = CategoryCell.selectedCategories {
            if(categories.contains(categoryCode!)) {
                categorySelected.isOn = true
            }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        categorySelected.isOn = false
    }

    @IBAction func valueChanged(_ sender: UISwitch) {
        delegate?.categorySelected(selected:sender.isOn ,name: category.text!, code: categoryCode!)
    }
}
