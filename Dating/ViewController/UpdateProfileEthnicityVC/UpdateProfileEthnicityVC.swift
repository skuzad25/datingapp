//
//  UpdateProfileEthnicityVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit

class UpdateProfileEthnicityVC: UIViewController {
    
//MARK: ---Outlets---
    @IBOutlet weak var tblEthnicity:UITableView!
    
    //MARK: ---Variables---
    var selectedIndex : Int?
    
    //MARK: --ViewLyfe cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        typeSteps = "Forth"
        setupTblUI()
        // Do any additional setup after loading the view.
    }
    //MARK: ---Functions---
    func setupTblUI(){
        self.tblEthnicity.register(UINib.init(nibName: "EthnicityTVC", bundle: nil), forCellReuseIdentifier: "EthnicityTVC")
    }

}
//MARK: ---TableView Extension---
extension UpdateProfileEthnicityVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblEthnicity.dequeueReusableCell(withIdentifier: "EthnicityTVC", for: indexPath) as! EthnicityTVC
        if selectedIndex == indexPath.row{
            cell.viewMAin.borderWidth = 1
            cell.viewMAin.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            cell.imgSelect.image = UIImage(named: "radio_selected")
        }else{
            cell.viewMAin.borderWidth = 0
            cell.viewMAin.borderColor = .clear
            cell.imgSelect.image = UIImage(named: "unselect")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.tblEthnicity.reloadData()
    }
    
}
