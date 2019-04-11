//
//  ViewController.swift
//  prinsta_pick
//
//  Created by Pankaj Jangid on 29/10/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var horizontalView: PagedHorizontalView!
    let items: [(image: String, heading: String,description:String,color:UIColor,bgImage : String)] = [
        ("wel", "Welcome to Prinstapick", "Now you can create a wide range of variety of photos and bring them on Any Thing",UIColor(red: 246.0/255.0, green: 139.0/255.0, blue: 80.0/255.0, alpha: 1.0), bgImage: "iPhone Xs – 9"),
         ("wel1", "Welcome to Prinstapick", "Now you can create a wide range of variety of photos and bring them on Any Thing",UIColor(red: 246.0/255.0, green: 139.0/255.0, blue: 80.0/255.0, alpha: 1.0), bgImage: "iPhone Xs – 10"),
         ("wel2", "Welcome to Prinstapick", "Now you can create a wide range of variety of photos and bring them on Any Thing",UIColor(red: 246.0/255.0, green: 139.0/255.0, blue: 80.0/255.0, alpha: 1.0), bgImage: "iPhone Xs – 11"),
         ("wel3", "Welcome to Prinstapick", "Now you can create a wide range of variety of photos and bring them on Any Thing",UIColor(red: 246.0/255.0, green: 139.0/255.0, blue: 80.0/255.0, alpha: 1.0), bgImage: "iPhone Xs – 12")]
    let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     horizontalView.collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCollectionViewCell")
     
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        leftButton.isHidden = true
        horizontalView.backgroundColor = .clear
        self.skipButton.setTitleColor(.white, for: .normal)
        skipButton.layer.cornerRadius = skipButton.frame.height/2
        skipButton.clipsToBounds = true
        horizontalView.pageControl?.currentPageIndicatorTintColor = color2
        self.skipButton.applyGradient(colours: [color1,color2], locations: [0.0, 0.5, 1.0,0.5])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppHelper.delay(0.2) {
        
        //      self.backgroundView.applyGradient(colours: [color1,color2])
           
            self.skipButton.applyGradient(colours: [self.color1,self.color2], locations: [0.0, 0.5, 1.0,0.5])
        }
    }
    
//    func rotateImage() {
//        
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
//            //self.animated_image_view.transform = CGAffineTransformRotate(self.animated_image_view.transform, CGFloat(M_PI_2))
//           
//        }) { (finished) in
//            self.rotateImage()
//        }
//        
//    }
    @IBAction func skipButtonTapped(_ sender: Any) {
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = stry.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func btn_gotIt_tap(_ sender : UIButton) {
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = stry.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc1, animated: true)
    }

}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let item = items[(indexPath as NSIndexPath).item]
      
        cell.view_main.backgroundColor = .clear//item.color
        
        cell.bgImageView.image = UIImage(named : item.bgImage)
        cell.lbl_title.text = item.heading
        cell.lbl_description.text = item.description
        cell.lbl_description.textColor = .white
        cell.lbl_title.textColor = .white
        if indexPath.row == 2 {
            cell.centerConstraint.constant = 100
        } else {
            cell.centerConstraint.constant = 0
        }
        
        AppHelper.delay(0.2) {
            cell.view_main.applyGradient(colours: [self.color1,self.color2], locations: [0.6, 0.5, 1.0,0.7])
        }
        return cell
    }
    
 

    
}
