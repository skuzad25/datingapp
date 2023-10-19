//
//  ProfileStepVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit

var CALLBACKPROFILE :((Int) -> ())?
var typeSteps = ""
class ProfileStepVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var viewContainer: UIView!
    
    //MARK: ---Variables---
    var viewArray : [UIViewController] = []
    var step = 1
    
    
    //MARK: ---View life cycle--
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

   //MARK: ---Button Actions--
    
    @IBAction func btnActions(_ sender: UIButton) {
        if sender.tag == 0{
            print("Back")
            if step == 1{
                self.navigationController?.popViewController(animated: true)
            }
//            else if step == 2{
//                step = step - 1
//                let viewController = self.viewArray[0]
//                    self.addChild(viewController)
//                    viewController.view.frame = viewContainer.bounds
//                viewContainer.addSubview(viewController.view)
//                    addChild(viewController)
//                viewContainer.addSubview(viewController.view)
//                    viewController.didMove(toParent: self)
//
//            }else if step == 3{
//                step = step - 1
//                let viewController = self.viewArray[1]
//                    self.addChild(viewController)
//                    viewController.view.frame = viewContainer.bounds
//                viewContainer.addSubview(viewController.view)
//                    addChild(viewController)
//                viewContainer.addSubview(viewController.view)
//                    viewController.didMove(toParent: self)
//            }else if step == 4{
//                step = step - 1
//                let viewController = self.viewArray[2]
//                    self.addChild(viewController)
//                    viewController.view.frame = viewContainer.bounds
//                viewContainer.addSubview(viewController.view)
//                    addChild(viewController)
//                viewContainer.addSubview(viewController.view)
//                    viewController.didMove(toParent: self)
//            }
            
        }else if sender.tag == 1{
            print("Next")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverVC") as! DiscoverVC
            self.navigationController?.pushViewController(vc, animated: true)
//            if typeSteps == "Second"{
//                CALLBACKPROFILE?(2)
//            }else if typeSteps == "Third"{
//                CALLBACKPROFILE?(3)
//            }else if typeSteps == "Forth"{
//                CALLBACKPROFILE?(4)
//            }
        }
    }
    
}
//MARK: --Extension SETUP UI--
extension ProfileStepVC{
    func setupUI(){
        setControllerFirst()
      //  setControllerSecond()
       // setControllerThird()
       // setControllerForth()
        
        let viewController = self.viewArray[0]
            self.addChild(viewController)
            viewController.view.frame = viewContainer.bounds
        viewContainer.addSubview(viewController.view)
            addChild(viewController)
        viewContainer.addSubview(viewController.view)
           
        CALLBACKPROFILE = { data in
            self.step = data
            if data == 1{
                print("ProductInfoVC")
                //self.lblTitle.text = "Cart"
                let viewController = self.viewArray[0]
                self.addChild(viewController)
                viewController.view.frame = self.viewContainer.bounds
                self.viewContainer.addSubview(viewController.view)
                self.addChild(viewController)
                self.viewContainer.addSubview(viewController.view)
                viewController.didMove(toParent: self)
            }
//            else if data == 2{
//                print("SpecificationVC")
//                //self.lblTitle.text = "Cart"
//                let viewController = self.viewArray[1]
//                self.addChild(viewController)
//                viewController.view.frame = self.viewContainer.bounds
//                self.viewContainer.addSubview(viewController.view)
//                self.addChild(viewController)
//                self.viewContainer.addSubview(viewController.view)
//                viewController.didMove(toParent: self)
//
//            }else if data == 3{
//                print("SpecificationVC")
//                //self.lblTitle.text = "Cart"
//                let viewController = self.viewArray[2]
//                self.addChild(viewController)
//                viewController.view.frame = self.viewContainer.bounds
//                self.viewContainer.addSubview(viewController.view)
//                self.addChild(viewController)
//                self.viewContainer.addSubview(viewController.view)
//                viewController.didMove(toParent: self)
//
//            }else if data == 4{
//                print("SpecificationVC")
//                //self.lblTitle.text = "Cart"
//                let viewController = self.viewArray[3]
//                self.addChild(viewController)
//                viewController.view.frame = self.viewContainer.bounds
//                self.viewContainer.addSubview(viewController.view)
//                self.addChild(viewController)
//                self.viewContainer.addSubview(viewController.view)
//                viewController.didMove(toParent: self)
//
//            }

        }
    }
    func setControllerFirst(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "UpdateProfileVC")
            as? UpdateProfileVC {
            self.viewArray.append(viewController)
        }
       
    }
    func setControllerSecond(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "UpdateProfileLocationVC")
            as? UpdateProfileLocationVC {
            self.viewArray.append(viewController)
        }
    }
    func setControllerThird(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "UpdateProfileEthnicityVC")
            as? UpdateProfileEthnicityVC {
            self.viewArray.append(viewController)
        }
    }
    func setControllerForth(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let viewController = storyboard.instantiateViewController(identifier: "UpdateProfileLookingForVC")
            as? UpdateProfileLookingForVC {
            self.viewArray.append(viewController)
        }
    }
}
