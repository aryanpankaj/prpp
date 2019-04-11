//
//  PrintListViewController.swift
//  prinsta_pick
//
//  Created by apple on 23/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class PrintListViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var printListTableView : UITableView!
    
    var imageForSlider = ["testImage","testImage","testImage"]
    var cellNames = ["Print1","print2","Print3"]
    var pricesArray = ["12","13","19"]
    var pagesArray = ["5.8X23cm","5.8X23cm","5.8X23cm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
 printListTableView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
        printListTableView.delegate = self
        printListTableView.dataSource = self
        printListTableView.separatorStyle = .none
        self.navTitle.text = "Prints"
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
        let vc = storyBoard.instantiateViewController(withIdentifier: "printDetailViewController") as! PrintDetailViewController
        vc.print_type = cellNames[indexPath.row]
        vc.print_size = pagesArray[indexPath.row]
        vc.print_price = pricesArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }

}
