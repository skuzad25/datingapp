//
//  NearbyFilterVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit
import RangeSeekSlider

class NearbyFilterVC: UIViewController {

    //MARK: ---Outltes---
    @IBOutlet weak var viewRangeSlider: RangeSeekSlider!
   // @IBOutlet weak var lblMinValue: UILabel!
    @IBOutlet weak var lblMaxValue: UILabel!
    
    //MARK: ---ViewLife cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRangeSlider.selectedHandleDiameterMultiplier = 1.0
        viewRangeSlider.lineHeight = 10
        viewRangeSlider.minValue = 0
        viewRangeSlider.maxValue = 100

    }
    
//MARK: ---RangeSlider Action
    @IBAction func value(_ sender: RangeSeekSlider) {
        let minRangeValue = Int(sender.selectedMinValue)
        let maxRangeValue = Int(sender.selectedMaxValue)

        // Update the label with the selected range
        lblMaxValue.text = "\(minRangeValue)-\(maxRangeValue)"
    }
    
    //MARK: ---button Action---
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Locaion")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterSelectLocationVC") as! FilterSelectLocationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 1{
            print("Role")
        }else if sender.tag == 2{
            print("Ethnicity")
        }else if sender.tag == 3{
            
        }
    }
    
    
}
