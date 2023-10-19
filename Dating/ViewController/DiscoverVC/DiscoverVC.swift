//
//  DiscoverVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit

class DiscoverVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
