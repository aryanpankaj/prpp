//
//  LoginViewController.swift
//  prinsta_pick
//
//  Created by apple on 06/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var faceBookButton: UIButton!
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var guestUserButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setGradient()
        userNameField.autocorrectionType = .no
        passwordField.autocorrectionType = .no
        userNameField.keyboardType = .emailAddress
        passwordField.isSecureTextEntry = true
        Utilities.setleftViewIcon(icon: UIImage(named: "user")!, field: userNameField)
        Utilities.setleftViewIcon(icon: UIImage(named: "lock_dark")!, field: passwordField)
        userNameField.delegate = self
        passwordField.delegate = self
        passwordField.returnKeyType = .go
        userNameField.returnKeyType = .next
        registerScrollView(scrollView)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.leftButton.isHidden = true
        userNameField.placeholder = "E-mail"
   
        
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
        self.loginButton.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        
//        Left RGB 70 230 146
//        Right RGB 23 186 160
        let color3:UIColor = UIColor(red: 70.0/255.0, green: 230.0/255.0, blue: 146.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 23.0/255.0, green: 186.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        //      self.backgroundView.applyGradient(colours: [color1,color2])
        self.guestUserButton.backgroundColor = color4
        self.guestUserButton.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
    }
    
 
        func checkValidation() -> Bool {
            self.view.endEditing(true)
            
            if(userNameField.text!.isBlank){
                self.makeToast(err_email)
                return false
            }
            if (userNameField.text?.characters.count)! < 4 {
                self.makeToast(err_length_userName)
                
                return false
            }
            if(!userNameField.text!.isEmail)
            {
                self.makeToast(err_valid_email)
                
                return false
            }
            
            if(passwordField.text!.isBlank){
                self.makeToast(err_password)
                return false
            }
            
//            if (passwordField.text?.characters.count)! < 6 {
//                self.makeToast("check")
//                return false
//            }
          
            return  true
        }
        
        //MARK TextField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            textField.keyboardType = .default
            passwordField.becomeFirstResponder()
        } else {
             self.view.endEditing(true)
            //call api
        }
       
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            userNameField.layer.borderColor = UIColor.darkGray.cgColor
            passwordField.layer.borderColor = UIColor.lightGray.cgColor
            
        } else {
            passwordField.layer.borderColor = UIColor.darkGray.cgColor
            userNameField.layer.borderColor = UIColor.lightGray.cgColor
        }
        return true
    }
    
    
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "abcdefghijklmnopqrstuvwxyz0123456789_.@"
    let ACCEPTABLE_CHARACTERS_FOR_PASSWORD = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@#$^*()"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameField {
            
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
    
    
    
    @IBAction func loginClicked(_ sender: Any) {
        if checkValidation() {
            loginApiCall()
        }
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = stry.instantiateViewController(withIdentifier: "signUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc1, animated: true)
        
    }
    
    @IBAction func instagramButtonClicked(_ sender: Any) {
    }
    @IBAction func faceBookClicked(_ sender: Any) {
        
    }
    
    @IBAction func guestUserClicked(_ sender: Any) {
     appDelegate.openHome()
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        
    }
    
    
    func loginApiCall() {
        self.hudShow()
        
        var userInfo : [String : Any] = [:]
      
        
        userInfo["email"] = self.userNameField.text
        userInfo["password"] = self.passwordField.text
        userInfo["device_token"] = AppHelper.getStringForKey(ServiceKeys.device_token)
        userInfo["device_type"] = "ios"
    
        
        
        ServiceClass.sharedInstance.hitServiceForEmailLogin(userInfo, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            
            self.hudHide()
            
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                let user = User(fromJson:parseData)
               
//                AppHelper.setStringForKey(user.country_id, key: ServiceKeys.country_id)
//                AppHelper.setStringForKey(user.country_name, key: ServiceKeys.country_name)
//
                
                self.dismiss(animated: false, completion: {
                })
                
                
                appDelegate.openUserScreen(user)
                
                
                
                
            } else {
                // AppHelper.showALertWithTag(0, title: txt_AppName, message:errorDict?[ServiceKeys.keyErrorMessage] as? String , delegate: self, cancelButtonTitle: "Ok", otherButtonTitle: nil)
                self.makeToast((errorDict?[ServiceKeys.keyErrorMessage] as? String)!)
            }
        })
    
    }
    
}
