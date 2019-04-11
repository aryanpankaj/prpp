//
//  WallDecorViewController.swift
//  prinsta_pick
//
//  Created by apple on 22/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit

class WallDecorViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var wallTableView: UITableView!
    
    let imageForSlider = ["testImage","testImage","testImage","testImage"]
    let cellNames = ["Posters","Frame","Canvases","Metallic Prints"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wallTableView.delegate = self
        wallTableView.dataSource = self
        wallTableView.separatorStyle = .none
        self.navTitle.text = "Wall Decor"
        // Do any additional setup after loading the view.
        wallTableView.backgroundColor = UIColor(red: 234.0/250.0, green: 234.0/250.0, blue: 234.0/250.0, alpha: 1.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageForSlider.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell", for: indexPath) as! SubCategoryTableViewCell
            cell.selectionStyle = .none
            cell.categoryImageView.image = UIImage(named :imageForSlider[row])
            cell.categoryImageView.layer.cornerRadius = 15.0
            cell.categoryImageView.clipsToBounds = true
            cell.categoryImageView.backgroundColor = .white
            cell.dataView.backgroundColor = .clear
            cell.databackView.layer.cornerRadius = 10.0
            cell.databackView.clipsToBounds = true
            cell.CategoryNameLabel.text = cellNames[row]
      
        cell.categoryImageView.layer.shadowRadius = 9
        cell.categoryImageView.layer.shadowOpacity = 0.3
        cell.categoryImageView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.categoryImageView.layer.shadowOffset = CGSize.zero
        cell.categoryImageView.generateOuterShadow()
        cell.dataView.layer.cornerRadius = 10
        cell.dataView.clipsToBounds = true
            return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyBoard = UIStoryboard(name: "Home", bundle: nil)
          let vc = storyBoard.instantiateViewController(withIdentifier: "posterTypeViewController") as! PosterTypeViewController
        switch indexPath.row {
        case 0:
          
            vc.posterType = "Posters"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            self.makeToast("Frames")
        case 2:
           vc.posterType = "Canvases"
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
           
            vc.posterType = "Metallic Prints"
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
            
        }
       

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 350
        
    }
    

}
