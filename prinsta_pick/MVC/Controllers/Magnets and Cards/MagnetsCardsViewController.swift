//
//  MagnetsCardsViewController.swift
//  prinsta_pick
//
//  Created by apple on 23/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class MagnetsCardsViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var magnetTableView : UITableView!
    
    var imageForSlider = ["wel","wel1","wel2"]
    var cellNames = ["Magnets","Magnets","Magnets"]
    var pricesArray = ["12","13","19"]
    var pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
    var isMagnetOrCard = true
    override func viewDidLoad() {
        super.viewDidLoad()
         magnetTableView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
        magnetTableView.delegate = self
        magnetTableView.dataSource = self
        magnetTableView.separatorStyle = .none
        if isMagnetOrCard {
            self.navTitle.text = "Magnets"
        } else {
            imageForSlider = ["testImage","testImage","testImage"]
            cellNames = ["Cards","Cards","Cards"]
            pricesArray = ["12","13","19"]
            pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
            self.navTitle.text = "Cards"
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
//        cell.shareButton.addTarget(self, action: #selector(PhotoBooksListViewController.shareButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
        
        
    }
    
    @objc func shareButtonClicked(sender : UIButton)  {
        print("Share")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "magnetsCardsDetailViewController") as! MagnetsCardsDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }
    
}
