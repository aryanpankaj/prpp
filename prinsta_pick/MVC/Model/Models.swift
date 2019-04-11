//
//  Models.swift
//  GigQwik
//
//  Created by KrishMac on 9/14/17.
//  Copyright © 2017 KrishMac. All rights reserved.
//

import Foundation

class User{
    
    var firstName : String!

    var email : String!
    var contactNumber : String!

    var token : String!
    var isProfileCreated : Bool!
    var profileImageUrl : String!
    var profileImageUrl_thumb : String!

  
    var userID:String!

    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        let json = parseData["data"]
        
      
//        firstName = json[ServiceKeys.first_name].stringValue
//        lastName = json[ServiceKeys.last_name].stringValue
//        email = json[ServiceKeys.email].stringValue
//        contactNumber = json[ServiceKeys.contact_number].stringValue
//        accountType = json[ServiceKeys.account_type].stringValue
//        token = json[ServiceKeys.token].stringValue
//       
    }
    
 
}



