//
//  PosterTypeViewController.swift
//  prinsta_pick
//
//  Created by apple on 22/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//
//For poster and Canvase type
import UIKit

class PosterTypeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var posterTableView: UITableView!
    var imageForSlider = ["test","test","test"]
    var cellNames = ["Poster1","Poster2","Poster3"]
    var pricesArray = ["12","13","19"]
    var pagesArray = ["26 to 60 pages","40 to 60 pages","70 to 90 pages"]
    
    var posterType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterTableView.delegate = self
        posterTableView.dataSource = self
        posterTableView.separatorStyle = .none
         posterTableView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
        if posterType == "Posters"{
        self.navTitle.text = "Posters"
        } else if posterType == "Canvases"{
             imageForSlider = ["testImage","testImage"]
             cellNames = ["Can1 Classic","Canvase2 Regular"]
             pricesArray = ["12","13"]
             pagesArray = ["26 to 60 pages","40 to 60 pages"]
             self.navTitle.text = "Canvases"
        } else {
            imageForSlider = ["testImage","testImage"]
            cellNames = ["Clissic Metallic","Metallic Regular"]
            pricesArray = ["12","13"]
            pagesArray = ["26 to 60 pages","40 to 60 pages"]
            self.navTitle.text = "Metallic Prints"
        }
        // Do any additional setup after loading the view.
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
        if posterType == "Poster"  {
            self.makeToast("Poster type")
        } else {
            self.makeToast("Canvase type")
        }
        
        let storyBoard = UIStoryboard(name: "Photo", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assetsPickerController") as! AssetsPickerController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }

}
