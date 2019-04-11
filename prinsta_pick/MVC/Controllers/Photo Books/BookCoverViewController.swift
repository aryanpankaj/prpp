//
//  BookCoverViewController.swift
//  prinsta_pick
//
//  Created by apple on 10/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Photos
import FMPhotoPicker
import Popover

class BookCoverViewController: BaseViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TextSendToOtherScreenDelegate,EditImageDelegate {
   
    
    @IBOutlet weak var imageView_frame: UIImageView!
    
    @IBOutlet weak var imageView_cover: UIImageView!
    @IBOutlet weak var label_coverName: UILabel!
    @IBOutlet weak var view_cover: UIView!
    
    @IBOutlet weak var imageView_coverText: UIImageView!
    @IBOutlet weak var imageView_edit: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    
     @IBOutlet weak var btn_color_edit: UIButton!
    
    let picker = UIImagePickerController()
    var popover : Popover?
    
    var isChangeImage = false
    var category_type = ""
    var category_id = ""
    var sortType = ""
    var selectArray = [String]()
    var selectedAlbumPhoto = UIImage()
    var selectedCoverImage : String?
    var photo_cover_image : String?
    var book_type : String?
    var book_price : String?
    var book_color_id : String?
    
    var book_name : String?
    var book_name_font : String?
    var book_name_font_color : String?
    
    var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    
    let colorArray : [UIColor] = [.white,.blue,.green,.purple,.red,.gray]
    var selectedColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.text = "Edit Photobook Cover"
        self.setGradient()
      // self.bgImage.image = nil
        imageView_edit.image = UIImage(named : "color_change")
        imageView_coverText.image = UIImage(named : "text_change")
        view_cover.layer.cornerRadius = 0
        view_cover.layer.shadowRadius = 4
        view_cover.layer.shadowOpacity = 0.3
        view_cover.layer.shadowColor = UIColor.lightGray.cgColor
        view_cover.layer.shadowOffset = CGSize.zero
        view_cover.generateOuterShadow()
        btn_next.layer.cornerRadius = btn_next.frame.height/2
        btn_edit.layer.cornerRadius = btn_edit.frame.height/2
        btn_edit.clipsToBounds = true
        btn_next.clipsToBounds = true
        
        imageView_frame.image = self.selectedAlbumPhoto
        
