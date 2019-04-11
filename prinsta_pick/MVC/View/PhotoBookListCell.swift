//
//  PhotoBookListCell.swift
//  prinsta_pick
//
//  Created by apple on 30/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit
import Cosmos

class PhotoBookListCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var startingLabel: UILabel!
    @IBOutlet weak var numberPageLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var dataView: UIView!
      @IBOutlet weak var databackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImageView.layer.cornerRadius = 15.0
        bookImageView.clipsToBounds = true
        bookImageView.backgroundColor = .white
        dataView.backgroundColor = .clear
        databackView.layer.cornerRadius = 10.0
        databackView.clipsToBounds = true
      
        
        bookImageView.layer.shadowRadius = 9
        bookImageView.layer.shadowOpacity = 0.3
        bookImageView.layer.shadowColor = UIColor.lightGray.cgColor
        bookImageView.layer.shadowOffset = CGSize.zero
        bookImageView.generateOuterShadow()
        dataView.layer.cornerRadius = 10
        dataView.clipsToBounds = true
  priceLabel.textColor = CustomColor.darkBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
