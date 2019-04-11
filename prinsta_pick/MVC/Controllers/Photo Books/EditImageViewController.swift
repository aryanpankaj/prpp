//
//  EditImageViewController.swift
//  prinsta_pick
//
//  Created by apple on 16/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

 protocol EditImageDelegate {
    func getCustomImage(image: UIImage,isChangeImage : Bool)
}

class EditImageViewController: BaseViewController {
    
    @IBOutlet weak var view_bottom: UIView!
    
    @IBOutlet weak var btn_confirm: UIButton!
    @IBOutlet weak var imageView_image: UIImageView!
    @IBOutlet weak var scrollVIew: UIScrollView!
    
    @IBOutlet weak var slider_contrast: UISlider!
    @IBOutlet weak var slider_saturation: UISlider!
    @IBOutlet weak var slider_brightness: UISlider!
    @IBOutlet weak var btn_rotateImage: UIButton!
    
    var editableImage : UIImage?
    var aCIImage = CIImage()
    var contrastFilter: CIFilter!
    var brightnessFilter: CIFilter!
    var saturationFilter: CIFilter!
    var context = CIContext()
    var outputImage = CIImage()
    var newUIImage = UIImage()
    
    var isChange = false
    
    var editImageDelegate : EditImageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.text = "Edit Photo"
        // Do any additional setup after loading the view.
        setGradient()
        imageView_image.contentMode = .scaleAspectFit
        view_bottom.layer.cornerRadius = 0
        view_bottom.layer.shadowRadius = 4
        view_bottom.layer.shadowOpacity = 0.3
        view_bottom.layer.shadowColor = UIColor.lightGray.cgColor
        view_bottom.layer.shadowOffset = CGSize.zero
        view_bottom.generateOuterShadow()
        slider_brightness.tag = 0
        slider_contrast.tag = 1
        slider_saturation.tag = 2
        
        slider_brightness.setThumbImage(UIImage(named:"like"), for: .normal)
        slider_brightness.setThumbImage(UIImage(named:"like"), for: .highlighted)
        slider_contrast.setThumbImage(UIImage(named:"like"), for: .normal)
        slider_contrast.setThumbImage(UIImage(named:"like"), for: .highlighted)
        slider_saturation.setThumbImage(UIImage(named:"like"), for: .normal)
        slider_saturation.setThumbImage(UIImage(named:"like"), for: .highlighted)
        
        slider_brightness.minimumValue = -1.0
        slider_contrast.minimumValue = -1.0
        slider_saturation.minimumValue = -1.0
        
        slider_brightness.maximumValue = 1.0
        slider_contrast.maximumValue = 1.0
        slider_saturation.maximumValue = 1.0
        
        slider_brightness.value = 0.0
        slider_contrast.value = 0.0
        slider_saturation.value = 0.0
        
        btn_confirm.layer.cornerRadius = 5.0
        btn_rotateImage.layer.cornerRadius = 2.0
        btn_confirm.clipsToBounds = true
        btn_rotateImage.clipsToBounds = true
        
        imageView_image.image = editableImage
         let aCGImage = editableImage?.cgImage
         aCIImage = CIImage(cgImage: aCGImage!)
        context = CIContext(options: nil)
        contrastFilter = CIFilter(name: "CIColorControls")
        contrastFilter.setValue(aCIImage, forKey: "inputImage")
        brightnessFilter = CIFilter(name: "CIColorControls")
        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
        saturationFilter = CIFilter(name: "CIColorControls")
        saturationFilter.setValue(aCIImage, forKey: "inputImage")
        
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
        
        self.btn_confirm.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        
        let color3:UIColor = UIColor(red: 70.0/255.0, green: 230.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        
        self.btn_rotateImage.backgroundColor = color4
        self.btn_rotateImage.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
    }
    
    
    @IBAction func tap_btn_confirm(_ sender: Any) {
        self.editImageDelegate?.getCustomImage(image: imageView_image.image!, isChangeImage: isChange)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tap_btn_rotate_image(_ sender: Any) {
        self.imageView_image.image = self.imageRotatedByDegrees(oldImage: self.imageView_image.image!, deg: 90.0)
        isChange = true
        let aCGImage = self.imageView_image.image?.cgImage
        aCIImage = CIImage(cgImage: aCGImage!)
//        context = CIContext(options: nil)
//        contrastFilter = CIFilter(name: "CIColorControls")
//        contrastFilter.setValue(aCIImage, forKey: "inputImage")
//        brightnessFilter = CIFilter(name: "CIColorControls")
//        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
//        saturationFilter = CIFilter(name: "CIColorControls")
//        saturationFilter.setValue(aCIImage, forKey: "inputImage")
        
    }
    
    @IBAction func slider_valueChanged(_ sender: UISlider) {
        isChange = true
        if (sender as AnyObject).tag == 0{
            //Brightness
            
            brightnessFilter.setValue(NSNumber(value: Float((sender).value)), forKey: "inputBrightness")
            outputImage = brightnessFilter.outputImage!
            let imageRef = context.createCGImage(outputImage, from: outputImage.extent)
            newUIImage = UIImage(cgImage: imageRef!)
            imageView_image.image = newUIImage
            
        }
        else if (sender as AnyObject).tag == 1{
            //Contrast
            
            contrastFilter.setValue(NSNumber(value: Float((sender).value)), forKey: "inputContrast")
            outputImage = contrastFilter.outputImage!;
            let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
            newUIImage = UIImage(cgImage: cgimg!)
            imageView_image.image = newUIImage
            
        }
        else if (sender as AnyObject).tag == 2{
            //Saturation
            saturationFilter.setValue(NSNumber(value: Float(sender.value)), forKey: "inputSaturation")
            outputImage = saturationFilter.outputImage!;
            let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
            newUIImage = UIImage(cgImage: cgimg!)
            imageView_image.image = newUIImage
        }
    }
 
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    
    
}
