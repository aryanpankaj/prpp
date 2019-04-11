//
//  Defines.swift
//  Panther
//
//  Created by Manish Jangid on 7/27/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import Foundation
import UIKit


public enum PrintingType : String {
    
    case Photobooks = "Photobooks"
    case Wall_Decor = "Wall Decor"
    case Prints = "Prints"
    case Boxes = "Boxes"
    case Calenders = "Calenders"
    case Magnets = "Magnets"
    case Cards = "Cards"
    case Gift_Cards = "Gift Cards"
}

// MARK : GLOBAL Functions
func print_debug <T> (_ object:T)
{
    print(object)
}

let DateFormat_yyyy_mm_dd_hh_mm_ss_sss = "yyyy-MM-dd HH:mm:ss"

let DateFormat_yyyy_mm_dd_hh_mm_ss_0000 = "yyyy-MM-dd HH:mm:ss +0000"
let output_format_HH_mm_ss = "HH:mm:ss  MMM dd yyy"
let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct databaseKeys{
    
    static let sizeName = "sizeName"
    static let sizeId = "sizeId"
    static let RegularQty = "qty"
    static let RegularPrice = "price"
    static let paperName = "paperName"
    static let paperId = "paperId"
    static let id = "id"
    static let frameName = "frameName"
    static let frameId = "frameId"
    static let order_id = "order_id"
    static let parameterSelect =  "parameterSelect"
    static let RegularCart = "RegularCart"
    static let GiftCart = "GiftCart"
    static let PhotoAlbum = "PhotoAlbum"
    static let PrintFrame = "PrintFrame"
    
    static let fitPaper = "Fit Paper"
    static let whiteFrame = "White Frame"
    static let fitPicture = "Fit Picture"
    
    static let cartCount = "cartCount"
    static let isGuest = "isGuest"
}

//MARK:- Service Keys

struct ServiceKeys{
 
    
    static let user_id = "user_id"
    
    static let clock_in = "clock_in"
    static let clock_out = "clock_out"
    static let punchInTime = "punchInTime"
    static let ischeckForClick = "ischeckForClick"
    static let isCheckForClockOut = "isCheckForClockOut"
     static let userIntrectionCheck =  "userIntrectionCheck"
    
    static let dateFormat = "date_formate"
    static let timeFormat = "time_formate"
    static let keyToken = "token"
    static let device_token = "device_token"
    static let keyUserName = "user_name"
    static let name = "name"
     static let key_employee_id = "employee_id"
         static let key_post = "post"
   
    static let profile_image = "profile_image"
    static let keyContactNumber = "contact_number"
    static let keyProfileImage = "image_url"
   
    static let keyErrorCode = "errorCode"
    static let keyErrorMessage = "errMessage"
    static let keyUserType = "user_type"
    
   
    static let keyEmail = "email"
   
    static let keyContactEmail = "email"
    static let keyContactPhoneNumber = "phone_number"
      static let keyContactZip = "zip_code"
     static let keyContactDealer_id = "dealer_id"
    
  
    static let keyStatus =  "status"
    static let KeyAccountName = "account_name"
   
    static let address = "address"
   
    static let KeyPushNotificationDeviceToken = "KeyPushNotificationDeviceToken"
    static let KeyCarComparison = "KeyCarComparison"
    static let KeyCarFavourite = "KeyCarFavourite"
}

struct ServiceUrls
{
    static let baseUrl = "http://xsdemo.com/worldauto/api/"


//    static let baseUrl = "http://xsdemo.com/metrocontents/api/"

    static let signUp = "register/register"
    static let register_without_password = "register/register_without_password"
    static let logIn = "users/login"
    static let logout = "users/logout"
   static let forgot_password = "users/forgot_password"
    static let get_new_car = "car/get_new_car"
    static let get_type_detail = "car/get_type_detail"
    static let get_type_images = "car/get_type_images"
    static let get_manufacturer = "car/get_manufacturer"
    static let get_model = "car/get_model"
    static let get_types = "car/get_types"
    static let getFavouriteCars = "car/getFavouriteCars"
}
struct ErrorCodes
{
    static let    errorCodeInternetProblem = -1 //Unable to update use
    
    static let    errorCodeSuccess = 1 // 'Process successfully.'
    static let    errorCodeFailed = 2 // 'Process failed.
}


struct CustomColor{
    
   //  242 122 132
    //165,201,58
    static let appThemeColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
   
    static let darkTextColorTheme = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let text_Color_White = UIColor.white
       static let nav_color = UIColor.white
     //42,59,163
static let darkBlue = UIColor(red: 42.0/255.0, green: 59.0/255.0, blue: 163.0/255.0, alpha: 1.0)
    static let customGreenColor = UIColor(red: 165.0/255.0, green: 201.0/255.0, blue: 58.0/255.0, alpha: 1.0)
}


struct CustomFont {
    static let boldfont21 = UIFont(name: "Raleway-Bold", size: 21)!
    static let boldfont18 =  UIFont(name: "Raleway-Bold", size: 18)!
     static let boldfont25 = UIFont(name: "Raleway-Bold", size: 25)!
}






