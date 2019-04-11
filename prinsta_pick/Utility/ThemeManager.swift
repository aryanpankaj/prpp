//
//  ThemeManager.swift
//  Panther
//
//  Created by Manish Jangid on 8/3/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import Foundation
import UIKit


class ThemeManager {
    
    static let sharedInstance = ThemeManager()
    
    fileprivate init() {}
    
    fileprivate var mBackgroundImage: UIImage?;
    
    var backgroundImage: UIImage {
        
        get {
            
            if mBackgroundImage == nil {
                
                let defaults = UserDefaults.standard;
                
                if defaults.bool(forKey: KEY_BACKGROUND_IMAGE) {
                    
                    if let image = Utilities.getImageFromDisk(name: KEY_BACKGROUND_IMAGE) {
                        
                        mBackgroundImage = image
                    } else {
                        
                        mBackgroundImage = UIImage(named: "background")
                    }
                    
                }else{
                    
                    mBackgroundImage = UIImage(named: "background")
                }
            }
            
            return mBackgroundImage!;
        }
        
        set {
            
             mBackgroundImage = UIImage(named: "background")
            mBackgroundImage = newValue
            let defaults = UserDefaults.standard;
            Utilities.saveImageToDisk(pickedimage: newValue, name: KEY_BACKGROUND_IMAGE)
            defaults.set(true, forKey: KEY_BACKGROUND_IMAGE)
        }
    }
}
