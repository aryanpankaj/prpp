//
//  PrintPackageViewController.swift
//  prinsta_pick
//
//  Created by apple on 22/03/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
public protocol SelectPackageDelegate {
    func selectedPackageDelegate(pkge_name : String, discount_per: String, print_price : String)
    
}
class PrintPackageViewController: UIViewController {

    @IBOutlet weak var btn_select_pack_individual: UIButton!
     @IBOutlet weak var btn_select_pack_25pack: UIButton!
     @IBOutlet weak var btn_select_pack_75pack: UIButton!
     @IBOutlet weak var btn_select_pack_100pack: UIButton!
    
    @IBOutlet weak var btn_discount_10: UIButton!
     @IBOutlet weak var btn_discount_20: UIButton!
     @IBOutlet weak var btn_discount_25: UIButton!
    
    var selectedpkgDelegate  : SelectPackageDelegate?
    
    let pkge_arr = ["0","25","50","100"]
    let persentage_arr = ["0","10","20","25"]
    let price_arr = ["20","10","8","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.btn_select_pack_individual.layer.cornerRadius = self.btn_select_pack_individual.frame.height/2
        self.btn_select_pack_individual.borderColor = .gray
        self.btn_select_pack_individual.borderWidth = 1.0
        self.btn_select_pack_individual.backgroundColor = .white
        self.btn_select_pack_individual.setTitleColor(.gray, for: .normal)
        self.btn_select_pack_individual.clipsToBounds = true
        
        self.btn_select_pack_25pack.layer.cornerRadius = self.btn_select_pack_25pack.frame.height/2
        self.btn_select_pack_25pack.borderColor = CustomColor.customGreenColor
        self.btn_select_pack_25pack.borderWidth = 1.0
        self.btn_select_pack_25pack.backgroundColor = CustomColor.customGreenColor
        self.btn_select_pack_25pack.setTitleColor(.white, for: .normal)
        self.btn_select_pack_25pack.clipsToBounds = true
        
        self.btn_select_pack_75pack.layer.cornerRadius = self.btn_select_pack_75pack.frame.height/2
        self.btn_select_pack_75pack.borderColor = CustomColor.appThemeColor
        self.btn_select_pack_75pack.borderWidth = 1.0
        self.btn_select_pack_75pack.backgroundColor = CustomColor.appThemeColor
        self.btn_select_pack_75pack.setTitleColor(.white, for: .normal)
        self.btn_select_pack_75pack.clipsToBounds = true
        
        self.btn_select_pack_100pack.layer.cornerRadius = self.btn_select_pack_100pack.frame.height/2
        self.btn_select_pack_100pack.borderColor = UIColor(red: 122.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)//CustomColor.appThemeColor
        self.btn_select_pack_100pack.borderWidth = 1.0
        self.btn_select_pack_100pack.backgroundColor = UIColor(red: 122.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.btn_select_pack_100pack.setTitleColor(.white, for: .normal)
        self.btn_select_pack_100pack.clipsToBounds = true
    }
    
    @IBAction func tap_btn_select(_ sender: Any) {
    
        
        if (sender as AnyObject).tag == 0 {
           
        } else if (sender as AnyObject).tag == 1 {
            
        } else if (sender as AnyObject).tag == 2 {
            
        } else if (sender as AnyObject).tag == 3 {
            
        }
        selectedpkgDelegate?.selectedPackageDelegate(pkge_name: pkge_arr[(sender as AnyObject).tag], discount_per: persentage_arr[(sender as AnyObject).tag] , print_price : price_arr[(sender as AnyObject).tag])
        self.dismiss(animated: true) {
            
        }
    }
    
    
    @IBAction func btn_tap_discount(_ sender: Any) {
        
    }
    
    @IBAction func btn_tap_cross(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
