//
//  NotificationVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit

class NotificationVC: UIViewController {

    //MARK: ---Outltes---
    @IBOutlet weak var tblLinks: UITableView!
    @IBOutlet weak var stackLink: UIStackView!
    @IBOutlet weak var stackMatches: UIStackView!
    @IBOutlet weak var tblMatch: UITableView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblMatch: UILabel!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var viewMatch: UIView!
    
    //MARK: ---ViewLife cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCVCUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Functions---
    func setupCVCUI(){
        self.tblLinks.register(UINib.init(nibName: "NotificationLinksTVC", bundle: nil), forCellReuseIdentifier: "NotificationLinksTVC")
    }
   
    //MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Like")
            self.lblLike.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewLike.isHidden = false
            self.viewMatch.isHidden = true
            self.lblMatch.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.stackLink.isHidden = false
            self.tblLinks.reloadData()
            self.stackMatches.isHidden = true
        }else if sender.tag == 1{
            print("Match")
            self.lblLike.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.viewLike.isHidden = true
            self.viewMatch.isHidden = false
            self.lblMatch.textColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.stackMatches.isHidden = false
            self.tblMatch.reloadData()
            self.stackLink.isHidden = true
        }
    }
    
}
//MARK: ---TableView Extension---
extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblLinks{
            return 10
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblLinks{
            let cell = tblLinks.dequeueReusableCell(withIdentifier: "NotificationLinksTVC", for: indexPath) as! NotificationLinksTVC
            return cell
        }else{
            let cell = tblLinks.dequeueReusableCell(withIdentifier: "NotificationLinksTVC", for: indexPath) as! NotificationLinksTVC
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
}
