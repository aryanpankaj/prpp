//
//  HomeScrollTableViewCell.swift
//  prinsta_pick
//
//  Created by apple on 16/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class HomeScrollTableViewCell: UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var sliderImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
