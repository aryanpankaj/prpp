//
//  TrandingCollectionViewCell.swift
//  prinsta_pick
//
//  Created by apple on 08/01/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Cosmos

class TrandingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var discountButton: UIButton!
    
}
