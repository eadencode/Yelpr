//
//  SortByCell.swift
//  Yelp
//
//  Created by CK on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

 protocol SortByProtocol  {
    
    func reloadSectionsAsSortByChanged(row:Int,selectedSortby:YelpSortMode)
}

class SortByCell: UITableViewCell {

    @IBOutlet weak var sortByButton: UIButton!
    @IBOutlet weak var sortLabel: UILabel!
    
    var checked:Bool = false
    var delegate:SortByProtocol?
    
    var sortMode:YelpSortMode!  {
        didSet {
            sortLabel.text = sortMode.toSortby()
        }
    }
    var index:Int! {
        didSet {
            
            if(index != 0 ) {
                readyForSelection()
            }else{
                sortByButton.setImage(#imageLiteral(resourceName: "arrowdown"), for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        sortByButton.setImage(#imageLiteral(resourceName: "arrowdown"), for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onTapSelectSort(_ sender: Any) {
        let selectedSortby = sortMode
        if(checked){
            sortByButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
        }else{
            sortByButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
        }
        checked = !checked

        delegate?.reloadSectionsAsSortByChanged(row: index,selectedSortby: selectedSortby!)

    }
    

    
    override func prepareForReuse() {
        sortByButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
    }
    
    func readyForSelection() {
        sortByButton.setImage(#imageLiteral(resourceName: "unchecked"), for: UIControlState.normal)
    }
    
    func selectButton() {
        sortByButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal)
    }
    
    
    

}
