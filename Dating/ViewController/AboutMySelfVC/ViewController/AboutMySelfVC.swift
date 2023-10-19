//
//  AboutMySelfVC.swift
//  Dating
//
//  Created by Abhishek Chauhan on 06/10/23.
//

import UIKit

class AboutMySelfVC: UIViewController {
    
    // MARK: --- OUTLETS ---
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var colImgDetail: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblInterest: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    // MARK: --- VARIABLES ---
    var model = MainViewModel()
    var getMyDetailModelData : getMyDetailModel?
    
    // MARK: --- VIEW LIFE CYCLE ---

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        SKActivityIndicator.show()
        self.model.getMyDetailApi()
        pageControl.currentPage = 0
        setupCVCUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setUpCollectionView(){
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
//        collectionFlowLayout.itemSize = CGSize(width: colStoreDetail.frame.size.width , height: colStoreDetail.frame.size.height )
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 0
        colImgDetail!.collectionViewLayout = collectionFlowLayout
        colImgDetail.setCollectionViewLayout(collectionFlowLayout, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        // self.view.layoutIfNeeded()
        setUpCollectionView()
    }
    
    // MARK: --- SETUPCVC ---
    func setupCVCUI(){
        self.colImgDetail.register(UINib.init(nibName:"AboutMySelfCVC", bundle: nil), forCellWithReuseIdentifier: "AboutMySelfCVC")
    }

    // MARK: --- ACTIONS ---
    
    @IBAction func btnAboutMySelf(_ sender: UIButton){
        if sender.tag == 1{
            print("Back")
            self.navigationController?.popViewController(animated: true)
        }else if sender.tag == 2{
            print("Edit")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            vc.getMyDetailModelData = self.getMyDetailModelData
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 3{
            print("Change Password")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(vc, animated: true)
        }
        
    }
  
}


// MARK: --- COLLECTION VIEW DELEGATE ---
extension AboutMySelfVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
         
           self.pageControl.numberOfPages = 5
            return 5

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutMySelfCVC", for: indexPath) as! AboutMySelfCVC
           // cell.layer.cornerRadius = 20
            return cell
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
            
            return CGSize(width: (self.colImgDetail.frame.size.width) , height:
                            self.colImgDetail.frame.size.height)
        
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
//    @objc func autoScroll() {
//           let currentPage = pageControl.currentPage
//           let nextPage = (currentPage + 1) % 5 // Replace with the actual number of items
//           pageControl.currentPage = nextPage
//           scrollToPage(nextPage)
//       }

//       func scrollToPage(_ page: Int) {
//           let indexPath = IndexPath(item: page, section: 0)
//           colProductdetails.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//       }
       
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in colImgDetail.visibleCells {
            let indexPath = colImgDetail.indexPath(for: cell)
            pageControl.currentPage = indexPath?.row ?? 0
            print(indexPath)
        }
    }
}
