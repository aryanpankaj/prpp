//
//  PhotoBooksHomeCell.swift
//  prinsta_pick
//
//  Created by apple on 21/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class PhotoBooksHomeCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var photoAlbumPriceLabel: UILabel!
    @IBOutlet weak var photoAlbumNameLabel: UILabel!
    @IBOutlet weak var numberPagesLabel: UILabel!
    @IBOutlet weak var photoBookImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 5
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOffset = CGSize.zero
        mainView.generateOuterShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
