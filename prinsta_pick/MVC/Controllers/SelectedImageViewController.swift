//
//  SelectedImageViewController.swift
//  PICMOB
//
//  Created by Mohit Singh on 8/21/18.
//  Copyright © 2018 Mohit Singh. All rights reserved.
//

import UIKit
import AlamofireImage
class SelectedImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    var socialmedia:String!
    
    var selectImage:UIImage!
    var imageName : String?
    var imageUrl:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
           closeButton.backgroundColor = color1
      
        closeButton.applyGradient(colours: [color2,color1], locations: [0.3, 0.7, 1.0,0.7])
       imageView.contentMode = .scaleAspectFit
       
        imageView.backgroundColor = .black
     
        if socialmedia == "Instagram"{
            imageView.af_setImage(withURL: URL(string: imageUrl)!)
        }
        else{
                imageView.image = selectImage
  
        }
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
