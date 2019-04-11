//
//  SelectBookColorViewController.swift
//  prinsta_pick
//
//  Created by apple on 09/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

class SelectBookColorViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView_selectBook: UICollectionView!
//    @IBOutlet weak var btn_confirm: UIButton!
//    @IBOutlet weak var view_bottom: UIView!
    
    let array_book_color : [String] = ["Group 733","Group 733","Group 733","Group 733","Group 733"]
    var category_type = ""
    var category_id = ""
    var sortType = ""
    
    var book_type : String?
    var book_price : String?
    
    var selectArray = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
  self.setGradient()
       
        collectionView_selectBook.delegate = self
        collectionView_selectBook.dataSource = self
        self.navTitle.text = "Select Book Color"
    
        
    
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
        
        self.view.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
       
        
        
    }
  
  
    
    //MARK : COllectionView datasource and delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array_book_color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "organiseCollectionViewCell", for: indexPath) as! OrganiseCollectionViewCell
    cell.selectedImageView.image = nil
                cell.selectedImageView.backgroundColor = .clear
        cell.selectedImageView.image  = UIImage(named:array_book_color[indexPath.row])
        if indexPath.row/2 == 0 {
             cell.bgImageView.backgroundColor = UIColor(red: 252.0/255.0, green: 235.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        } else {
             cell.bgImageView.backgroundColor = UIColor(red: 14.0/255.0, green: 239.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        }
    
        return cell
    }
    
    //252,235,239
    //14,239,210
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width/2 ) - 30 , height: (UIScreen.main.bounds.width/2 ) - 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "bookCoverViewController") as! BookCoverViewController
        
        vc.category_type = category_type
        vc.category_id = category_id
        vc.selectedAlbumPhoto = UIImage(named : array_book_color[indexPath.row])!
        vc.book_color_id = "12" //index color id
        vc.selectArray = self.selectArray
        vc.book_type = book_type
        vc.book_price = book_price
        vc.sortType = sortType
        self.navigationController?.pushViewController(vc, animated: true)
                
    }

}