        imageView_coverText.layer.cornerRadius  = imageView_coverText.frame.width/2
        imageView_coverText.clipsToBounds = true
        imageView_edit.layer.cornerRadius  = imageView_edit.frame.width/2
        imageView_edit.clipsToBounds = true
        imageView_coverText.backgroundColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        imageView_edit.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        picker.delegate = self
        btn_next.setTitle("Next", for: .normal)
        btn_edit.setTitle("Edit Cover", for: .normal)
        selectedColor = colorArray.first!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppHelper.delay(0.3) {
            self.setGradient()
        }
    }
    
    func setGradient() {
     
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        
        self.btn_edit.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
       
        let color3:UIColor = UIColor(red: 70.0/255.0, green: 230.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
   
        self.btn_next.backgroundColor = color4
        self.btn_next.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
    }
    
    
    //MARK : button actions
 
    @IBAction func btn_tap_textEdit(_ sender: Any) {
     
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "bookTextEditViewController") as! BookTextEditViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_tap_imageEdit(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "editImageViewController") as! EditImageViewController
        vc.editImageDelegate = self
        if let img = self.imageView_cover.image  {
            vc.editableImage = img
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.makeToast("Please select Cover Photo")
        }
    }
    
    //book color
    @IBAction func btn_tap_colorEdit(_ sender: Any) {
        
        if self.imageView_cover.image != nil  {
            let aView = UIView(frame: CGRect(x: 0, y: 0, width: (view?.frame.width)! - 80, height: 80))
            aView.backgroundColor = CustomColor.appThemeColor
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 70, height: 70)
            layout.minimumInteritemSpacing = 1
            layout.scrollDirection = .horizontal
            
          let  myTableView = UICollectionView(frame: CGRect(x: 0, y: 0, width:(view?.frame.width)! - 80, height: 80), collectionViewLayout: layout)
            myTableView.showsVerticalScrollIndicator = false
            myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.backgroundColor = .gray
            myTableView.showsHorizontalScrollIndicator = false
            
            myTableView.register(UINib(nibName: "ColorSelectCell", bundle: nil), forCellWithReuseIdentifier: "colorSelectCell")
            myTableView.backgroundColor = .clear
            aView.addSubview(myTableView)
            let options = [
                .type(.down),
                .cornerRadius(2),
                .animationIn(0.3),
                .blackOverlayColor(UIColor.clear),
                .arrowSize(CGSize(width: 10, height: 10))
                ] as [PopoverOption]
             popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
            popover!.show(aView, fromView: self.btn_color_edit)
        } else {
            self.makeToast("Please select Cover Photo")
        }
       
    }
    
    func getCustomImage(image: UIImage, isChangeImage : Bool) {
        self.imageView_cover.image = image
        self.isChangeImage  = isChangeImage
    }
    
    @IBAction func btn_tap_edit(_ sender: Any) {
        if let image = self.imageView_cover.image {
        let vc = FMImageEditorViewController(config: self.config(), sourceImage: image)
        vc.delegate = self
        
        self.present(vc, animated: true)
        } else {
            self.makeToast("Select A Cover Photo")
            
        }
    }
    
    @IBAction func btn_tapnext(_ sender: Any) {
        if self.imageView_cover.image != nil {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "organiseBookViewController") as! OrganiseBookViewController
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
        
        if !isChangeImage {
             vc.photo_cover_image_url = photo_cover_image
        }
        vc.cover_image = self.imageView_cover.image
        
        vc.sortType = sortType
        self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.makeToast("Please select A Photo Cover Image")
        }
    }
    
    @IBAction func btn_tap_imageCover(_ sender: Any) {
        let alertController = UIAlertController(title: "Select source type", message: "", preferredStyle: .actionSheet)
        
        // Create the actions
        let camera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.shootPhoto()
    
        }
        let photoLib = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.photoFromLibrary()
       
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
    
        }
        // Add the actions
        alertController.addAction(camera)
        alertController.addAction(photoLib)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // custom delegate
    func textDetailSendDelegate(CoverText : String, textColor : UIColor, fontName : String) {
        label_coverName.text = CoverText
        label_coverName.font = UIFont(name: fontName, size: 15.0)
        label_coverName.textColor = textColor
        book_name = CoverText
        book_name_font = fontName
        book_name_font_color = "\(textColor)"
    }
    //MARK:- Image picker delegate
    func photoFromLibrary() {
        Utilities.checkCameraPermission(completion: { (permsion:Bool) in
            
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            // picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        })
    }
    func shootPhoto() {
        Utilities.checkCameraPermission(completion: { (permsion:Bool) in
            if permsion {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker,animated: true,completion: nil)
                }
                else {
                    self.nocamera()
                }
            } else {
                let alert = UIAlertController(title: "Prinsta Pick", message: "Access Denied", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("dsfdsfdsfsdf")
            }
        })
    }
    
    func nocamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    //Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        print(info["UIImagePickerControllerOriginalImage"] ?? "4345")
        //
        //        let str = "\(info["UIImagePickerControllerOriginalImage"]!)"
        //
        //        let s = str.slice(from: "{", to: "}")
        //
        //        if let arr = s?.components(separatedBy: ","){
        //            if arr.count >= 2 {
        //                if Int(arr[0])! > 11000 {
        //                    picker.dismiss(animated:true, completion: nil)
        //                    self.makeToast("Invalid Image!!!")
        //                    return
        //                }
        //            }
        //        }
        print(info)
        if let image = info[.originalImage] as? UIImage {
            self.imageView_cover.image = image
           
            let identifier = (info[UIImagePickerController.InfoKey.phAsset] as? PHAsset)?.localIdentifier
            print("ffffffffffffffffff \(identifier!)")
        self.photo_cover_image = identifier
        }
        picker.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
 

}


extension BookCoverViewController : FMPhotoPickerViewControllerDelegate, FMImageEditorViewControllerDelegate {
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
          imageView_cover.image = photo
        isChangeImage = true
    }
    
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
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
            FMCrop.ratioSquare,
//            FMCrop.ratioCustom,
//            FMCrop.ratio4x3,
//            FMCrop.ratio16x9,
//            FMCrop.ratioOrigin,
        ]
        
        // all available filters will be used
        config.availableFilters = []
        
        
        return config
    }
    
    
}


extension BookCoverViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: "colorSelectCell", for: indexPath) as! ColorSelectCell
        cell.view_color.backgroundColor = colorArray[indexPath.item]
      cell.view_color.cornerRadius = cell.view_color.frame.width/2
        cell.view_color.clipsToBounds = true
        
        if selectedColor == colorArray[indexPath.item] {
             cell.view_color.borderColor = CustomColor.appThemeColor
             cell.view_color.layer.borderWidth = 3.0
        } else {
            cell.view_color.borderColor = .clear
            cell.view_color.layer.borderWidth = 0.0
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       selectedColor = colorArray[indexPath.item]
        collectionView.reloadData()
        AppHelper.delay(1.0) {
               self.popover?.dismiss()
        }
     
    }
}
