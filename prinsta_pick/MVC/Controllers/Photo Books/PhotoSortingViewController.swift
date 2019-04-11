//
//  PhotoSortingViewController.swift
//  prinsta_pick
//
//  Created by apple on 09/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

protocol GotToOtherScreenDelegate {
    func goTootherScreen(sortType : String)
    
}

class PhotoSortingViewController: UIViewController {

    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var btn_chronological_order: UIButton!
    @IBOutlet weak var btn_selection_order: UIButton!
    var category_type = ""
    var category_id = ""
    var isCheckForOrderScreen = false
    var customDelegateForScreen : GotToOtherScreenDelegate?
    var selectArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
btn_chronological_order.setTitle("Chronological Order", for: .normal)
        btn_selection_order.setTitle("Selection Order", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppHelper.delay(0.3) {
            self.setGradient()
        }
    }
    
    func setGradient() {
        //        233 172 110
        //        242 122 132
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 0.7)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 0.7)
        
        let color3:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        
        self.view.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        self.btn_selection_order.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
        
        
    }
    
    @IBAction func tap_btn_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap_btn_selection_order(_ sender: Any) {
        self.dismiss(animated: true) {
            self.customDelegateForScreen?.goTootherScreen(sortType: "Selection Order")
        }
       
    }
    
    @IBAction func tap_btn_chronological_order(_ sender: Any) {
        
      self.dismiss(animated: false) {
        self.customDelegateForScreen?.goTootherScreen(sortType: "Chronological Order")
     }

       
    }
  

}
