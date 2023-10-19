//
//  FilterSelectLocationVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class FilterSelectLocationVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var viewMap: GMSMapView!
    
    //MARK: ---ViewLife cycle---
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Back")
            self.navigationController?.popViewController(animated: true)
        }else if sender.tag == 1{
            print("Done")
        }
    }

}
