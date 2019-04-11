//
//  AssetsGridViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit
import Photos
//import CheckMarkView
import CloudKit
import CoreData

protocol SelectedImagesDelegate {
    func selectedImagesList(selectedArray : [String])
   
}

class AssetsPickerGridController: BaseViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,GotToOtherScreenDelegate {
 
	
	fileprivate var assetGridThumbnailSize: CGSize = CGSize(width: 0, height: 0)
	fileprivate let reuseIdentifier = "AssetsGridCell"
	fileprivate let typeIconSize = CGSize(width: 20, height: 20)
	fileprivate let checkMarkSize = CGSize(width: 28, height: 28)
	fileprivate let iconOffset: CGFloat = 3
	fileprivate let collectionViewEdgeInset: CGFloat = 2
	fileprivate let assetsInRow: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 4 : 8
	
	let cachingImageManager = PHCachingImageManager()
	var collection: PHAssetCollection?
	var selectedIndexes: Set<Int> = Set()
	var didSelectAssets: ((Array<PHAsset?>) -> ())?
    
    //Prints
    var print_type : String?
    var print_price : String?
    var print_size : String?
    var print_discount : String?
    var selected_pkg : String?

    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var folderNameLabel: UILabel!
    
    var customDelegate : SelectedImagesDelegate?
    //Category Type
    var category_type = ""
    var category_id = ""
    var comeFrom = ""
    var book_type : String?
    var book_price : String?
    var selectArray = [String]()
    
    var foldername:String!
    var docDicName = ""
    var segmentIndex = 0
    
    
    //    var images = [UIImage]()
    lazy var images: [UIImage] = {
        let images = [UIImage]()
        return images
    }()

    var imageName = [String]()
    
    
    var aCIImage = CIImage()
    var brightnessFilter: CIFilter!
    var context = CIContext()
    var outputImage = CIImage()
    var newUIImage = UIImage()
    
    var clickedIndex = 0
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
   // var arr_url = [Any]()
    var selectedUrl = [Any]()
    
    var arr_is_iCloud = [Bool]()
    var arr_select_is_icloud = [Bool]()
    
    var selectedAssets = [PHAsset]()
    
    
	fileprivate var assets: [PHAsset]! {
		willSet {
			cachingImageManager.stopCachingImagesForAllAssets()
		}
		
		didSet {
			cachingImageManager.startCachingImages(for: self.assets, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil)
		}
	}
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        nextButton.backgroundColor = color1
        
        nextButton.applyGradient(colours: [color2,color1], locations: [0.3, 0.7, 1.0,0.7])
        
        AppHelper.delay(0.2) {
            self.nextButton.applyGradient(colours: [color2,color1], locations: [0.3, 0.7, 1.0,0.7])
        }

		collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.alpha = 0.6
        nextButton.isEnabled = false
        
        assetGridThumbnailSize = CGSize(width: 150, height: 150)
		
		let assetsFetchResult = (collection == nil) ? PHAsset.fetchAssets(with: .image, options: nil) : PHAsset.fetchAssets(in: collection!, options: nil)
        
        
		assets = assetsFetchResult.objects(at: IndexSet(integersIn: Range(NSMakeRange(0, assetsFetchResult.count))!))
        

        let tmp_assetsss = assets
        let tmp = assets.filter{value in
            value.mediaType == .image
        }
         assets.removeAll()
        assets = tmp
        

