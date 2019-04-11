//
//  AppDelegate.swift
//  prinsta_pick
//
//  Created by Pankaj Jangid on 29/10/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit
import CoreData
import Photos
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?
    var currentNavController:UINavigationController?
    
    var navigationController:UINavigationController?
    let tabBarController = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let stry = UIStoryboard(name: "Main", bundle: nil)
//        let vc1 = stry.instantiateViewController(withIdentifier: "vc") as! ViewController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vc1
        
       openHome()
        foundAlbum(name: "prinsta_pick")
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
       func openUserScreen(_ user : User?){
        
    }
    
    
    
    
    func openHome(){
        
        let storyBoard  = UIStoryboard(name: "Home", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        let nv1 = UINavigationController(rootViewController: vc1)
        // nv1.restorationIdentifier = "gigListViewController"
        
        var nv2 : UINavigationController!
      
            let vc2 = storyBoard.instantiateViewController(withIdentifier: "prinstaHomeViewController") as! PrinstaHomeViewController
            //  vc2.isvenueType
            nv2 = UINavigationController(rootViewController: vc2)
            //  nv2.restorationIdentifier = "myPostedViewController"
      
        
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        let nv3 = UINavigationController(rootViewController: vc3)
        
        //  nv3.restorationIdentifier = "communityViewController"
         let storyBoardMain  = UIStoryboard(name: "Main", bundle: nil)
        let vc4 = storyBoardMain.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        let nv4 = UINavigationController(rootViewController: vc4)
        //   nv4.restorationIdentifier = "chatsListViewController"
        
       
       
        let vc5 = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        let nv5 = UINavigationController(rootViewController: vc5)
        // nv5.restorationIdentifier = "logoutViewController"
        
        
        nv1.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        nv2.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "shopping-cart"), selectedImage: UIImage(named: "shopping-cart"))
        nv3.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        nv4.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        nv5.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settings"))
        
        nv1.tabBarItem.title = ""
        nv2.tabBarItem.title = ""
        nv3.tabBarItem.title = ""
        nv4.tabBarItem.title = ""
        nv5.tabBarItem.title = ""
        
        var bottomSpace : CGFloat = -10
        var topSpace : CGFloat = 0
        
        if #available(iOS 11.0, *) {
            bottomSpace  = -10
            topSpace = 0
        }else {
            bottomSpace  = -5
            topSpace = 5
        }
        
        nv1.tabBarItem.imageInsets = UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
        nv2.tabBarItem.imageInsets = UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
        nv3.tabBarItem.imageInsets = UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
        nv4.tabBarItem.imageInsets = UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
        nv5.tabBarItem.imageInsets = UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0)
        
setupMiddleButton()
        
        tabBarController.tabBar.shadowImage = nil
        tabBarController.delegate = self
        tabBarController.viewControllers = [nv1, nv2, nv3, nv4, nv5]
        tabBarController.tabBar.tintColor = CustomColor.appThemeColor
        tabBarController.selectedIndex = 0
        
        if self.navigationController == nil {
            appDelegate.window?.rootViewController = tabBarController
        }else {
            self.navigationController?.present(tabBarController, animated: true, completion: {
                
            })
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
       
    }
    
    
        let menuButton = GradientLayer(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
    func setupMiddleButton() {
        
        var menuButtonFrame = menuButton.frame
       
      let modelName = UIDevice.modelName
        if modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XS Max" || modelName == "iPhone XR" || modelName == "Simulator iPhone XS Max"{
             menuButtonFrame.origin.y =  self.tabBarController.tabBar.frame.height - 100
        } else {
             menuButtonFrame.origin.y =  self.tabBarController.tabBar.frame.height - 70
        }
        
        menuButtonFrame.origin.x = (self.tabBarController.tabBar.frame.width)/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        menuButton.applyGradient(colours: [color1, color2], locations: [0.0, 0.5, 1.0,0.5])
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.clipsToBounds = true
        
        let imageview = UIImageView(frame: CGRect(x:  menuButton.frame.width/2 - 5, y:  menuButton.frame.height/2 - 4, width: (10), height: 7))
        imageview.image = UIImage(named : "white_camera")
        imageview.contentMode = .center
        menuButton.addSubview(imageview)
        
        self.tabBarController.tabBar.addSubview(menuButton)
        
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        
    }
    
    
     @objc func menuButtonAction(sender:UIButton) {
       print("min button")
        
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
       
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
         FBSDKAppEvents.activateApp()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       
    }

    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentContainer(name: "prinsta_pick")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func foundAlbum(name:String){
        let albumName = name
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = (collection.firstObject)!
            albumFound = true
        }
        else { albumFound = false
            createPhotoLibraryAlbum(name: name)
        }
    }
    
    func createPhotoLibraryAlbum(name: String) {
        var albumPlaceholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            // Request creating an album with parameter name
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            // Get a placeholder for the new album
            albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
        }, completionHandler: { success, error in
            if success {
                guard let placeholder = albumPlaceholder else {
                    fatalError("Album placeholder is nil")
                }
                
                let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                guard let album: PHAssetCollection = fetchResult.firstObject else {
                    // FetchResult has no PHAssetCollection
                    return
                }
                
                // Saved successfully!
                print(album.assetCollectionType)
                self.createPhotoOnAlbum(photo: UIImage(named: "logo_without_name")!, album: album)
            }
            else if let e = error {
                // Save album failed with error
            }
            else {
                // Save album failed with no error
            }
        })
    }
    
    
    
    // Swift 3.0
    func createPhotoOnAlbum(photo: UIImage, album: PHAssetCollection) {
        PHPhotoLibrary.shared().performChanges({
            // Request creating an asset from the image
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: photo)
            // Request editing the album
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album) else {
                // Album change request has failed
                return
            }
            // Get a placeholder for the new asset and add it to the album editing request
            guard let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else {
                // Photo Placeholder is nil
                return
            }
            albumChangeRequest.addAssets([photoPlaceholder] as NSArray)
        }, completionHandler: { success, error in
            if success {
                // Saved successfully!
            }
            else if let e = error {
                // Save photo failed with error
            }
            else {
                // Save photo failed with no error
            }
        })
    }

}

