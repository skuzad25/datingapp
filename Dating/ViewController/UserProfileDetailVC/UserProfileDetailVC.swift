//
//  UserProfileDetailVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit

class UserProfileDetailVC: UIViewController {
    
    //MARK: ---Outlets---
    @IBOutlet weak var collProfileImages: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
//    @IBOutlet weak var collInteresting: UICollectionView!
//    @IBOutlet weak var collLookingFor: UICollectionView!
//    @IBOutlet weak var collInterestHeight: NSLayoutConstraint!
//    @IBOutlet weak var collLookingForHeight: NSLayoutConstraint!
    
    //MARK: ---ViewLife cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCVCUI()
        pageController.numberOfPages = 5
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.CollInterestLayout()
//        //self.CollLookingForLayout()
//    }
  
    //MARK: ---Functions---
    func setupCVCUI(){
        self.collProfileImages.register(UINib.init(nibName:"UserProfileImageCVC", bundle: nil), forCellWithReuseIdentifier: "UserProfileImageCVC")
//        self.collInteresting.register(UINib.init(nibName:"UserInterestCVC", bundle: nil), forCellWithReuseIdentifier: "UserInterestCVC")
//        self.collLookingFor.register(UINib.init(nibName:"UserInterestCVC", bundle: nil), forCellWithReuseIdentifier: "UserInterestCVC")
    }
    
//    func CollInterestLayout(){
//        let height = collInteresting.collectionViewLayout.collectionViewContentSize.height
//        collInterestHeight.constant = height
//        self.collInteresting.reloadData()
//        self.view.layoutIfNeeded()
//    }
    
//    func CollLookingForLayout(){
//        let height = collLookingFor.collectionViewLayout.collectionViewContentSize.height
//        collLookingForHeight.constant = height
//        self.collLookingFor.reloadData()
//        self.view.layoutIfNeeded()
//    }
//
    func scrollToPage(_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collProfileImages.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = currentPage
        
    }
    
    //MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton){
        if sender.tag == 0{
            print("Dislike")
        }else if sender.tag == 1{
            print("Like")
        }else if sender.tag == 2{
            print("Cancel")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
//MARK: ---CollectionView Extension---
extension UserProfileDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  if collectionView == collProfileImages{
            return 5
       // }
//        else if collectionView == collInteresting{
//            return 5
//        }else{
//            return 5
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == collProfileImages{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileImageCVC", for: indexPath) as! UserProfileImageCVC
            return cell
//        }else if collectionView == collInteresting{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInterestCVC", for: indexPath) as! UserInterestCVC
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInterestCVC", for: indexPath) as! UserInterestCVC
//            return cell
//        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     //   if collectionView == collProfileImages{
            return CGSize(width: (self.collProfileImages.bounds.width), height:(self.collProfileImages.bounds.height))
//        }else if collectionView == collInteresting{
//            return CGSize(width: self.collInteresting.bounds.width / 3 - 13, height:35)
//        }else{
//            return CGSize(width: self.collLookingFor.bounds.width / 3 - 13, height:35)
//        }
    }
    
}
