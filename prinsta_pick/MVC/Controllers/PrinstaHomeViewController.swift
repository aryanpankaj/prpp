//
//  PrinstaHomeViewController.swift
//  prinsta_pick
//
//  Created by apple on 16/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import UIKit
import FSPagerView
import CoreData

class PrinstaHomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate  {
  
    @IBOutlet weak var tableView: UITableView!

     let imageForSlider = ["Rectangle 130","logo","Rectangle 130","Rectangle 130","logo","Rectangle 130","logo","Rectangle 130"]
    let cellNames = ["Photobooks","Wall Decor","Prints","Boxes","Calenders","Magnets","Card","Gift Cards"]
    let categoriesName = ["Photobooks","Wall Decor","Prints","Boxes","Calenders","Magnets","Card","Gift Cards"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
     //   self.navTitle.text = "Prinsta Pick"
        let logo = UIImage(named: "appName-1")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 33))
        imageView.image = logo
        imageView.backgroundColor = .clear
     
        self.navigationItem.titleView = imageView
        
        
        self.leftButton.isHidden = true
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(PrinstaHomeViewController.moveToNextPageTwoSecond), userInfo: nil, repeats: true)
    }
    
    var gradientLayer = CAGradientLayer()

    override func viewDidLayoutSubviews() {
        gradientLayer.frame = self.view.bounds
    }
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageForSlider.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        if row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeScrollTableViewCell", for: indexPath) as! HomeScrollTableViewCell
        cell.scrollView.delegate = self
        pageControl = cell.pageControl
        scrollView = cell.scrollView
        slideImageHeader = cell.sliderImageView
        cell.scrollView.isPagingEnabled = true
         pageControl.numberOfPages = self.imageForSlider.count
        cell.pageControl.currentPageIndicatorTintColor = CustomColor.appThemeColor
        cell.scrollView.showsVerticalScrollIndicator = false
        cell.scrollView.showsHorizontalScrollIndicator = false
       
           
        setupImageViews()
        return cell
        } else if row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "trandingTableViewCell", for: indexPath) as! TrandingTableViewCell
            cell.selectionStyle = .none
            cell.headingLabel.text = "Trending"
            cell.leadingView.backgroundColor = CustomColor.customGreenColor
            cell.trandingCollectionView.delegate = self
            cell.trandingCollectionView.dataSource = self
            cell.trandingCollectionView.tag = row
            if let layout = cell.trandingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }

            return cell
        } else if row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "trandingTableViewCell", for: indexPath) as! TrandingTableViewCell
            cell.selectionStyle = .none
             cell.headingLabel.text = "Category"
            cell.trandingCollectionView.delegate = self
            cell.trandingCollectionView.dataSource = self
             cell.leadingView.backgroundColor = CustomColor.customGreenColor
               cell.trandingCollectionView.tag = row
            if let layout = cell.trandingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeRatingTableViewCell", for: indexPath) as! HomeRatingTableViewCell
            cell.userImage.image = UIImage(named: "profile_icon")
            cell.userImage.layer.cornerRadius = cell.userImage.frame.width/2
            cell.userImage.clipsToBounds = true
          
         
            cell.mainView.layer.cornerRadius = 5
            cell.mainView.layer.shadowRadius = 11
            cell.mainView.layer.shadowOpacity = 0.1
            cell.mainView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.mainView.layer.shadowOffset = CGSize.zero
            
            cell.mainView.generateOuterShadow()
            cell.reviewLabel.text = "Test Test Test Test Test Test Test Test Test Test Test Test"
            return cell
        }
    }
    
 
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 {
        return 220
        } else if row == 1 {
         return 260
        } else if row == 2 {
            return 150
        } else {
            return 150
        }
    }
    
    
    //MARK: Scrollview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = Int(scrollView.contentSize.width) / imageForSlider.count
        if scrollView.contentOffset.x == 0 {
            
        } else {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / pageWidth
        }
    }
    
    var slideImageHeader : UIImageView!
    var imageHeight : CGFloat = 150
    var pageControl: UIPageControl!
    var scrollView : UIScrollView!
    var headingLabel : UILabel!
    
    
    @objc func moveToNextPageTwoSecond () {
        
        if scrollView != nil {
            let pageWidth:CGFloat = self.scrollView.frame.width
            let maxWidth:CGFloat = pageWidth * CGFloat(imageForSlider.count)
            let contentOffset:CGFloat = self.scrollView.contentOffset.x
            
            var slideToX = contentOffset + pageWidth
            
            if  contentOffset + pageWidth == maxWidth{
                slideToX = 0
            }
            let rct = CGRect(x: slideToX, y: 0, width: pageWidth, height: self.scrollView.frame.height)
            self.scrollView.scrollRectToVisible(rct, animated: true)
        }
    }
    
    func setupImageViews() {
        var totalWidth: CGFloat = 0
        for var i in 0..<imageForSlider.count {
            let imageName = imageForSlider[i]
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(origin: CGPoint(x: totalWidth, y: 0),size:CGSize(width: tableView.bounds.size.width, height: 190))
            imageView.contentMode = .scaleToFill
            //transparent view
            let transView = UIView()
            transView.frame = CGRect(origin: CGPoint(x: totalWidth, y:80),size:CGSize(width: tableView.bounds.size.width/2 + 35, height: imageHeight - 60))
            transView.backgroundColor = .clear
            let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 0.7)
            let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 0.7)
            transView.applyGradient(colours: [color1,color2], locations: [0.0, 0.5, 1.0,0.5])
            transView.layer.zPosition = 1
            transView.layer.cornerRadius = 4.0
            transView.clipsToBounds = true
            
            //create label
            headingLabel = UILabel()
             headingLabel.frame = CGRect(origin: CGPoint(x: totalWidth + 10, y: 8),size:CGSize(width: tableView.bounds.size.width/2, height: 80))
            headingLabel.textColor = .white
            
            headingLabel.backgroundColor = .clear
            headingLabel.text = "PRINT WHAT YOU WANT"
            headingLabel.font = CustomFont.boldfont25
            headingLabel.numberOfLines = 2
            transView.addSubview(headingLabel)
            if i == 0 {
            scrollView.addSubview(transView)
            }
            scrollView.addSubview(imageView)
            totalWidth += imageView.bounds.size.width
            imageView.image = UIImage(named: imageName)
