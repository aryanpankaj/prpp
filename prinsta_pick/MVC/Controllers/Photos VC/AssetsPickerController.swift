//
//  RootListAssetsViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

import Photos
import SWSegmentedControl
import FacebookCore
import FBSDKCoreKit
import FacebookLogin
import FBSDKLoginKit
import InstagramLogin
import AlamofireImage
import CoreData

class AssetsPickerController: BaseViewController,SWSegmentedControlDelegate, PHPhotoLibraryChangeObserver,SelectedImagesDelegate {
   
   
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var socialLoginImageView: UIImageView!
    @IBOutlet weak var socialLoginLabel: UILabel!
    @IBOutlet weak var socialLoginView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
     @IBOutlet weak var segmentControl: SWSegmentedControl!
    var instagramLogin: InstagramLoginViewController!
    
     var sagmentedTitle = ["MOB","FACEBOOK","INSTAGRAM"]
    var abcd = "abcdddddddd"
    
    //Category Type
    var category_type = ""
    var category_id = ""
   var comeFrom = ""
    var book_type : String?
    var book_price : String?
    
 //  var instagramLogin: InstagramLoginViewController!
    var thumbnail_url = [String]()
    var standard_resolution_Url = [String]()
    
    var print_type : String?
    var print_price : String?
    var print_size : String?
    var print_discount : String?
    var selected_pkg : String?
    
    var album:Album!
    
    var count:Int = 0
    
    let clientId = "37677046d01940ebb9c2e85f6f7efdd9"
    let redirectUri = "https://www.xtreemsolution.com"
    var segmentIndex = 0
    
    var imageName = [String]()
    var images = [UIImage]()
    var clickedIndex = 0
    
    var selectArray = [String]()
    var selectArray1 = [String]()
    
	enum AlbumType: Int {
		case allPhotos
		case favorites
		case panoramas
		case videos
		case timeLapse
		case recentlyDeleted
		case userAlbum
		
		static let titles = ["All images", "Favorites", "Panoramas", "Videos", "Time Lapse", "Recently Deleted", "User Album"]
	}
	
	struct RootListItem {
		var title: String!
		var albumType: AlbumType
		var image: UIImage!
        var imageCout : Int
		var collection: PHAssetCollection?
	}
	
	 var items: Array<RootListItem>!
	 var activityIndicator: UIActivityIndicatorView!
	 let thumbnailSize = CGSize(width: 100, height: 100)
	 let reuseIdentifier = "RootListAssetsCell"
	
	 var didSelectAssets: ((Array<PHAsset?>) -> ())?
	
	// MARK: View controllers methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        nextButton.backgroundColor = color1
        
        nextButton.applyGradient(colours: [color2,color1], locations: [0.3, 0.7, 1.0,0.7])
        
        AppHelper.delay(0.2) {
             self.nextButton.applyGradient(colours: [color2,color1], locations: [0.3, 0.7, 1.0,0.7])
        }

        segmentControl.delegate = self
        
        segmentControl.items = sagmentedTitle
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
    
            self.navTitle.text = "Selected Photos" + " 0"
        
        nextButton.alpha = 0.6
        nextButton.isEnabled = false
        
        if selectArray.count > 0 {
    self.navTitle.text = "Selected Photos \(selectArray.count)"
        }
       
        collectionView.delegate = self
        collectionView.dataSource = self

		// Activity indicator
//        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.gray)
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
		activityIndicator.hidesWhenStopped = true
		activityIndicator.center = self.view.center
		self.view.addSubview(activityIndicator)
		
		// Data
		items = Array()
		
		// Notifications
		PHPhotoLibrary.shared().register(self)
		
