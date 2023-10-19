//
//  TabbarVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit

class TabbarVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var imgNotification: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgHome.image = UIImage(named: "home_selected")
        self.lblHome.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CardSwipeVC")as? CardSwipeVC else {return}
        self.addChild(vc)
            vc.view.frame = self.viewMain.bounds
            self.viewMain.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    }
    

   //MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton){
        if sender.tag == 0{
            print("Home")
            self.imgHome.image = UIImage(named: "home_selected")
            self.lblHome.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.imgProfile.image = UIImage(named: "profile_unselect")
            self.lblProfile.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgNotification.image = UIImage(named: "notification_unselect")
            self.lblNotification.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgMessage.image = UIImage(named: "chat_unselect")
            self.lblMessage.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            guard let vc = self.storyboard?.instantiateViewController(identifier: "CardSwipeVC")as? CardSwipeVC else {return}
                  self.addChild(vc)
                 vc.view.frame = viewMain.bounds
                  viewMain.addSubview(vc.view)
                  vc.didMove(toParent: self)
        }else if sender.tag == 1{
            print("Message")
            self.imgMessage.image = UIImage(named: "chat_selected")
            self.lblMessage.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.imgProfile.image = UIImage(named: "profile_unselect")
            self.lblProfile.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgNotification.image = UIImage(named: "notification_unselect")
            self.lblNotification.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgHome.image = UIImage(named: "home_unselect")
            self.lblHome.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            guard let vc = self.storyboard?.instantiateViewController(identifier: "MessageVC")as? MessageVC else {return}
                  self.addChild(vc)
                 vc.view.frame = viewMain.bounds
                  viewMain.addSubview(vc.view)
                  vc.didMove(toParent: self)
        }else if sender.tag == 2{
            print("Notification")
            self.imgNotification.image = UIImage(named: "notification_selected")
            self.lblNotification.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.imgProfile.image = UIImage(named: "profile_unselect")
            self.lblProfile.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgMessage.image = UIImage(named: "chat_unselect")
            self.lblMessage.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgHome.image = UIImage(named: "home_unselect")
            self.lblHome.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
//            guard let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC")as? NotificationVC else {return}
//                  self.addChild(vc)
//                 vc.view.frame = viewMain.bounds
//                  viewMain.addSubview(vc.view)
//                  vc.didMove(toParent: self)
        }else if sender.tag == 3{
            print("Profile")
            self.imgProfile.image = UIImage(named: "profile_selected")
            self.lblProfile.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.imgNotification.image = UIImage(named: "notification_unselect")
            self.lblNotification.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgMessage.image = UIImage(named: "chat_unselect")
            self.lblMessage.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            self.imgHome.image = UIImage(named: "home_unselect")
            self.lblHome.textColor = #colorLiteral(red: 0.6745098039, green: 0.6941176471, blue: 0.7529411765, alpha: 1)
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ProfileVC")as? ProfileVC else {return}
                  self.addChild(vc)
                 vc.view.frame = viewMain.bounds
                  viewMain.addSubview(vc.view)
                  vc.didMove(toParent: self)
        }
    }
}