        self.navTitle.text = "Selected Photos 0"
        self.folderNameLabel.text = foldername

        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
        longPressGR.minimumPressDuration = 0.2
        longPressGR.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGR)
        
     
	}
    
    override func viewWillAppear(_ animated: Bool) {
          self.navTitle.text = "Selected Photos \(selectArray.count)"
    }
    
    override func menuClicked() {
        let vc = AssetsPickerController()
        vc.abcd = "qazwsxqqqqqqqqqqqqqq"
        customDelegate?.selectedImagesList(selectedArray: selectArray)

        
        self.navigationController?.popViewController(animated: true)
    }
    
    func goTootherScreen(sortType : String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "selectBookColorViewController") as! SelectBookColorViewController
        
        vc.category_type = category_type
        vc.category_id = category_id
        vc.book_type = book_type
        vc.book_price = book_price
        if sortType == "Chronological Order" {
          vc.selectArray = self.selectArray.reversed()
        } else {
            vc.selectArray = self.selectArray
        }
        vc.sortType = sortType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectedImagesList(selectedImages : [String]) {
        self.selectArray = selectedImages
        if self.selectArray.count > 0 {
      // collectionView.reloadData()
          
        }
        
    }
    
    
    @objc
    func handleLongPress(longPressGR: UILongPressGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if segmentIndex == 2{
          
            let point = longPressGR.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: point)

            if let indexPath = indexPath {
                var cell = self.collectionView.cellForItem(at: indexPath)
                print(indexPath.row)

                let vc = storyboard.instantiateViewController(withIdentifier: "SelectedImageViewController") as! SelectedImageViewController
                vc.socialmedia = "Instagram"
                //vc.selectImage =  UIImage(data: self.downloadImage(from: URL(string: self.standard_resolution_Url[indexPath.row])!))
          //      vc.imageUrl = self.standard_resolution_Url[indexPath.row]
                //vc.navigation = self.navigationController
                self.present(vc, animated: true, completion: nil)


            } else {
                print("Could not find index path")
            }

        } else if segmentIndex == 0 {
            let point = longPressGR.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: point)

            if let indexPath = indexPath {
                let vc = storyboard.instantiateViewController(withIdentifier: "SelectedImageViewController") as! SelectedImageViewController
              
                let asset = self.assets[(indexPath as NSIndexPath).row]
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.isNetworkAccessAllowed = false
                options.resizeMode = .exact

                cachingImageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: options, resultHandler: { (image: UIImage?, info :[AnyHashable: Any]?) -> Void in
                 

                         vc.selectImage = image

                })


                //vc.navigation = self.navigationController
                self.present(vc, animated: true, completion: nil)

            } else {
                print("Could not find index path")
            }
        }


    }


	
	// MARK: - UICollectionViewDataSource
	
	 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return assets.count
	}
	
	 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
		cell.backgroundColor = .clear
        
        let currentTag = cell.tag + 1
        cell.tag = currentTag
        
     
      //  var checkMarkView: CheckMarkView!

		
		let asset = assets[(indexPath as NSIndexPath).row]
		
		//typeIcon.image = nil
		if asset.mediaType == .video {
			if asset.mediaSubtypes == .videoTimelapse {
				cell.albumImage.image = UIImage(named: "timelapse-icon.png")
			}
			else {
				cell.albumImage.image = UIImage(named: "video-icon.png")
			}
		}
		else if asset.mediaType == .image {
			if asset.mediaSubtypes == .photoPanorama {
			cell.albumImage.image = UIImage(named: "panorama-icon.png")
			}
		}
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        options.isSynchronous = true
        options.isNetworkAccessAllowed = false
        options.resizeMode = .exact

		
        cell.selectImageView.image = UIImage(named: "")
        cell.albumImage.alpha = 1.0
        
     print("loal id====== \(asset.localIdentifier)")
        
        if selectArray.contains("\(asset.localIdentifier)") {
            if asset.pixelWidth < 400 || asset.pixelHeight < 400 {
                  cell.selectImageView.image = UIImage(named: "yellow_tick")
                self.makeToast("Choosing lower resolution image can effact on printed images. Try to choose high resolution images")
            } else {
            cell.selectImageView.image = UIImage(named: "tick")
            }
            cell.albumImage.alpha = 0.6
            
        }
        
        //check for next button enabled
        if self.comeFrom == PrintingType.Prints.rawValue {
            if selectArray.count > Int(selected_pkg!)! {
                nextButton.alpha = 1
                nextButton.isEnabled = true
            } else {
                nextButton.alpha = 0.6
                nextButton.isEnabled = false
            }
        } else {
            
            if selectArray.count > 0{
                nextButton.alpha = 1
                nextButton.isEnabled = true
            }else{
                nextButton.alpha = 0.6
                nextButton.isEnabled = false
            }
            
        }


        cachingImageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill, options: options, resultHandler: { (image: UIImage?, info :[AnyHashable: Any]?) -> Void in
            print("get icloud image =+++++++++++++++++++++++++++++++\(info)")
          
            
            if cell.tag == currentTag {
                cell.albumImage.image = image
                
            }
        })
        
        return cell
	}
	
	// MARK: - UICollectionViewDelegate
	
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(selectedUrl.count)
        print(assets.count)
        let asset = assets[(indexPath as NSIndexPath).row]
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        
        cell.selectImageView.image = UIImage(named: "tick")
        let imgPath = asset.localIdentifier
        if selectArray.contains(imgPath) {
            
            let index = selectArray.index(of: imgPath)
            selectArray.remove(at: index!)
            
        } else {
            selectArray.append(imgPath)
        }
        
        self.navTitle.text = "Selected Photos \(selectArray.count)"
     
        
        collectionView.reloadItems(at: [indexPath])
    }
	
	// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	 return CGSize(width: UIScreen.main.bounds.width / 3 - 22, height: UIScreen.main.bounds.width / 3 - 22)
	}
	

    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
//        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//        vc.selectArray = self.selectArray
//        vc.category_type = category_type
//        vc.category_id = category_id
//        self.navigationController?.pushViewController(vc, animated: true)
        
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if comeFrom == PrintingType.Photobooks.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "photoSortingViewController") as! PhotoSortingViewController
            vc.selectArray = self.selectArray
            vc.category_type = category_type
            vc.category_id = category_id
            vc.customDelegateForScreen = self
            self.present(vc, animated: true, completion: nil)
        } else if comeFrom == PrintingType.Prints.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "organiseBookViewController") as! OrganiseBookViewController
            vc.selectArray = self.selectArray
           
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "organiseBookViewController") as! OrganiseBookViewController
            vc.selectArray = self.selectArray
            vc.category_type = category_type
            vc.category_id = category_id
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    var count:Int = 0
    var isCheckForSelect = false
    var isCheckForLoad = false
    
    @IBAction func selectAllClicked(_ sender: UIButton) {
        
        
        if sender.title(for: .normal) == "Select All"{
            getAllImagesIdentifier()
            sender.setTitle("Deselect All", for: .normal)
            
            
        } else {
             sender.setTitle("Select All", for: .normal)
            //self.selectArray.removeAll()
            removeAllIdentifier()
            
        }
        self.collectionView.reloadData()
        
    
        
    }
    
    
    //get all images identifier
    func getAllImagesIdentifier() {
        self.hudShow()
        for i in 0..<self.assets.count {
            let asset_identifier = self.assets[i].localIdentifier
            if !self.selectArray.contains(asset_identifier) {
                self.selectArray.append(asset_identifier)
//                self.addImagetoDatabase(index: i, status: 1)
            }
        }
         self.navTitle.text = "Selected Photos \(self.selectArray.count)"
        self.hudHide()
    }
    
    //get all images identifier
    func removeAllIdentifier() {
        self.hudShow()
        let tmp_selected = self.selectArray
        for i in 0..<tmp_selected.count {
            _ = self.assets[i].localIdentifier
            self.selectArray.removeAll()
//            self.addImagetoDatabase(index: i, status: 0)
        }
        self.hudHide()
         self.navTitle.text = "Selected Photos \(self.selectArray.count)"
    }
    
    
    
   
}
