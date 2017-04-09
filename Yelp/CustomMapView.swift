//
//  CustomMapView.swift
//  Yelp
//
//  Created by CK on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation

import MapKit



class CustomMapView: MKAnnotationView
{
    
    let selectedLabel:UILabel = UILabel.init(frame:CGRect(x: 0, y: 0, width: 200, height: 25))
    var markedBusiness : Business?
    var marker:MapMarker?
    init(annotation: MapMarker?, reuseIdentifier: String? , business:Business ,add:Bool) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        marker = annotation
        markedBusiness = business
        if(add) {
            addSubViewsForMarker(annotationView: self,marker: marker!)
        }
    }
    convenience init(annotation: MapMarker?, reuseIdentifier: String? , business:Business ) {
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier, business: business, add: false)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if(selected) {
            addSubViewsForMarker(annotationView: self,marker: marker!)
        }else {
            self.removeFromSuperview()
        }
    }
    override func didAddSubview(_ subview: UIView) {
        if isSelected {
            setNeedsLayout()
        }
    }
    
  
    
    func addSubViewsForMarker(annotationView:MKAnnotationView , marker :MapMarker) {
        
        let imgView = UIImageView()
        imgView.setImageWith(marker.business.imageURL!)
        imgView.backgroundColor = UIColor.clear
        imgView.contentMode = .scaleToFill

        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .center;
        lbl.textColor = UIColor.red
        lbl.backgroundColor = UIColor.clear
        lbl.text =  marker.business.name
        lbl.backgroundColor = UIColor.white
        lbl.layer.borderColor = UIColor.red.cgColor
        lbl.layer.borderWidth = 1
        lbl.textColor = UIColor.red
        lbl.layer.cornerRadius = 3
        
        imgView.frame = CGRect(x:0, y:0, width: 150, height:50)
        imgView.layer.borderColor = UIColor.red.cgColor
        imgView.layer.borderWidth = 1
        lbl.frame = CGRect(x:55, y:0, width: 150, height:50)
        annotationView.addSubview(imgView)
        annotationView.addSubview(lbl)
//        annotationView.addSubview(newView)
    }

}
