//
//  InstaWebViewController.swift
//  PICMOB
//
//  Created by KrishMac on 10/30/18.
//  Copyright © 2018 Mohit Singh. All rights reserved.
//

import UIKit
import InstagramKit

protocol GetInstaUserDataDelegate {
    func getUserDataForInstagram(access : String)
}

class InstaWebViewController: BaseViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    var delegate : GetInstaUserDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    webView.delegate = self
        let auth = InstagramEngine.shared().authorizationURL()
        self.webView.loadRequest(URLRequest(url: auth))
        
        getUserDetails()
        
    }
    func getUserDetails(){
        
        InstagramEngine.shared().getSelfUserDetails(success: { (user) in
            print("User:\(user.fullName ?? "")\nProfile:\(user.profilePictureURL?.absoluteString ?? "")")
            
        }, failure: { (error, code) in
            print(error.localizedDescription)
        })
        
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension InstaWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
    
    do {
        if let url = request.url {
            if (String(describing: url).range(of: "access") != nil){
                try InstagramEngine.shared().receivedValidAccessToken(from: url)
                
                if let accessToken = InstagramEngine.shared().accessToken {
                    NSLog("accessToken: \(accessToken)")
                    delegate?.getUserDataForInstagram(access: "\(accessToken)")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    } catch let err as NSError {
        print(err.debugDescription)
    }
    return true
}
}
