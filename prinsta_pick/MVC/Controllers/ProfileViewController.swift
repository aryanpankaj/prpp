//
//  ProfileViewController.swift
//  prinsta_pick
//
//  Created by apple on 02/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bgimageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var imageView_profile: UIImageView!
    @IBOutlet weak var textField_userName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textField_email: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textField_phoneNumber: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textField_changePassword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btn_update: UIButton!
    @IBOutlet weak var btn_reset: UIButton!
    @IBOutlet weak var btn_logout: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradient()
        registerScrollView(scrollView)
        setupEntryField(fields : [textField_email,textField_userName,textField_phoneNumber,textField_changePassword])
        textField_email.placeholder = "E-mail"
        textField_userName.placeholder = "Username"
        textField_phoneNumber.placeholder = "Phone Number"
        textField_changePassword.placeholder = "Change Password"
        bgimageView.alpha = 0.3
        textField_userName.iconType = .image
        textField_userName.iconImage = UIImage(named: "user_light")
        textField_phoneNumber.iconType = .image
        textField_phoneNumber.iconImage = UIImage(named: "phone_light")
        textField_changePassword.iconType = .image
        textField_changePassword.iconImage = UIImage(named: "lock")
        textField_email.iconType = .image
        textField_email.iconImage = UIImage(named: "email_light")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        imageView_profile.image = UIImage(named: "Group 117")
        imageView_profile.layer.cornerRadius = imageView_profile.frame.height/2
        imageView_profile.clipsToBounds = true
        imageView_profile.layer.borderWidth = 4.0
        imageView_profile.layer.borderColor = CustomColor.appThemeColor.cgColor
        
        
        btn_update.layer.cornerRadius = 6.0
        btn_logout.layer.cornerRadius = 6.0
        btn_reset.layer.cornerRadius = 6.0
        btn_reset.borderWidth = 1
        btn_reset.borderColor = .gray
        btn_update.clipsToBounds = true
        btn_logout.clipsToBounds = true
        btn_reset.clipsToBounds = true
        
        textField_email.text = "pk@mailinator.com"
        textField_email.isUserInteractionEnabled = false
        textField_email.iconMarginBottom = 8.0
         textField_changePassword.iconMarginBottom = 8.0
         textField_phoneNumber.iconMarginBottom = 8.0
         textField_userName.iconMarginBottom = 8.0
        textField_userName.text = "pankaj jangid"
        textField_phoneNumber.text = "+916858685884"
        textField_changePassword.text = "changePassword"
        textField_changePassword.isSecureTextEntry = true
        textField_changePassword.textColor = .darkGray
         textField_email.textColor = .darkGray
        textField_changePassword.textColor = .darkGray
        
        textField_email.delegate = self
        textField_changePassword.delegate = self
        textField_phoneNumber.delegate = self
        textField_userName.delegate = self
        
    //    Utilities.setRightSideSliderView(field: textField_userName, value: true)
    //    Utilities.setRightSideSliderView(field: textField_email, value: false)
      //  Utilities.setRightSideSliderView(field: textField_phoneNumber, value: true)
      //  Utilities.setRightSideSliderView(field: textField_changePassword, value: true)
        self.leftButton.isHidden = true
        Utilities.setRightViewIcon(icon: UIImage(named: "right_arrow")!, field: textField_changePassword)
        profileView.layer.cornerRadius = 11
        profileView.layer.shadowRadius = 11
        profileView.layer.shadowOpacity = 0.3
        profileView.layer.shadowColor = UIColor.lightGray.cgColor
        profileView.layer.shadowOffset = CGSize.zero
        profileView.generateOuterShadow()
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
       
        self.btn_logout.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        
        //        Left RGB 70 230 146
        //        Right RGB 23 186 160
        let color3:UIColor = UIColor(red: 70.0/255.0, green: 230.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //      self.backgroundView.applyGradient(colours: [color1,color2])
        self.btn_update.backgroundColor = color4
        self.btn_update.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
    }

 //button actions
    
    @IBAction func btn_tap_update(_ sender: Any) {
        if checkValidation() {
            
        }
    }
    
    @IBAction func btn_tap_reset(_ sender: Any) {
    }
    
    @IBAction func btn_tap_logout(_ sender: Any) {
    }
    
    @IBAction func btn_userProfile_changed(_ sender: Any) {
        let alertController = UIAlertController(title: "Select source type", message: "", preferredStyle: .actionSheet)
        
        // Create the actions
        let camera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.shootPhoto()
            NSLog("OK Pressed")
        }
        let photoLib = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.photoFromLibrary()
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(camera)
        alertController.addAction(photoLib)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
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
        
        if let image = info[.originalImage] as? UIImage{
            self.imageView_profile.image = image
        }
        picker.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func checkValidation() -> Bool {
        self.view.endEditing(true)
        
        if(textField_userName.text!.isBlank){
            self.makeToast(err_fullName)
            return false
        }
        else if (textField_userName.text?.characters.count)! < 3 {
            self.makeToast(err_fullName_length)
            
            return false
        }
       
        else if(textField_phoneNumber.text!.isBlank){
            self.makeToast(err_phone)
            return false
        }
        else if (textField_phoneNumber.text?.characters.count)! < 6 || (textField_phoneNumber.text?.characters.count)! > 15  {
            self.makeToast(err_phone_length)
            return false
        }
        
        return  true
    }
    
    //MARK TextField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textField_changePassword {
            self.makeToast("go to change password")
         return false
        }
        return true
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
}