		// Load photo library
		loadData()
	}
	
	deinit {
		PHPhotoLibrary.shared().unregisterChangeObserver(self)
	}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        DispatchQueue.global(qos: .background).async {
//            self.fetchData()
//        }
        
        print("fffffffffffffffffffffffffffff \(abcd)")
    }
	
	// MARK: Data loading
	
	func loadData() {
		DispatchQueue.main.async {
			self.collectionView.isUserInteractionEnabled = false
			self.activityIndicator.startAnimating()
		}
		
		DispatchQueue.global(qos: .default).async {
		
			self.items.removeAll(keepingCapacity: false)
			//let allAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
            let assetsCount = self.assetsCountFromCollection(nil)
          
            
            let allPhotosItem = RootListItem(title: AlbumType.titles[AlbumType.allPhotos.rawValue], albumType: AlbumType.allPhotos, image: self.lastImageFromCollection(nil), imageCout: assetsCount, collection: nil)
               print("rrrrrrrrrrrrrrrrrrrrr \(allPhotosItem)")
            if assetsCount > 0 {
                self.items.append(allPhotosItem)
            }
			
            print(assetsCount)
			
			let smartAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
            print("rrrrrrrrrrrrrrrrrrrrr \(smartAlbums.count)")
			for i: Int in 0 ..< smartAlbums.count {
				let smartAlbum = smartAlbums[i]
				var item: RootListItem? = nil
				
				let assetsCount = self.assetsCountFromCollection(smartAlbum)
				if assetsCount == 0 {
					continue
				}
				
				switch smartAlbum.assetCollectionSubtype {
				case .smartAlbumFavorites:
                    item = RootListItem(title: AlbumType.titles[AlbumType.favorites.rawValue], albumType: AlbumType.favorites, image: self.lastImageFromCollection(smartAlbum), imageCout: AlbumType.titles[AlbumType.allPhotos.rawValue].count, collection: smartAlbum)
					break
				case .smartAlbumPanoramas:
                    item = RootListItem(title: AlbumType.titles[AlbumType.panoramas.rawValue], albumType: AlbumType.panoramas, image: self.lastImageFromCollection(smartAlbum), imageCout: AlbumType.titles[AlbumType.allPhotos.rawValue].count, collection: smartAlbum)
					break
//                case .smartAlbumVideos:
//                    item = RootListItem(title: AlbumType.titles[AlbumType.videos.rawValue], albumType: AlbumType.videos, image: self.lastImageFromCollection(smartAlbum), collection: smartAlbum)
//                    break
				case .smartAlbumTimelapses:
                    item = RootListItem(title: AlbumType.titles[AlbumType.timeLapse.rawValue], albumType: AlbumType.timeLapse, image: self.lastImageFromCollection(smartAlbum), imageCout: AlbumType.titles[AlbumType.allPhotos.rawValue].count, collection: smartAlbum)
					break
					
				default:
					break
				}
				
				if item != nil {
					self.items.append(item!)
				}
			}
			
			let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
			for i: Int in 0 ..< topLevelUserCollections.count {
				if let userCollection = topLevelUserCollections[i] as? PHAssetCollection {
					let assetsCount = self.assetsCountFromCollection(userCollection)
					if assetsCount == 0 {
						continue
					}
                    let item = RootListItem(title: userCollection.localizedTitle, albumType: AlbumType.userAlbum, image: self.lastImageFromCollection(userCollection), imageCout: assetsCount, collection: userCollection)
					self.items.append(item)
				}
			}
			
			DispatchQueue.main.async {
				self.collectionView.reloadData()
				self.activityIndicator.stopAnimating()
				self.collectionView.isUserInteractionEnabled = true
			}
		}
	}
	//Custom Delegate
    func selectedImagesList(selectedArray: [String]) {
        print(selectedArray)
        self.selectArray = selectedArray
        self.navTitle.text = "Selected Photos \(self.selectArray.count)"
        print("Test change for sameeeeeeeee: \(abcd)")
    }
    

	// MARK: Navigation bar actions
	
	@objc func cancelAction() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func doneAction() {
		
	}
	
	// MARK: PHPhotoLibraryChangeObserver
	
    open func photoLibraryDidChange(_ changeInstance: PHChange) {
        loadData()
    }
	
	// MARK: Other
	
	func assetsCountFromCollection(_ collection: PHAssetCollection?) -> Int {
		let fetchResult = (collection == nil) ? PHAsset.fetchAssets(with: .image, options: nil) : PHAsset.fetchAssets(in: collection!, options: nil)
		return fetchResult.count
	}
	
	func lastImageFromCollection(_ collection: PHAssetCollection?) -> UIImage? {
		
		var returnImage: UIImage? = nil
		
		let fetchOptions = PHFetchOptions()
		fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		
		let fetchResult = (collection == nil) ? PHAsset.fetchAssets(with: .image, options: fetchOptions) : PHAsset.fetchAssets(in: collection!, options: fetchOptions)
		if let lastAsset = fetchResult.lastObject {
			
			let imageRequestOptions = PHImageRequestOptions()
			imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
			imageRequestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
			imageRequestOptions.isSynchronous = true
			
			let retinaScale = UIScreen.main.scale
			let retinaSquare = CGSize(width: thumbnailSize.width * retinaScale, height: thumbnailSize.height * retinaScale) //CGSize(width: 200, height: 200)
			
			let cropSideLength = min(lastAsset.pixelWidth, lastAsset.pixelHeight)
			let square = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(cropSideLength), height: CGFloat(cropSideLength))
			let cropRect = square.applying(CGAffineTransform(scaleX: 1.0 / CGFloat(lastAsset.pixelWidth), y: 1.0 / CGFloat(lastAsset.pixelHeight)))
			
			imageRequestOptions.normalizedCropRect = cropRect
			
			PHImageManager.default().requestImage(for: lastAsset, targetSize: retinaSquare, contentMode: PHImageContentMode.aspectFit, options: imageRequestOptions, resultHandler: { (image: UIImage?, info :[AnyHashable: Any]?) -> Void in
				returnImage = image
                print(info)
			})
		}
		
		return returnImage
	}
    
    
    
    
 //   MARK: - SWSegmentedControlDelegate
    func segmentedControl(_ control: SWSegmentedControl, willSelectItemAtIndex index: Int) {
        print("will select \(index)")
    }

    func segmentedControl(_ control: SWSegmentedControl, didSelectItemAtIndex index: Int) {

        self.segmentIndex = index
        if index == 0{

         loadData()

              collectionView.isHidden = false
            socialLoginView.isHidden = true

        }
        if index == 1{
            collectionView.isHidden = true
            socialLoginView.isHidden = false

            if selectArray.contains("1"){
                nextButton.alpha = 1
                nextButton.isEnabled = true
            }else{
                nextButton.alpha = 0.6
                nextButton.isEnabled = false
            }

            collectionView.reloadData()
            if FBSDKAccessToken.current() == nil{
                collectionView.isHidden = true

                socialLoginImageView.image = UIImage(named: "login_04")
                socialLoginView.backgroundColor = UIColor.init(red: 42.0/255, green: 92.0/255, blue: 144.0/255, alpha: 1)
                socialLoginLabel.textColor = UIColor.white

                socialLoginLabel.text =  "Facebook"
                socialLoginView.layer.borderColor = UIColor.init(red: 42.0/255, green: 92.0/255, blue: 144.0/255, alpha: 1).cgColor

                print("FBSDKAccessToken.current()\(FBSDKAccessToken.current())")
                if((FBSDKAccessToken.current()) != nil){
                    print("------")


                    let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"albums{count,name,photo_count,photos{picture}}"], httpMethod: "GET")
                    request!.start(completionHandler: { connection, result, error in
                        // print("error\(error!)")
                        if error == nil{
                            print("result! result!\(result!)")}

                    })


                    /*  FBSDKGraphRequest(graphPath: "/{album-id}", parameters: ["fields":"id,count,cover_photo,name"]).start(completionHandler: {  (connection, result, error) -> Void in
                     print("error\(error!)")

                     if error == nil{
                     print("result! result!\(result!)")}
                     })*/
                    /*    let graphRequest = FBSDKGraphRequest(graphPath: "/{album-id}", parameters: ["fields":"id,name"], httpMethod: "POST")
                     let connection = FBSDKGraphRequestConnection()
                     connection.add(graphRequest, completionHandler: { (connection, result, error) in
                     print("error\(error!)")
                     if error == nil{
                     let dictionary = JSON(result!)
                     // print("albums ID are **************\(dictionary)")
                     if let data = dictionary["data"].array {
                     print("data of profilePicture ******* \(data)")

                     }
                     }

                     })
                     connection.start()*/


                }


            }





        }
        if index == 2{

            if selectArray.count > 0{
                nextButton.alpha = 1
                nextButton.isEnabled = true
            }else{
                nextButton.alpha = 0.6
                nextButton.isEnabled = false
            }
            //            instagramLoginButtonClicked()

        //    if AppHelper.getStringForKey(ServiceKeys.instagram_accessToken) == ""{

                socialLoginLabel.text = "Instagram"
                socialLoginLabel.textColor = UIColor.init(red: 122.0/255, green: 124.0/255, blue: 125.0/255, alpha: 1)

                socialLoginImageView.image = UIImage(named: "login_06")
                socialLoginView.backgroundColor = UIColor.white

                socialLoginView.layer.borderColor = UIColor.init(red: 122.0/255, green: 124.0/255, blue: 125.0/255, alpha: 1).cgColor

                collectionView.isHidden = true

       //     } else {
          //      self.getInstagramAlbumApiCall(accessToken: AppHelper.getStringForKey(ServiceKeys.instagram_accessToken))
          //      collectionView.isHidden = false

        //    }
        }


        print("did select \(index)")


    }

    func segmentedControl(_ control: SWSegmentedControl, willDeselectItemAtIndex index: Int) {
        print("will deselect \(index)")


    }

    func segmentedControl(_ control: SWSegmentedControl, didDeselectItemAtIndex index: Int) {
        print("did deselect \(index)")

    }

    func segmentedControl(_ control: SWSegmentedControl, canSelectItemAtIndex index: Int) -> Bool {

        return true
    }

    /*    lazy var imageManager: PHCachingImageManager = {
     return PHCachingImageManager()
     }()

     */
    @IBAction func socialLoginButton(_ sender: Any) {

        if  self.segmentIndex == 0{

        }else if  self.segmentIndex == 1 {

            self.facebookLogin()


        }else if  self.segmentIndex == 2{


            self.instagramLoginButtonClicked()

        }

    }


    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
    }
    
    
    
    
 
    
	
}


