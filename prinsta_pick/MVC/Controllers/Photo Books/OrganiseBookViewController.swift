//
//  OrganiseBookViewController.swift
//  prinsta_pick
//
//  Created by apple on 03/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Photos
import CoreData

protocol SetImageIndexDelegaate {
    func getNewImagesIndex(selectedImagesArray : [String])
}


class OrganiseBookViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView_organiseBook: UICollectionView!
    @IBOutlet weak var btn_confirm: UIButton!
    @IBOutlet weak var view_bottom: UIView!
    
    var delegate : SetImageIndexDelegaate?
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
        collectionView_organiseBook.delegate = self
        collectionView_organiseBook.dataSource = self
        self.collectionView_organiseBook.dragInteractionEnabled = true
        self.collectionView_organiseBook.dragDelegate = self
        self.collectionView_organiseBook.dropDelegate = self
       print(selectArray)
        btn_confirm.layer.cornerRadius = 7.0
        btn_confirm.clipsToBounds = true
        btn_confirm.setTitle("Confirm", for: .normal)
        view_bottom.layer.shadowRadius = 9
        view_bottom.layer.shadowOpacity = 0.3
        view_bottom.layer.shadowColor = UIColor.lightGray.cgColor
        view_bottom.layer.shadowOffset = CGSize.zero
        
    }
    
    @IBAction  func tap_confirm_button(_ sender: UIButton) {
        print(selectArray)
//        if isChangeImage! {
//            //save image to document directory
//            self.saveImageIntoDoc()
//        }
//
//
//        saveDataToCoreData()
//
//
//        AppHelper.delay(1.0) {
//            self.navigationController?.popToRootViewController(animated: true)
//        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "bookLookViewController") as! BookLookViewController
        vc.category_type = category_type
        vc.category_id = category_id
        vc.selectedAlbumPhoto = selectedAlbumPhoto
        vc.selectArray = self.selectArray
        vc.book_type = book_type
        vc.book_price = book_price
        vc.book_name = book_name
        vc.book_name_font = book_name_font
        vc.book_name_font_color = book_name_font_color
        vc.book_color_id = book_color_id
        vc.selectedColor =  selectedColor
        vc.isChangeImage = isChangeImage
        
     
        vc.photo_cover_image_url = photo_cover_image_url
        vc.cover_image = cover_image
        vc.sortType = sortType
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //      self.backgroundView.applyGradient(colours: [color1,color2])
        self.btn_confirm.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        
     
    }
    
    //MARK : custom Delegate
    func getNewImagesIndex(selectedImagesArray : [String]) {
        
        
    }
    
    
    //MARK : COllectionView datasource and delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return selectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "organiseCollectionViewCell", for: indexPath) as! OrganiseCollectionViewCell
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        //  cell.label_counter.text = "\(indexPath.row + 1)"
        cell.label_counter.isHidden = true
        
        allPhotos.enumerateObjects({ photoAsset, idx, stop in
            
            let photoIdentifier = self.selectArray[indexPath.row]
            
            if photoIdentifier == photoAsset.localIdentifier {
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.isNetworkAccessAllowed = false
                //   options.resizeMode = .exact
                cell.selectedImageView.contentMode = .scaleToFill
                PHImageManager.default().requestImage(for: photoAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options, resultHandler: { image, info in
                    if info?[PHImageErrorKey] == nil && !(info?[PHImageResultIsDegradedKey] as! Int != 0) {
                        
                        cell.selectedImageView.image = image
                        cell.bgImageView.backgroundColor = self.selectedColor
                        
                    }
                })
            }
        })
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            return CGSize(width: (UIScreen.main.bounds.width / 4) - 10 , height: (UIScreen.main.bounds.width / 4) + 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
            return 5
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
               
                
                    self.selectArray.remove(at: sourceIndexPath.row)
                    self.selectArray.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
        
        collectionView.reloadData()
        print(selectArray)
    }
    
   
    private func copyItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated()
            {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
            
               
                    self.selectArray.insert(item.dragItem.localObject as! String, at: indexPath.row)
                
                indexPaths.append(indexPath)
            }
            collectionView.insertItems(at: indexPaths)
        })
    }
    
}


// MARK: - UICollectionViewDragDelegate Methods
extension OrganiseBookViewController : UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let item = collectionView == collectionView_organiseBook ? self.selectArray[indexPath.row] : self.selectArray[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem]
    {
        let item = collectionView == collectionView_organiseBook ? self.selectArray[indexPath.row] : self.selectArray[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        if collectionView == collectionView_organiseBook
        {
            let previewParameters = UIDragPreviewParameters()
            previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 10, y: 10, width: (UIScreen.main.bounds.width / 3) - 60, height: (UIScreen.main.bounds.width / 3) - 60))
            return previewParameters
        }
        return nil
    }
}

// MARK: - UICollectionViewDropDelegate Methods
extension OrganiseBookViewController : UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView.hasActiveDrag
        {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else
        {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of table view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
            
        case .copy:
            self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            collectionView.reloadData()
        default:
            return
        }
    }
}


extension OrganiseBookViewController {
    
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
    
    
    
    func saveImageIntoDoc() {
        
                // get the documents directory url
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                // choose a name for your image
                let fileName = "\(Utilities.randomString(length: 7)).png"
                // create the destination file url to save your image
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = cover_image!.jpegData(compressionQuality: 1.0),
                    !FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        // writes the image data to disk
                        try data.write(to: fileURL)
                        print("file saved")
                        
                        print(fileURL)
//                        let imageData  = cover_image!.jpegData(compressionQuality: 1.0)
                        CustomPhotoAlbum.sharedInstance.saveImage(image: cover_image!)
                        
                        
                        let sep_arr = "\(fileURL)".characters.split{$0 == "/"}.map(String.init)
                        print(sep_arr)
                        
                        //                        userImages.setValue("\(sep_arr[6])/L0/001", forKey: "imagePath")
                       // userImages.setValue("\(fileURL)", forKey: "imagePath")
                        
                        //delegate?.callEditImageList(image: "\(sep_arr[6])/L0/001", index: index, qty: newQty)
                        
                        self.photo_cover_image_url = "\(sep_arr[6])/L0/001"
                       
                        
                    } catch {
                        print("error saving file:", error)
                        self.makeToast("Not able to store image")
                    }
                }
                
                
            
            
       
        
        
        
    }
    

    
}
