//
//  PhotoBooksListViewController.swift
//  prinsta_pick
//
//  Created by apple on 21/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class PhotoBooksListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var photoAlbumListView: UITableView!
    
    let imageForSlider = ["testImage","testImage","testImage"]
    let cellNames = ["Mini-Book","Landscape Photobook","Square Photobook"]
    let pricesArray = ["12","13","19"]
    let pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoAlbumListView.delegate = self
        photoAlbumListView.dataSource = self
        photoAlbumListView.separatorStyle = .none
        self.navTitle.text = "Photo Books"
        photoAlbumListView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
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
        return cellNames.count
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
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "photoBookDetailViewController") as! PhotoBookDetailViewController
        vc.book_type = cellNames[indexPath.row]
        vc.book_price = pricesArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            return 350
       
    }
    
    @objc func shareButtonClicked(sender : UIButton)  {
        print("Share")
    }
    
  

}
