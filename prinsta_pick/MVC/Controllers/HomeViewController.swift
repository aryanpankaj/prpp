//
//  HomeViewController.swift
//  prinsta_pick
//
//  Created by apple on 09/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit
import FSPagerView
import Photos
import CoreData
import FMPhotoPicker

class HomeViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FMPhotoPickerViewControllerDelegate, FMImageEditorViewControllerDelegate {
    
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
      //  previewImageView.image = photo
    }
    
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var rotateImageView: UIImageView!
    
    
    @IBOutlet weak var selectedImageTableView: UICollectionView!
    @IBAction func addCartButtonClicked(_ sender: Any) {
        addDataToCoreData()
    }
    
    @IBAction func editEmageCountButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Photo", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assetsPickerController") as! AssetsPickerController
        vc.selectArray = self.selectArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    var selectArray  = [String]()
    //Category Type
    var category_type = ""
    var category_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageTableView.delegate = self
        selectedImageTableView.dataSource = self
        
//        UIView.animate(withDuration: 10, animations: {
//
//                self.rotateImageView.transform = CGAffineTransform(rotationAngle: .pi)
//
//        })
//
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: M_PI * 2.0)
        rotationAnimation.duration = 4;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        self.rotateImageView?.layer.add(rotationAnimation, forKey: "rotationAnimation")
        // Do any additional setup after loading the view.
        fetchData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectArray.count
    }
     let allPhotosOptions = PHFetchOptions()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
       
        
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: allPhotosOptions) as? PHFetchResult
        
        allPhotos?.enumerateObjects({ photoAsset, idx, stop in
            
            let photoIdentifier = self.selectArray[indexPath.row]
            
            
            if photoIdentifier == photoAsset.localIdentifier {
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.isNetworkAccessAllowed = false
                options.resizeMode = .exact
                
                PHImageManager.default().requestImage(for: photoAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options, resultHandler: { image, info in
                    if info?[PHImageErrorKey] == nil && !(info?[PHImageResultIsDegradedKey] as! Int != 0) {
                        
                       cell.albumImage.image = image
                        
                    }
                })
            }
        })
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 22, height: UIScreen.main.bounds.width / 2 - 22)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: allPhotosOptions) as? PHFetchResult
        
        allPhotos?.enumerateObjects({ photoAsset, idx, stop in
            
            let photoIdentifier = self.selectArray[indexPath.row]
            
            
            if photoIdentifier == photoAsset.localIdentifier {
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.isNetworkAccessAllowed = false
                options.resizeMode = .exact
                
                PHImageManager.default().requestImage(for: photoAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { image, info in
                    if info?[PHImageErrorKey] == nil && !(info?[PHImageResultIsDegradedKey] as! Int != 0) {
                         UIApplication.shared.isNetworkActivityIndicatorVisible = true
                        let vc = FMImageEditorViewController(config: self.config(), sourceImage: image!)
                        vc.delegate = self
                        
                        self.present(vc, animated: true)
                        
                    }
                })
            }
        })
        
        
        
      
    }
    
    func config() -> FMPhotoPickerConfig {
        let selectMode: FMSelectMode =  .single
        
        var mediaTypes = [FMMediaType]()
       mediaTypes.append(.image)
     
        
        var config = FMPhotoPickerConfig()
        
        config.selectMode = selectMode
        config.mediaTypes = mediaTypes
        config.maxImage = 1
        
        config.forceCropEnabled = false
        config.eclipsePreviewEnabled = false
        
        // in force crop mode, only the first crop option is available
        config.availableCrops = [
            FMCrop.ratioSquare   //,
//            FMCrop.ratioCustom,
//            FMCrop.ratio4x3,
//            FMCrop.ratio16x9,
//            FMCrop.ratioOrigin,
        ]
        
        // all available filters will be used
        config.availableFilters = []
        
        return config
    }
    
    
    //add Data TO core data
    
    func addDataToCoreData() {
        
        let order_id  = String("\(Utilities.getCurrentMilliSecond())".suffix(10))
        print(order_id)
        let _:NSFetchRequest<CartData> = CartData.fetchRequest()

            AppHelper.setStringForKey(order_id, key: databaseKeys.order_id)
      let cart = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: DataBaseClass.getContext()) as! CartData
            
            cart.order_id = "\(order_id)"
            cart.category = self.category_type
            cart.category_id = self.category_id
        
        DataBaseClass.saveContext()
            
            for asset in selectArray {
                addImageToCoreData(asset, cart.order_id!)
            }
    
    }
    
    
    //Add Images To Core Data
    func  addImageToCoreData(_ imageName : String, _ order_id : String) {
        
        let userImages = NSEntityDescription.insertNewObject(forEntityName: "UserImages", into: DataBaseClass.getContext()) as! UserImages
        
        userImages.image_path = String(imageName)
        userImages.order_id = order_id
      
        DataBaseClass.saveContext()
        print("data for images added")
    }
    
    //get image path from core database
    func fetchData(){
        
        //   fetchedImage.removeAll()
        
        let fetchRequest1:NSFetchRequest<UserImages> = UserImages.fetchRequest()
        fetchRequest1.predicate = NSPredicate.init(format: "order_id == %@", AppHelper.getStringForKey(databaseKeys.order_id))
        do{
            
            let searchResult = try DataBaseClass.getContext().fetch(fetchRequest1)
            
            for result in searchResult as [UserImages]
            {
                
                selectArray.append(result.image_path!)
                
            }
            
            selectedImageTableView.reloadData()
        }
        catch
        {
            print("Error: \(error)")
        }
        
        
    }
    
}
