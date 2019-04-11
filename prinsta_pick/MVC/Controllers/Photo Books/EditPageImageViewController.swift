//
//  EditPageImageViewController.swift
//  prinsta_pick
//
//  Created by apple on 23/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Photos
import PixelEngine
import PixelEditor
import FMPhotoPicker

protocol EditableImageDelegaate {
    func getNewEditableImages(editableImage : UIImage, for index : Int, foruniqueId identifier : String )
}

class EditPageImageViewController: BaseViewController {
    
    var editable_image : String?
    let allPhotosOptions = PHFetchOptions()
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var img_view_edit: UIImageView!
    @IBOutlet weak var image_view_adjust: UIImageView!
    
    @IBOutlet weak var image_view_filter: UIImageView!
    @IBOutlet weak var btn_confirm: UIButton!
    
    var index = Int()
    
    
    @IBOutlet weak var crope_image_imageView: UIImageView!
      var editableImageDelegate : EditableImageDelegaate?
    let color3:UIColor = UIColor(red: 70.0/255.0, green: 230.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    let color4:UIColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    
     var tmp_selected_image : UIImage?
    var photo_unique_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view_main.backgroundColor = .clear
        self.navTitle.text = "Edit Photo"
        // Do any additional setup after loading the view.
        crope_image_imageView.image = UIImage(named : "crop")
        image_view_adjust.image = UIImage(named : "controls")
        image_view_filter.image = UIImage(named : "funnel")
        crope_image_imageView.contentMode = .center
        image_view_adjust.contentMode = .center
        image_view_filter.contentMode = .center
        crope_image_imageView.tintColor = .white
        
        crope_image_imageView.layer.cornerRadius =  crope_image_imageView.frame.width/2
        crope_image_imageView.clipsToBounds = true
        crope_image_imageView.backgroundColor = color4
        
        image_view_adjust.layer.cornerRadius =  image_view_adjust.frame.width/2
        image_view_adjust.clipsToBounds = true
        image_view_adjust.backgroundColor = color4
        
        image_view_filter.layer.cornerRadius =  image_view_filter.frame.width/2
        image_view_filter.clipsToBounds = true
        image_view_filter.backgroundColor = color4
        
        self.setGradient()
        img_view_edit.contentMode = .scaleAspectFit
        btn_confirm.layer.cornerRadius = btn_confirm.frame.height/2
        btn_confirm.clipsToBounds = true
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        //  cell.label_counter.text = "\(indexPath.row + 1)"
        allPhotos.enumerateObjects({ photoAsset, idx, stop in
            
            
            if self.editable_image == photoAsset.localIdentifier {
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                options.isNetworkAccessAllowed = false
                //   options.resizeMode = .exact
                //   imageView_photo.contentMode = .scaleAspectFit
                PHImageManager.default().requestImage(for: photoAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options, resultHandler: { image, info in
                    if info?[PHImageErrorKey] == nil && !(info?[PHImageResultIsDegradedKey] as! Int != 0) {
                        
                        self.img_view_edit.image = image
                        self.tmp_selected_image = image
                    }
                })
            }
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bgImage.image = UIImage(named:"bg_sec")
        AppHelper.delay(0.3) {
            self.setGradient()
        }
    }
    
    func setGradient() {
       
        
        self.btn_confirm.backgroundColor = color4
        self.btn_confirm.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
       
        
        
    }
    
    @IBAction func btn_tap_crop_image(_ sender: Any) {
    
        if let image = self.img_view_edit.image {
            let vc = FMImageEditorViewController(config: self.config(), sourceImage: image)
            vc.delegate = self
            self.present(vc, animated: true)
        }
        
    }
    
    @IBAction func btn_tap_filter_image(_ sender: Any) {
        if let image = self.img_view_edit.image {
            let vc = FMImageEditorViewController(config: self.config(), sourceImage: image)
            vc.delegate = self
            self.present(vc, animated: true)
        }
        
    }
    @IBAction func btn_tap_adjust_image(_ sender: Any) {
        let controller = PixelEditViewController(image: self.img_view_edit.image!)
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        
        self.present(navigationController, animated: true, completion: nil)
        
    }

    
    @IBAction func btn_tap_confirm(_ sender: Any) {
        if self.img_view_edit.image != self.tmp_selected_image {
            self.saveImageToDocDirectory(self.img_view_edit.image!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension EditPageImageViewController : PixelEditViewControllerDelegate {
    
    func pixelEditViewController(_ controller: PixelEditViewController, didEndEditing editingStack: SquareEditingStack) {
        self.navigationController?.popToViewController(self, animated: true)
        self.dismiss(animated: true, completion: nil)
        let image = editingStack.makeRenderer().render(resolution: .full)
    self.img_view_edit.image = image
    }
    
    func pixelEditViewControllerDidCancelEditing(in controller: PixelEditViewController) {
        self.navigationController?.popToViewController(self, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension EditPageImageViewController : FMPhotoPickerViewControllerDelegate, FMImageEditorViewControllerDelegate {

    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.img_view_edit.image = photo
        
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
                        FMCrop.ratioCustom,
                        FMCrop.ratio4x3,
                        FMCrop.ratio16x9,
                        FMCrop.ratioOrigin,
        ]
        
        // all available filters will be used
        config.availableFilters = []
        
        
        return config
    }
    
    
}


extension EditPageImageViewController {
    
    func saveImageToDocDirectory(_ save_image : UIImage) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "\(Utilities.randomString(length: 7)).png"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
        // create the destination file url to save your image
      
        
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = save_image.jpegData(compressionQuality: 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
                
                print(fileURL)
                //                        let imageData  = cover_image!.jpegData(compressionQuality: 1.0)
                CustomPhotoAlbum.sharedInstance.saveImage(image: save_image)
                
                
                let sep_arr = "\(fileURL)".characters.split{$0 == "/"}.map(String.init)
                print(sep_arr)
                
                //                        userImages.setValue("\(sep_arr[6])/L0/001", forKey: "imagePath")
                // userImages.setValue("\(fileURL)", forKey: "imagePath")
                
                //delegate?.callEditImageList(image: "\(sep_arr[6])/L0/001", index: index, qty: newQty)
                
                self.photo_unique_id = "\(sep_arr[6])/L0/001"
                
                editableImageDelegate?.getNewEditableImages(editableImage: save_image, for: index, foruniqueId: "\(fileURL)" )
                
                
            } catch {
                print("error saving file:", error)
                self.makeToast("Not able to store image")
            }
        }
        
        
        
    }
}
