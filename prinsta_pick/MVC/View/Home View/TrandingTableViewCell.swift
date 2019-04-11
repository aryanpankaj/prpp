//
//  TrandingTableViewCell.swift
//  prinsta_pick
//
//  Created by apple on 08/01/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

class TrandingTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var leadingView: UIView!
    @IBOutlet weak var trandingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
