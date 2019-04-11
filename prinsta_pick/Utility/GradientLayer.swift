//
//  File.swift
//  Clinic_All
//
//  Created by KrishMac on 2/8/18.
//  Copyright © 2018 KrishMac. All rights reserved.
//

import UIKit

public class GradientLayer: UIButton {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutGradientButtonLayer()
    }
    
    // MARK: Private
    private func layoutGradientButtonLayer() {
        let gradientLayer = CAGradientLayer()
        //  gradientLayer.frame = self.view.bounds
        let color1 = UIColor(red:0.05, green:0.29, blue:0.49, alpha: 1.0).cgColor as CGColor
        let color2 = UIColor(red:0.08, green:0.23, blue:0.39, alpha: 1.0).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.50, 1.0]
        self.layer.addSublayer(gradientLayer)
 
    }
}

