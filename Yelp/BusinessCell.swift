//
//  BusinessCell.swift
//  Yelp
//
//  Created by Chavane Minto on 11/29/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbView: UIImageView!
    
    @IBOutlet weak var ratingsView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    //create a outlet for your business class
    var Business: Business! {
        didSet {
            thumbView.setImageWith(Business.imageURL!)
            ratingsView.setImageWith(Business.ratingImageURL!)
            nameLabel.text = Business.name!;
            addressLabel.text = Business.address!;
            reviewsLabel.text = "\(Business.reviewCount!) Reviews";
            distanceLabel.text = Business.distance!;
            categoriesLabel.text = Business.categories!;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbView.layer.cornerRadius = 5;
        thumbView.clipsToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
