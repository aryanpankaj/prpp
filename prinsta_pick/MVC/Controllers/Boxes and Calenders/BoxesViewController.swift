//
//  BoxesViewController.swift
//  prinsta_pick
//
//  Created by apple on 23/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class BoxesViewController:BaseViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var boxTableView : UITableView!
    
    var imageForSlider = ["testImage","testImage","testImage"]
    var cellNames = ["Box1","Box2","Box3"]
    var pricesArray = ["12","13","19"]
    var pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
    var isBoxOrCalender = true
    override func viewDidLoad() {
        super.viewDidLoad()
         boxTableView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
        boxTableView.delegate = self
        boxTableView.dataSource = self
        boxTableView.separatorStyle = .none
        if isBoxOrCalender {
        self.navTitle.text = "Boxes"
        } else {
             imageForSlider = ["testImage","testImage","testImage"]
             cellNames = ["Calendars1","Calendars2","Calendars3"]
             pricesArray = ["12","13","19"]
             pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
            self.navTitle.text = "Calendars"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageForSlider.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoBookListCell", for: indexPath) as! PhotoBookListCell
        cell.selectionStyle = .none
        cell.bookImageView.image = UIImage(named :imageForSlider[row])
        cell.numberPageLabel.text = pagesArray[row]
        cell.nameLabel.text = cellNames[row]
        cell.priceLabel.text = "$\(pricesArray[row])"
        
        cell.startingLabel.text = "Starting At"
        
//        cell.shareButton.tag = row
//        cell.shareButton.addTarget(self, action: #selector(BoxesViewController.shareButtonClicked(sender:)), for: .touchUpInside)
        
        return cell

        
    }
    
    @objc func shareButtonClicked(sender : UIButton)  {
        print("Share")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Photo", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assetsPickerController") as! AssetsPickerController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }
    
}
