//
//  BaseViewController.swift
//  Panther
//
//  Created by Manish Jangid on 8/3/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import UIKit
import Toast
import SVProgressHUD
import Alamofire




class BaseViewController: UIViewController {
    
    fileprivate var mScrollView : UIScrollView? = nil
    
    var navTitle: UILabel!
  
    let leftButton = UIButton()
    
    var ischeckforFilter = false
    var tapGesture: UITapGestureRecognizer!

    let bgImage : UIImageView = UIImageView()
    var isAddressTableView:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
      //  navigationBarAppearace.barTintColor = CustomColor.lightBrownColor
        navigationBarAppearace.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.navigationItem.backBarButtonItem?.title = nil
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        //self.navigationItem.backBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
       
        bgImage.frame =  UIScreen.main.bounds
        bgImage.contentMode = .scaleAspectFill
        bgImage.clipsToBounds = true
        self.view.addSubview(bgImage)
        self.view.sendSubviewToBack(bgImage)
        
    
        
       // appDelegate.window?.addSubview(hud)
        
        
        leftButton.frame =  CGRect(x: -10, y: 0, width: 40, height: 40)
        leftButton.addTarget(self, action: #selector(menuClicked), for: UIControl.Event.touchUpInside)
        leftButton.contentMode = .scaleAspectFit
        leftButton.backgroundColor = .clear
        leftButton.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: leftButton)
        
        
//        let shoppingButton   = UIBarButtonItem(image: UIImage(named: "Shopping_cart"),  style: .plain, target: self, action: #selector(shoppingbuttonclicked))
//        let notificationButton = UIBarButtonItem(image: UIImage(named: "Notification"),  style: .plain, target: self, action: #selector(notificationbuttonclicked))
//        let catagoryButton = UIBarButtonItem(image: UIImage(named: "Notification"),  style: .plain, target: self, action: #selector(catagoryButtonCicked(button:)))
        
//        if UserDefaults.standard.value(forKey: ServiceKeys.keyUserId) != nil {
//         navigationItem.rightBarButtonItems = [notificationButton, shoppingButton ,catagoryButton]
//        }
//        else {
//           navigationItem.rightBarButtonItems = [ shoppingButton ,catagoryButton]
//        }
        
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right:0)

        

        navTitle = UILabel()
        navTitle.frame = CGRect(x: 0, y: 0, width:180, height: 44)
        navTitle.numberOfLines = 2
        navTitle.textAlignment = NSTextAlignment.center
        navTitle.text = ""
        navTitle.textColor = UIColor.black
        navTitle.font = CustomFont.boldfont21
       
        navTitle.backgroundColor = .clear
        navTitle.textAlignment = .center
        self.navigationItem.titleView = navTitle
        
        navTitle.center = (self.navigationItem.titleView?.center)!
        // display toast with an activity spinner
        //self.view.makeToastActivity(.center)
        
    
        
