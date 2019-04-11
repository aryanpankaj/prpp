//
//  HomeCollectionViewCell.swift
//  ClinicAppointment
//
//  Created by Ajay Vyas on 10/9/18.
//  Copyright © 2018 XtreemSolution. All rights reserved.
//

import UIKit


class HomeCollectionViewCell: UICollectionViewCell {
    let gradient: CAGradientLayer = CAGradientLayer()
    
    @IBOutlet weak var view_main: UIView!
   
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
     @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var popUPView: UIView!
    
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        popUPView.applyGradient(colours: [color1,color2], locations: [0.0, 0.5, 1.0,0.5])
        gradient.frame = bounds
        gradient.colors = [color1,color2]
        popUPView.backgroundColor = color2
        popUPView.layer.cornerRadius = 12
        popUPView.clipsToBounds = true
//        popUPView.layer.shadowRadius = 4
//        popUPView.layer.shadowOpacity = 0.3
//        popUPView.layer.shadowColor = UIColor.gray.cgColor
//        popUPView.layer.shadowOffset = CGSize.zero
        AppHelper.delay(0.3) {
            self.popUPView.applyGradient(colours: [color1,color2], locations: [0.0, 0.5, 1.0,0.5])
        }
        
        popUPView.generateOuterShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }

}