//            Alamofire.request(imageName).responseImage { response in
//
//                imageView.image = response.result.value
//            }
            imageView.backgroundColor = .clear
        }
        if imageForSlider.count != 0 {
            scrollView.contentSize = CGSize(width: totalWidth, height: imageHeight)
            let pageWidth = Int(tableView.contentSize.width) / imageForSlider.count
            pageControl.currentPage = Int(scrollView.contentOffset.x) / pageWidth
        }
    }
    
     @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
    }
    
   
  

}


//collectionView Delegate and datasource

extension PrinstaHomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
        return cellNames.count
        } else {
         return categoriesName.count
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trandingCollectionViewCell", for: indexPath) as! TrandingCollectionViewCell
           
         cell.itemImageView.image = UIImage(named: imageForSlider[indexPath.item])
         cell.itemNameLabel.text = cellNames[indexPath.item]
         cell.rateView.rating = 5.0
         return cell
        } else {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionViewCell", for: indexPath) as! HomeCategoriesCollectionViewCell
            cell.categoryNameLabel.text = categoriesName[indexPath.item]
            cell.categoryImageView.image = UIImage(named: imageForSlider[indexPath.item])
            cell.imageContainerView.layer.cornerRadius = 5
            cell.imageContainerView.layer.shadowRadius = 11
            cell.imageContainerView.layer.shadowOpacity = 0.1
            cell.imageContainerView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.imageContainerView.layer.shadowOffset = CGSize.zero
            
            cell.imageContainerView.generateOuterShadow()
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
        return CGSize(width: UIScreen.main.bounds.width / 3 , height: 220)
        } else {
           return CGSize(width: 100, height: 110)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 1 {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            if indexPath.row == 0 {
               
                let vc = storyBoard.instantiateViewController(withIdentifier: "photoBooks") as! PhotoBooksListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = storyBoard.instantiateViewController(withIdentifier: "wallDecorViewController") as! WallDecorViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 2 {
                let vc = storyBoard.instantiateViewController(withIdentifier: "printListViewController") as! PrintListViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 3 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "boxesViewController") as! BoxesViewController
                vc.isBoxOrCalender = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 4 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "boxesViewController") as! BoxesViewController
                vc.isBoxOrCalender = false
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 5 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "magnetsCardsViewController") as! MagnetsCardsViewController
                vc.isMagnetOrCard = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 6 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "magnetsCardsViewController") as! MagnetsCardsViewController
                vc.isMagnetOrCard = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
        } else {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            if indexPath.row == 0 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "photoBooks") as! PhotoBooksListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = storyBoard.instantiateViewController(withIdentifier: "wallDecorViewController") as! WallDecorViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 2 {
                let vc = storyBoard.instantiateViewController(withIdentifier: "printListViewController") as! PrintListViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 3 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "boxesViewController") as! BoxesViewController
                vc.isBoxOrCalender = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 4 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "boxesViewController") as! BoxesViewController
                vc.isBoxOrCalender = false
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 5 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "magnetsCardsViewController") as! MagnetsCardsViewController
                vc.isMagnetOrCard = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 6 {
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "magnetsCardsViewController") as! MagnetsCardsViewController
                vc.isMagnetOrCard = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }
    }


}
