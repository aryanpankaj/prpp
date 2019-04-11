//
//  SubCategoryTableViewCell.swift
//  prinsta_pick
//
//  Created by apple on 10/01/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Cosmos
class SubCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var databackView: UIView!
    @IBOutlet weak var CategoryNameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
