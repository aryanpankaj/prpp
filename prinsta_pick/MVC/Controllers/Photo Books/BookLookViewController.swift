//
//  BookLookViewController.swift
//  prinsta_pick
//
//  Created by apple on 02/03/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Photos
import CoreData


class BookLookViewController: BaseViewController,EditableImageDelegaate {
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var selectArray  = [String]()
    var selectedIndex = [Int]()
    var photo_cover_image_url : String?
    var cover_image : UIImage?
    
    //Category Type
    var category_type = ""
    var category_id = ""
    var sortType = ""
    var book_type : String?
    var book_price : String?
    var book_name : String?
    var book_name_font : String?
    var book_name_font_color : String?
    var book_color_id : String?
    var isChangeImage : Bool?
    var selectedAlbumPhoto = UIImage()
    var selectedColor = UIColor()
    let allPhotosOptions = PHFetchOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        btn_next.layer.cornerRadius = 7.0
        btn_next.clipsToBounds = true
        btn_next.setTitle("Add To Cart", for: .normal)
        bottomView.layer.shadowRadius = 9
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomView.layer.shadowOffset = CGSize.zero
        collectionView.delegate  = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppHelper.delay(0.3) {
            self.setGradient()
        }
        self.bgImage.isHidden = true
    }
    
    func setGradient() {
        //        233 172 110
        //        242 122 132
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //      self.backgroundView.applyGradient(colours: [color1,color2])
        self.btn_next.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        
        
    }
    

  
  
    @IBAction func btn_tap_next(_ sender: Any) {
        
        saveDataToCoreData()
    }
    
}


extension BookLookViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       return selectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoIdentifier = self.selectArray[indexPath.row]
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookShowCollectionViewCell", for: indexPath) as! BookShowCollectionViewCell
        
        let sep_arr = photoIdentifier.characters.split{$0 == "."}.map(String.init)
        if sep_arr.last == "png" ||  sep_arr.last == "PNG" {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
                let imageURL = URL(string : photoIdentifier)
                let image    = UIImage(contentsOfFile: imageURL!.path)
                // Do whatever you want with the image
                cell.imageView_photo.image = image
                cell.imageView_shadow.image  = UIImage(named : "right")
                cell.view_main.backgroundColor = self.selectedColor
                //currentImage = image
                if indexPath.row  % 2 == 0 {
                    
                    //   cell.imageView_shadow.image  = image1
                    cell.imageView_shadow.transform = CGAffineTransform(scaleX: -1, y: 1)
                    
                } else {
                    cell.imageView_shadow.image  = UIImage(named : "right")
                }
                
            }
            
            
            
        } else {
            
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            let allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
            //  cell.label_counter.text = "\(indexPath.row + 1)"
            allPhotos.enumerateObjects({ photoAsset, idx, stop in
                
                
                
                if photoIdentifier == photoAsset.localIdentifier {
                    let options = PHImageRequestOptions()
                    options.deliveryMode = .fastFormat
                    options.isSynchronous = true
                    options.isNetworkAccessAllowed = false
                    //   options.resizeMode = .exact
                    cell.imageView_photo.contentMode = .scaleAspectFit
                    PHImageManager.default().requestImage(for: photoAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options, resultHandler: { image, info in
                        if info?[PHImageErrorKey] == nil && !(info?[PHImageResultIsDegradedKey] as! Int != 0) {
                            
                            cell.imageView_photo.image = image
                            cell.imageView_shadow.image  = UIImage(named : "right")
                            cell.view_main.backgroundColor = self.selectedColor
                            if indexPath.row  % 2 == 0 {
                                
                                //   cell.imageView_shadow.image  = image1
                                cell.imageView_shadow.transform = CGAffineTransform(scaleX: -1, y: 1)
                                
                            } else {
                                cell.imageView_shadow.image  = UIImage(named : "right")
                            }
                            
                        }
                    })
                }
            })
            
        }
        return cell

  
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
            return CGSize(width: UIScreen.main.bounds.width / 2 - 10 , height: 180)
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
   return 15
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "editPageImageViewController") as! EditPageImageViewController
        vc.editable_image = self.selectArray[indexPath.row]
        vc.editableImageDelegate = self
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func getNewEditableImages(editableImage: UIImage, for index: Int, foruniqueId identifier: String) {
        
        
        let indexPath = IndexPath(item: index, section: 0)
        self.selectArray[indexPath.row] = identifier
        collectionView.reloadItems(at: [indexPath])
    }
}


extension BookLookViewController {
    
    //add Data TO core data
    
    fileprivate func saveDataToCoreData() {
        
        let order_id  = String("\(Utilities.getCurrentMilliSecond())".suffix(10))
        print(order_id)
        let _:NSFetchRequest<CartData> = CartData.fetchRequest()
        
        AppHelper.setStringForKey(order_id, key: databaseKeys.order_id)
        let cart = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: DataBaseClass.getContext()) as! CartData
        
        cart.order_id = "\(order_id)"
        cart.category = self.category_type
        cart.category_id = self.category_id
        //book adding
        cart.book_type =  self.book_type
        cart.book_price = self.book_price
        cart.book_color_id =  book_color_id
        cart.book_name = book_name
        cart.book_name_font = book_name_font
        cart.book_name_font_color = book_name_font_color
        var selectColor = ""
        switch selectedColor {
        case .blue:
            selectColor = "Blue"
            
        case .white:
            selectColor = "White"
        case .green:
            selectColor = "Green"
        case .purple:
            selectColor = "Purple"
        case .red:
            selectColor = "Red"
            
        case .red:
            selectColor = "Gray"
        default:
            selectColor = "White"
        }
        
        cart.book_page_color = selectColor
        DataBaseClass.saveContext()
        
        for i  in 0..<selectArray.count {
            addImageToCoreData(selectArray[i], cart.order_id!, "\(i+1)")
        }
        addImageToCoreData(self.photo_cover_image_url!, cart.order_id!, "0")
    }
    
    
    //Add Images To Core Data
    fileprivate func  addImageToCoreData(_ imageName : String, _ order_id : String, _ index : String) {
        
        let userImages = NSEntityDescription.insertNewObject(forEntityName: "UserImages", into: DataBaseClass.getContext()) as! UserImages
        
        userImages.image_path = String(imageName)
        userImages.order_id = order_id
        userImages.image_order_number = index
        
        DataBaseClass.saveContext()
        print("data for images added")
    }
    
    
    
  
    
    
}