//        if let navigationContoller = self.navigationController {
//            if navigationContoller.viewControllers.count == 1 {
//                appDelegate.tabBarController.tabBar.isHidden = false
//            }
//            else {
//                appDelegate.tabBarController.tabBar.isHidden = true
//            }
//        }
//       if self.navigationController?.restorationIdentifier == "LSViewController" {
//
//        } else {
//            appDelegate.currentNavController = self.navigationController
//        }
       // appDelegate.currentNavController = self.navigationController
    }
    
    
        
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
//
//   func shoppingbuttonclicked() {
//    self.makeToast("underworking")
//    }
//    func notificationbuttonclicked() {
//          self.makeToast("underworking")
//    }
//    func catagoryButtonCicked(button : UIButton) {
//        let storyboard = UIStoryboard(name: "Category", bundle: nil)
//        let catvc = storyboard.instantiateViewController(withIdentifier: "categoryVC") as! CategoryVC
//        self.navigationController?.pushViewController(catvc, animated: true)
//    }
    
    @objc func menuClicked () {
        
             self.navigationController?.popViewController(animated: true)
    }
    
    func isShowMenuIcon() -> Bool {
        return true
    }
    func backBtnTapped() {
     //    appDelegate.tabBarController.tabBar.isHidden = false

        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        if let viewControllers = navigationController?.viewControllers {
//            for viewController in viewControllers {
//                // some process
//                if viewController.isKind(of: ViewController.self) || viewController.isKind(of: SignInViewController.self)
//                {
//                     navigationController?.navigationBar.isTranslucent = true
//                     navigationController?.navigationBar.isHidden = true
//                    bgImage.isHidden = false
//                } else {
//                    navigationController?.navigationBar.isHidden = false
//                    bgImage.isHidden = true
//                    if let img = applyNavGradient(colours: [CustomColor.lightblueColor, CustomColor.blueColor]) {
//                        navigationController?.navigationBar.barTintColor = UIColor(patternImage: img)
//
//                    }
//                }
//            }
//        }

            if bgImage.image != ThemeManager.sharedInstance.backgroundImage {
                bgImage.image = ThemeManager.sharedInstance.backgroundImage
            } else {
                bgImage.image = UIImage(named:"background")
            }
        
        
     
//
        // Add observer for keyborad Show/Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        
//        if let navigationContoller = self.navigationController {
//            if navigationContoller.viewControllers.count == 1 {
//
//                appDelegate.tabBarController.tabBar.isHidden = false
//            }
//            else {
//                appDelegate.tabBarController.tabBar.isHidden = true
//            }
//        }
//        if self.navigationController?.restorationIdentifier == "LSViewController" {
//
//        } else {
//            appDelegate.currentNavController = self.navigationController
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    
    func setupEntryField(fields:[SkyFloatingLabelTextField]){
        for field in fields {
            field.placeholderColor = .gray
            field.selectedTitleColor = CustomColor.appThemeColor
            field.lineColor = .gray
            field.selectedLineColor = CustomColor.appThemeColor
        }
    }
    
    // register scroll view
    func registerScrollView(_ scrollView : UIScrollView)
    {
        mScrollView = scrollView
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = true
        mScrollView?.addGestureRecognizer(tapGesture!)
        
        mScrollView?.showsVerticalScrollIndicator = false
        mScrollView?.showsHorizontalScrollIndicator = false
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    func makeToast(_ txt: String){
        self.view.hideToasts()
        CSToastManager.sharedStyle()?.backgroundColor = CustomColor.appThemeColor
        self.view.makeToast(txt, duration: 1.5, position: "CSToastPositionCenter")
        
       
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
        // Remove observer for keybord Show/Hide
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
         self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
 
    @objc func keyboardWillShow (notification : NSNotification)
    {
        
        if mScrollView == nil
        {
            return
        }
        
        if tapGesture == nil {
            if(self.isAddressTableView) {
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                // prevents the scroll view from swallowing up the touch event of child buttons
                tapGesture.cancelsTouchesInView = true
                mScrollView?.addGestureRecognizer(tapGesture)
            }
            
        }
        
        // adjust screen size on appearing keyboard
     //   let kbSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
//        if let activeField = findFirstResponder(view: mScrollView!)
//        {
//            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0);
//            mScrollView!.contentInset = contentInsets
//            mScrollView!.scrollIndicatorInsets = contentInsets
//
//            var aRect = self.view.frame
//            aRect.size.height -= kbSize!.height
//            if (!aRect.contains(activeField.frame.origin) ) {
//                mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
//            }
//        }
        
        // adjust screen size on appearing keyboard
        //UIKeyboardFrameEndUserInfoKey
        var kbSize:CGRect!
        
        if #available(iOS 11.0, *) {
            kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        }else {
            kbSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        }
        
        if let activeField = findFirstResponder(view: mScrollView!)
        {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize!.height, right: 0.0);
            mScrollView!.contentInset = contentInsets
            mScrollView!.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            if kbSize!.height == 0 {
                aRect.size.height -= 226
            }else {
                aRect.size.height -= kbSize!.height
            }
            
            print(aRect)
            print(kbSize!.height)
            if #available(iOS 11.0, *) {
                mScrollView!.scrollRectToVisible(aRect, animated: true)
            } else {
                if (!aRect.contains(activeField.frame.origin) ) {
                    mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHide (notification : NSNotification)
    {
        if mScrollView == nil
        {
            return
        }
//        if tapGesture != nil {
//            mScrollView?.removeGestureRecognizer(tapGesture)
//            tapGesture = nil
//        }
        
        // adjust screen size on Hiding keyboard
        var contentInset = mScrollView!.contentInset
        contentInset.bottom = 0
        mScrollView!.contentInset = contentInset
        mScrollView!.scrollIndicatorInsets = contentInset
        
      
        
    }
    func findFirstResponder(view : UIView) -> UIView?
    {
        if view.isFirstResponder
        {
            return view
        }
        else
        {
            for subView in view.subviews
            {
                let responder: UIView? = findFirstResponder(view: subView )
                if responder != nil
                {
                    return responder
                }
            }
        }
        return nil
    }
    
    //hud show and hide
    
    func hudShow()  {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    func hudHide()  {
        SVProgressHUD.dismiss()
    }
    
    func callLogOutApi() {
        
        self.hudShow()
        var params = [String : Any]()
   //     params["token"] = AppHelper.getStringForKey(ServiceKeys.token)
        
        ServiceClass.sharedInstance.hitserviceforLogout(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            
            print_debug("response: \(parseData)")
            
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                print(parseData)
                
                //                if let bundle = Bundle.main.bundleIdentifier {
                //                    UserDefaults.standard.removePersistentDomain(forName: bundle)
                //                }
              //  appDelegate.openDashBoard(isRemoveKey: true)
            }
            else {
                
                self.view.makeToast((errorDict?[ServiceKeys.keyErrorMessage] as? String)!, duration: 2.0, position: "CSToastPositionCenter")
                
            }
        })
    }

}
