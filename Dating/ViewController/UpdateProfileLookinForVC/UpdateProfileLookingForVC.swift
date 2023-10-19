//
//  UpdateProfileLookingForVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit

class UpdateProfileLookingForVC: UIViewController {
    
    //MARK: ---Outlets---
    @IBOutlet weak var tblLookinFor:UITableView!
    
    //MARK: ---Variables---
    var selectedIndex = [Int]()
    
    //MARK: --ViewLyfe cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTblUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Functions---
    func setupTblUI(){
        self.tblLookinFor.register(UINib.init(nibName: "EthnicityTVC", bundle: nil), forCellReuseIdentifier: "EthnicityTVC")
    }
    
    //MARK: ---Button Actions---
    @IBAction func btnAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverVC") as! DiscoverVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: ---TableView Extension---
extension UpdateProfileLookingForVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblLookinFor.dequeueReusableCell(withIdentifier: "EthnicityTVC", for: indexPath) as! EthnicityTVC
        if self.selectedIndex.contains(indexPath.row) == false{
            cell.viewMAin.borderWidth = 0
            cell.viewMAin.borderColor = .clear
            cell.imgSelect.image = UIImage(named: "unselect")
        }else{
            cell.viewMAin.borderWidth = 1
            cell.viewMAin.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            cell.imgSelect.image = UIImage(named: "lookin_select")
        }
//        if selectedIndex == indexPath.row{
//            cell.viewMAin.borderWidth = 1
//            cell.viewMAin.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
//            cell.imgSelect.image = UIImage(named: "radio_selected")
//        }else{
//            cell.viewMAin.borderWidth = 0
//            cell.viewMAin.borderColor = .clear
//            cell.imgSelect.image = UIImage(named: "unselect")
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndex.contains(indexPath.row) {
            let index  = self.selectedIndex.firstIndex(of: indexPath.row) ?? 0
            self.selectedIndex.remove(at: index)
        }else{
            self.selectedIndex.append(indexPath.row)
        }
        self.tblLookinFor.reloadData()

    }
    
    
}
