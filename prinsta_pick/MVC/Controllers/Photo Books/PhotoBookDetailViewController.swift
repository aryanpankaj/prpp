//
//  PhotoBookDetailViewController.swift
//  prinsta_pick
//
//  Created by apple on 22/01/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit
import Cosmos

class PhotoBookDetailViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainImageCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var listImageCollectionView: UICollectionView!
    
    @IBOutlet weak var pageNumbersLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starting: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountHeadingLabel: UILabel!
    @IBOutlet weak var discountDescriptionLabel: UILabel!
    
    @IBOutlet weak var extrePageImageVIew: UIImageView!
    @IBOutlet weak var extraPageLabel: UILabel!
    @IBOutlet weak var deliveryImageView: UIImageView!
    
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var sizeImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var firstDetailImageVIew: UIImageView!
    @IBOutlet weak var firstDetailLabel: UILabel!
    
    @IBOutlet weak var secondDetailImageVIew: UIImageView!
    @IBOutlet weak var secondDetailLabel: UILabel!
    
    @IBOutlet weak var thirdDetailImageVIew: UIImageView!
    @IBOutlet weak var thirdDetailLabel: UILabel!
    
    @IBOutlet weak var SelectButton: UIButton!
    @IBOutlet weak var selectedButtonView: UIView!
    
    
    let imageForSlider = ["Rectangle 130","logo","Rectangle 130","Rectangle 130","logo","Rectangle 130","logo","Rectangle 130"]
    
    var book_type : String?
    var book_price : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScrollView(scrollView)
        mainImageCollectionView.delegate = self
        mainImageCollectionView.dataSource = self
        listImageCollectionView.delegate = self
        listImageCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        mainImageCollectionView.isPagingEnabled = true
        mainImageCollectionView.showsHorizontalScrollIndicator = false
        self.listImageCollectionView.isUserInteractionEnabled = true
        pageControl.numberOfPages = self.imageForSlider.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = CustomColor.appThemeColor
        discountView.backgroundColor = CustomColor.customGreenColor
        
        SelectButton.layer.cornerRadius = 8
        SelectButton.clipsToBounds = true
        
        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        SelectButton.backgroundColor = color1
        
        SelectButton.applyGradient(colours: [color1,color2], locations: [0.3, 0.7, 1.0,0.7])
        SelectButton.setTitle("Select Photos", for: .normal)
        SelectButton.titleLabel?.font = CustomFont.boldfont25
        AppHelper.delay(0.2) {
            self.SelectButton.applyGradient(colours: [color1,color2], locations: [0.3, 0.7, 1.0,0.7])
        }
        selectedButtonView.layer.shadowRadius = 9
        selectedButtonView.layer.shadowOpacity = 0.3
        selectedButtonView.layer.shadowColor = UIColor.lightGray.cgColor
        selectedButtonView.layer.shadowOffset = CGSize.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppHelper.delay(0.5) {
            self.discountView.addDashedBorder()
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func selectButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Photo", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assetsPickerController") as! AssetsPickerController
        vc.comeFrom = PrintingType.Photobooks.rawValue
        vc.book_type = book_type
        vc.book_price = book_price
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK : Collectionview delegate and data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageForSlider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "magnetCardDetailCollectionViewCell", for: indexPath) as! MagnetCardDetailCollectionViewCell
        cell.cardImageView.image = UIImage(named: imageForSlider[indexPath.item])
        
        if collectionView.tag == 0 {
            //any work for  main imGE
            
            
        } else {
            cell.cardImageView.layer.cornerRadius = 3
            cell.cardImageView.layer.shadowRadius = 10
            cell.cardImageView.layer.shadowOpacity = 0.1
            cell.cardImageView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.cardImageView.layer.shadowOffset = CGSize.zero
            
            cell.cardImageView.generateOuterShadow()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listImageCollectionView {
            mainImageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl?.currentPage = indexPath.item
            print("check")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 16 , height: 200)
        } else {
            return CGSize(width: (UIScreen.main.bounds.width - 16)/5, height: 55)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        if collectionView.tag == 0 {
            return 0
        } else {
            return 5
        }
        
    }
    
    //scroll view delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if  scrollView == mainImageCollectionView {
            pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if  scrollView == mainImageCollectionView {
            pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
}