extension AssetsPickerController: InstagramLoginViewControllerDelegate,GetInstaUserDataDelegate {

    //instagram Login
    @objc func instagramLoginButtonClicked() {
       // loginWithInstagram()
        let story = UIStoryboard(name: "Phot", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "instaWebViewController") as! InstaWebViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)

    }



    func getUserDataForInstagram(access: String) {
       // getInstagramDataApiCall(accessToken: access)
        getInstagramAlbumApiCall(accessToken:access)
    }

    func loginWithInstagram() {

        // 2. Initialize your 'InstagramLoginViewController' and set your 'ViewController' to delegate it
        instagramLogin = InstagramLoginViewController(clientId: clientId, redirectUri: redirectUri)
        instagramLogin.delegate = self

        // 3. Customize it
        instagramLogin.scopes = [.basic, .publicContent] // [.basic] by default; [.all] to set all permissions
        instagramLogin.title = "Instagram" // If you don't specify it, the website title will be showed
        instagramLogin.progressViewTintColor = .blue // #E1306C by default

        // If you want a .stop (or other) UIBarButtonItem on the left of the view controller
        instagramLogin.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissLoginViewController))
        instagramLogin.navigationItem.leftBarButtonItem?.tintColor = .gray


        // You could also add a refresh UIBarButtonItem on the right
        instagramLogin.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        instagramLogin.navigationItem.rightBarButtonItem?.tintColor = .gray

        // 4. Present it inside a UINavigationController (for example)
        present(UINavigationController(rootViewController: instagramLogin), animated: true)
    }

    @objc func dismissLoginViewController() {
        instagramLogin.dismiss(animated: true)
    }

    @objc func refreshPage() {
        instagramLogin.reloadPage()
    }



    func instagramLoginDidFinish(accessToken: String?, error: InstagramError?) {

        // Whatever you want to do ...
        print("accessToken\(String(describing: accessToken))")
        self.getInstagramAlbumApiCall(accessToken: accessToken!)
        // And don't forget to dismiss the 'InstagramLoginViewController'
        //https://api.instagram.com/v1/users/self/?access_token=8430258051.3767704.8ed8bf54a6954fa9867a134976b90b50
        instagramLogin.dismiss(animated: true)
    }



    func getInstagramAlbumApiCall(accessToken:String){

        thumbnail_url.removeAll()
        standard_resolution_Url.removeAll()
        self.imageName.removeAll()
        self.images.removeAll()
        self.hudShow()
/*
        ServiceClass.sharedInstance.hitServiceForGetInstagramMedia(accessToken: accessToken,completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            // print_debug("response: \(parseData)")
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type && parseData != nil){


                let data = parseData["data"].arrayValue
                // let image = parseData["images"].arrayValue

                for obj in data{

                    let instagramImage = InstagramImage(fromJson: obj)
                    self.thumbnail_url.append(instagramImage.thumbnail_url)
                    self.standard_resolution_Url.append(instagramImage.standard_resolution_Url)
                }

                self.fetchData()


                print("thumb image\(self.thumbnail_url)")
                print("standard image\(self.standard_resolution_Url)")



                AppHelper.setStringForKey(accessToken, key: ServiceKeys.instagram_accessToken)
                self.collectionView.reloadData()
                self.collectionView.isHidden = false
            }else {


                let err = errorDict!["errMessage"]
                self.makeToast(err as! String)
            }
        })
*/

    }




}






