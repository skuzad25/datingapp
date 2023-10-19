//
//  UpdateProfileLocationVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class UpdateProfileLocationVC: UIViewController {
    
//MARK: ---Outlets--
    @IBOutlet weak var viewMap: GMSMapView!
    
    //MARK: ---View lyfe cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        typeSteps = "Third"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
