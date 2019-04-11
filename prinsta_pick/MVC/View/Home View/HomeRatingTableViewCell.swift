//
//  HomeRatingTableViewCell.swift
//  prinsta_pick
//
//  Created by apple on 09/01/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Cosmos

class HomeRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