extension AssetsPickerController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if segmentIndex == 0{
            return 1
            
        }else if segmentIndex == 1{
            return 0
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentIndex == 0{
            return items.count
        }else if segmentIndex == 1{
            return 0
        }else{
            return self.thumbnail_url.count
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentIndex == 0 {
            
        
            return CGSize(width: collectionView.frame.size.width / 2 - 22 , height:  collectionView.frame.size.width / 2 + 10)
    
            
            
            
        } else if segmentIndex == 1{
            return CGSize(width: collectionView.frame.size.width / 2 - 22 , height:  collectionView.frame.size.width / 2  + 10)
            
        }else{
            return CGSize(width: collectionView.frame.size.width / 2 - 22 , height:  collectionView.frame.size.width / 2)
        }
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentIndex == 0{
     
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoAlbumCollectionViewCell
            
            cell.albumNameLabel.text = items[(indexPath as NSIndexPath).row].title
            cell.albumImage.image = items[(indexPath as NSIndexPath).row].image
            cell.photoCountsLabel.text = "\(items[(indexPath as NSIndexPath).row].imageCout)"
            print( "Count ========== \(items[(indexPath as NSIndexPath).row].imageCout)")
            cell.albumImage.alpha = 1
          
            
            return cell
            
            
            //      }
        } else if segmentIndex == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoAlbumCollectionViewCell
            cell.radioImageView.image = UIImage(named: "")
            
            
            return cell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
            cell.selectImageView.image = UIImage(named: "")
            cell.albumImage.alpha = 1.0
            cell.albumImage.af_setImage(withURL: URL(string: self.thumbnail_url[indexPath.row])!)
            
            if selectArray.contains(self.standard_resolution_Url[indexPath.row]) {
                cell.selectImageView.image = UIImage(named: "selectRadio")
                cell.albumImage.alpha = 0.6
            }
            
            
          
            if selectArray.count > 0{
                nextButton.alpha = 1
                nextButton.isEnabled = true
            }else{
                nextButton.alpha = 0.6
                nextButton.isEnabled = false
            }
            
            return cell
            
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
        if segmentIndex == 0 || segmentIndex == 1{
//
            
            let story = UIStoryboard(name: "Photo", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "assetsPickerGridController") as! AssetsPickerGridController
            vc.category_id = self.category_id
            vc.category_type = self.category_type
            vc.comeFrom = comeFrom
            vc.customDelegate = self
            vc.selectedImagesList(selectedImages: selectArray)

            vc.foldername = items[(indexPath as NSIndexPath).row].title
         
            vc.collection =  items[(indexPath as NSIndexPath).row].collection
            vc.segmentIndex = self.segmentIndex
            vc.selectArray = self.selectArray
         
            if comeFrom == PrintingType.Prints.rawValue {
                vc.print_type =  self.print_type
                vc.print_price = self.print_price
                vc.print_size =  self.print_size
                vc.print_discount = print_discount
                vc.selected_pkg = self.selected_pkg
            } else if comeFrom == PrintingType.Photobooks.rawValue {
                vc.book_type = book_type
                vc.book_price = book_price
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
                cell.selectImageView.image = UIImage(named: "selectRadio")
        
                        
            cell.selectImageView.image = UIImage(named: "selectRadio")
            let imgPath = self.standard_resolution_Url[indexPath.item]
            if selectArray.contains(imgPath) {
                
                let index = selectArray.index(of: imgPath)
                selectArray.remove(at: index!)
          
                
            } else {
                selectArray.append(imgPath)
          
            }
            
   
            self.navTitle.text = "Selected Photos \(selectArray.count)"
       
            
            
            clickedIndex = indexPath.row
            collectionView.reloadItems(at: [indexPath])
            
        }
    }
    
    
    func fetchData(){

        //   fetchedImage.removeAll()

        let fetchRequest1:NSFetchRequest<UserImages> = UserImages.fetchRequest()
        fetchRequest1.predicate = NSPredicate.init(format: "order_id == %@", AppHelper.getStringForKey(databaseKeys.order_id))
        do{

            let searchResult = try DataBaseClass.getContext().fetch(fetchRequest1)

            print(searchResult.count)

            for result in searchResult as [UserImages]
            {

               // selectArray.append(result.imagePath!)

            }


            DispatchQueue.main.async {
                self.navTitle.text = "Selected Photos \(searchResult.count)"
              

                    self.navTitle.text =  "Selected Photos \(searchResult.count)"
                

            }

            DispatchQueue.main.async {
                if searchResult.count > 0 {
                    self.nextButton.alpha = 1.0
                    self.nextButton.isEnabled = true

                } else {
                    self.nextButton.alpha = 0.6
                    self.nextButton.isEnabled = false
                }
            }




        }
        catch
        {
            print("Error: \(error)")
        }


    }
    
    
    
    
    func addImagetoDatabase(index:Int,status:Int){
        var id = [String]()
        var finalId: Int!

        let fetchRequest:NSFetchRequest<UserImages> = UserImages.fetchRequest()
        do{

            let searchResult = try DataBaseClass.getContext().fetch(fetchRequest)
            for result in searchResult as [UserImages]
            {


                print("User Cart orderid \(result.image_path!) id \(result.order_id!)")

                print("\(AppHelper.getStringForKey(databaseKeys.order_id))")
                id.append(result.order_id!)
            }

            if id.count < 1{
                finalId = 1

            }
            else{

                finalId =  id.count + 1

            }

            if status == 1{



                let userImages = NSEntityDescription.insertNewObject(forEntityName: "UserImages", into: DataBaseClass.getContext()) as! UserImages

          //      userImages.id = String(finalId)
                userImages.order_id = AppHelper.getStringForKey(databaseKeys.order_id)

                //   userImages.imageBinary = imageInData! as NSData
                userImages.image_qty = "1"
                userImages.image_path = self.standard_resolution_Url[index]
               
               
                userImages.isFromSocialMedia = "Yes"
                DataBaseClass.saveContext()


            }else{

                let context = DataBaseClass.getContext()
                let coord = DataBaseClass.getContext().persistentStoreCoordinator
                let fetchRequest:NSFetchRequest<UserImages> = UserImages.fetchRequest()
                fetchRequest.predicate = NSPredicate.init(format: "image_path == %@", self.standard_resolution_Url[index])
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as!
                    NSFetchRequest<NSFetchRequestResult>)
                do {
                    try coord?.execute(deleteRequest, with: context)

                } catch let error as NSError {
                    debugPrint(error)
                }

            }








        }
        catch
        {
            print("Error: \(error)")
        }


     
    }



//
//
    
    func facebookLogin(){
        let loginManager = LoginManager()

        loginManager.logIn(readPermissions:[.userPhotos,.publicProfile,.email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):

                print("aaaaaa\(accessToken)")
                if((FBSDKAccessToken.current()) != nil){
                    print("------")

                    let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"albums"], httpMethod: "GET")
                    request!.start(completionHandler: { connection, result, error in
                        if error == nil{
                            print("result! result!\(result!)")}

                    })


                    /*  FBSDKGraphRequest(graphPath: "/{album-id}", parameters: ["fields":"id,count,cover_photo,name"]).start(completionHandler: {  (connection, result, error) -> Void in
                     print("error\(error!)")

                     if error == nil{
                     print("result! result!\(result!)")}
                     })*/
                    /*    let graphRequest = FBSDKGraphRequest(graphPath: "/{album-id}", parameters: ["fields":"id,name"], httpMethod: "POST")
                     let connection = FBSDKGraphRequestConnection()
                     connection.add(graphRequest, completionHandler: { (connection, result, error) in
                     print("error\(error!)")
                     if error == nil{
                     let dictionary = JSON(result!)
                     // print("albums ID are **************\(dictionary)")
                     if let data = dictionary["data"].array {
                     print("data of profilePicture ******* \(data)")

                     }
                     }

                     })
                     connection.start()*/


                }
            }
        }


    }
    
}
