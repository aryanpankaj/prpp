//
//  SignUpViewController.swift
//  prinsta_pick
//
//  Created by apple on 07/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class SignUpViewController: BaseViewController,TTTAttributedLabelDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var signUpButon: UIButton!
    @IBOutlet weak var pancilImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var termsLabel: TTTAttributedLabel!
    
    @IBOutlet weak var designView: UIView!
    
    var isCheckForTick = false
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerScrollView(scrollView)
        self.navTitle.text = "Sign Up"
        self.navTitle.textColor = .black
        nameField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        passwordField.delegate = self
        confirmField.delegate = self
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor //CustomColor.appThemeColor.cgColor //
       
        profileImageView.layer.shadowRadius = 10
        profileImageView.layer.shadowOpacity = 0.1
        profileImageView.layer.shadowColor = UIColor.lightGray.cgColor
        profileImageView.layer.shadowOffset = CGSize.zero
        profileImageView.generateOuterShadow()
        self.setGradient()
        signUpButon.layer.cornerRadius = 5
        signUpButon.clipsToBounds = true
        picker.delegate = self
        passwordField.isSecureTextEntry = true
        confirmField.isSecureTextEntry = true
        Utilities.setleftViewIcon(icon: UIImage(named: "user")!, field: nameField)
        Utilities.setleftViewIcon(icon: UIImage(named: "lock_dark")!, field: passwordField)
        Utilities.setleftViewIcon(icon: UIImage(named: "phone")!, field: phoneNumberField)
        Utilities.setleftViewIcon(icon: UIImage(named: "email")!, field: emailField)
        Utilities.setleftViewIcon(icon: UIImage(named: "lock_dark")!, field: confirmField)
        let strTerms : NSString = "Agree to the Terms & Conditions"
        
        termsLabel.delegate = self
        termsLabel.text = strTerms as String
        let range : NSRange = strTerms.range(of: "Terms & Conditions")
        termsLabel.addLink(to: URL(string: "http://Terms")!, with: range)
        
        designView.backgroundColor = .clear//CustomColor.appThemeColor
       
       
        pancilImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppHelper.delay(0.3) {
            self.setGradient()
            self.designView.addDashedBorder()
        }
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        
        if url.absoluteString == "http://Terms"{
            
//            let loginStoryBoard  = UIStoryboard(name: "TermsCondition", bundle: nil)
//            let vc = loginStoryBoard.instantiateViewController(withIdentifier: "termsConditionViewController") as! TermsConditionViewController
//            vc.url = "http://Terms"
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {
            
            
        }
        
    }
    func setGradient() {
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //      self.backgroundView.applyGradient(colours: [color1,color2])
        self.signUpButon.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
    }
    
    @IBAction func imageButtonClicked(_ sender: Any) {
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
    
    @IBAction func tickButtonClicked(_ sender: Any) {
        if isCheckForTick {
            isCheckForTick = false
            tickImageView.image = UIImage(named: "logo1")
            
        } else {
            tickImageView.image = UIImage(named: "logo")
            isCheckForTick = true
        }
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if checkValidation() {
            //call api
            self.makeToast("goooooood")
        }
    }
    
    
    //MARK;- Image Picker Delegates
    
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
            self.profileImageView.image = image
        }
        picker.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func checkValidation() -> Bool {
        self.view.endEditing(true)
        
        if(nameField.text!.isBlank){
            self.makeToast(err_fullName)
            return false
        }
       else if (nameField.text?.characters.count)! < 3 {
            self.makeToast(err_fullName_length)
            
            return false
        }
       else if(emailField.text!.isBlank){
            self.makeToast(err_email)
            return false
        }
        else if(!emailField.text!.isEmail)
        {
            self.makeToast(err_valid_email)
            
            return false
        }
        else if(phoneNumberField.text!.isBlank){
            self.makeToast(err_phone)
            return false
        }
        else if (phoneNumberField.text?.characters.count)! < 6 || (phoneNumberField.text?.characters.count)! > 15  {
            self.makeToast(err_phone_length)
            return false
        }
        
        else if(passwordField.text!.isBlank){
            self.makeToast(err_password)
            return false
        }
        
        else if (passwordField.text?.characters.count)! < 6 {
            self.makeToast("Password should be minimum 6 characters")
            return false
        }
        else if(confirmField.text!.isBlank){
            self.makeToast("Confirm \(err_password)")
            return false
        }
        
       else if (confirmField.text?.characters.count)! < 6 {
            self.makeToast("Confirm Password should be minimum 6 characters")
            return false
        }
        
       else if !isCheckForTick {
            self.makeToast("check")
            return false
        }
        
        return  true
    }
    
    
    //MARK TextField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            textField.keyboardType = .default
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            textField.keyboardType = .emailAddress
            phoneNumberField.becomeFirstResponder()
        }else  if textField == phoneNumberField {
            textField.keyboardType = .numberPad
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            textField.keyboardType = .default
            confirmField.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
            //call api
        }
        
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == nameField {
            nameField.layer.borderColor = UIColor.darkGray.cgColor
            emailField.layer.borderColor = UIColor.lightGray.cgColor
            phoneNumberField.layer.borderColor = UIColor.lightGray.cgColor
            passwordField.layer.borderColor = UIColor.lightGray.cgColor
            confirmField.layer.borderColor = UIColor.lightGray.cgColor
            
        } else if textField == emailField {
            nameField.layer.borderColor = UIColor.lightGray.cgColor
            emailField.layer.borderColor = UIColor.darkGray.cgColor
            phoneNumberField.layer.borderColor = UIColor.lightGray.cgColor
            passwordField.layer.borderColor = UIColor.lightGray.cgColor
            confirmField.layer.borderColor = UIColor.lightGray.cgColor
        }else  if textField == phoneNumberField {
            nameField.layer.borderColor = UIColor.lightGray.cgColor
            emailField.layer.borderColor = UIColor.lightGray.cgColor
            phoneNumberField.layer.borderColor = UIColor.darkGray.cgColor
            passwordField.layer.borderColor = UIColor.lightGray.cgColor
            confirmField.layer.borderColor = UIColor.lightGray.cgColor
        }else if textField == passwordField {
            nameField.layer.borderColor = UIColor.lightGray.cgColor
            emailField.layer.borderColor = UIColor.lightGray.cgColor
            phoneNumberField.layer.borderColor = UIColor.lightGray.cgColor
            passwordField.layer.borderColor = UIColor.darkGray.cgColor
            confirmField.layer.borderColor = UIColor.lightGray.cgColor
        }
        else {
            nameField.layer.borderColor = UIColor.lightGray.cgColor
            emailField.layer.borderColor = UIColor.lightGray.cgColor
            phoneNumberField.layer.borderColor = UIColor.lightGray.cgColor
            passwordField.layer.borderColor = UIColor.lightGray.cgColor
            confirmField.layer.borderColor = UIColor.darkGray.cgColor
            //call api
        }
        return true
    }
    
    
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "abcdefghijklmnopqrstuvwxyz0123456789_.@"
    let ACCEPTABLE_CHARACTERS_FOR_PASSWORD = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@#$^*()"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField {
            
            let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            if (string == filtered) == false{
                return false
            }
            return true
        }
        
        if textField == passwordField {
            let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_PASSWORD).inverted
            
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            if (string == filtered) == false{
                return false
            }
            if string ==  "\n"{
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
    
    

}
