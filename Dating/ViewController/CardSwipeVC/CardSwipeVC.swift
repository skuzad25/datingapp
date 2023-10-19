//
//  CardSwipeVC.swift
//  Dating
//
//  Created by Abhishek Chauhan on 05/10/23.
//

import UIKit
import Koloda

class CardSwipeVC: UIViewController {
    
    // MARK: --- OUTLETS ---
    
    @IBOutlet weak var koladaView: KolodaView!
    // MARK: --- VARIABLES ---
    var page = 0
    var slideIndex = Int()
    var percentage = Float()
    var isCardAnimation = true
    var isslide = ""
    // MARK: --- VIEW LIFE CYCLE ---
    override func viewDidLoad() {
        super.viewDidLoad()
        self.koladaView.dataSource = self
        self.koladaView.delegate = self
        koladaView.layer.cornerRadius = 10
        
        koladaView.clipsToBounds = true
        koladaView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
}
//MARK: KOLODA DELEGATE
extension CardSwipeVC : KolodaViewDelegate{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        page = page + 1
        koloda.reloadData()
    }
    
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //  UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileDetailVC") as! UserProfileDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        percentage = Float(finishPercentage)
     
        let index = slideIndex
        print("Finish Percentage ====> ",finishPercentage,index)
        if finishPercentage >= 40{
            if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
            view.imgSwipeDislike.isHidden = true
            view.imgSwipeLike.isHidden = true
        }
            
        }else{
                if direction == .left {
                    if finishPercentage > 30{
                        if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                            view.imgSwipeDislike.isHidden = true
                            view.imgSwipeLike.isHidden = true
                        }
                    }else{
                        if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                            view.imgSwipeDislike.isHidden = false
                            view.imgSwipeLike.isHidden = true
                        }
                    }
                    
                } else if direction == .right {
                    if finishPercentage <= 10{
                        if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                            view.imgSwipeDislike.isHidden = true
                            view.imgSwipeLike.isHidden = true
                        }
                    }else{
                        if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                            view.imgSwipeDislike.isHidden = true
                            view.imgSwipeLike.isHidden = false
                        }
                    }
                    
                }
        }
        
    }
    //    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
    //        false
    //    }
    func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool {
        self.slideIndex = index
        print("Koloda count cardssss ---> ",koloda.countOfCards,index)
        print("Final percentage ---  > ",percentage)
        if direction == .left {
            isslide = "left"
            print("left")
            if percentage == 100{
                
                
                
                
            }
            if percentage <= 30{
                if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                    view.imgSwipeDislike.isHidden = true
                    view.imgSwipeLike.isHidden = true
                }
            }else{
                if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                    view.imgSwipeDislike.isHidden = true
                    view.imgSwipeLike.isHidden = true
                }
            }
            
            
            
        }else if direction == .right {
            isslide = "right"
            print("Right")
            if percentage <= 30{
                if let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                    view.imgSwipeDislike.isHidden = true
                    view.imgSwipeLike.isHidden = true
                }
            }else{
                if  let view = self.koladaView.viewForCard(at: index) as? OverlayView{
                    view.imgSwipeDislike.isHidden = true
                    view.imgSwipeLike.isHidden = true
                }
            }
            
            
        }
        return true
    }
    
    
}
//MARK: KOLODA VIEW DELEGATE
extension CardSwipeVC: KolodaViewDataSource{
    func koloda(_ koloda: Koloda.KolodaView, viewForCardAt index: Int) -> UIView {
        let view =  (Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView)!
        
        view.btnDislikeHandler = {
            self.koladaView?.swipe(.left)
            
        }
        view.btnLikeHandler = {
            self.koladaView?.swipe(.right)
            
        }
        view.btnUndoHandler = {
            self.koladaView?.revertAction()
        }
        
        view.imgSwipeLike.isHidden = true
        view.imgSwipeDislike.isHidden = true
        return view
    }
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return 5
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",owner: self, options: nil)![0] as! OverlayView
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        if isCardAnimation{
            return true
        }else{
            return false
        }
    }
}
