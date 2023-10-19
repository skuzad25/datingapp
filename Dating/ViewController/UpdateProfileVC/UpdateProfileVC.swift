//
//  UpdateProfileVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit
import SummerSlider
import DropDown
import GoogleMaps
import GooglePlaces

class UpdateProfileVC: UIViewController,UITextFieldDelegate {
 
    //MARK: ---Outlets---
    @IBOutlet weak var heightSlider: SummerSlider!
    @IBOutlet weak var weightSlider: SummerSlider!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblHeightFeet: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblWeightPounds: UILabel!
    @IBOutlet weak var txtViewAbout: UITextView!
    //MARK: ---Variables---
    let datePicker = UIDatePicker()
    let dropDown = DropDown()
    var selectGender = ["Men","Women", "Others"]
    var model = MainViewModel()
    var productImage : [UIImage] = []
    var updateProfileModelData : updateProfileModel?
    var getMyDetailModelData : getMyDetailModel?
    var lats = 0.0
    var longs = 0.0
    var pincode = ""
    var state = ""
    var city = ""
    var landmark = ""
    var formattedAddress = ""
    var address : String?
    
    //MARK: ---View life cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.txtLocation.delegate = self
        typeSteps = "Second"
        if let thumbImage = UIImage(named: "thumb") {
            heightSlider.setThumbImage(thumbImage, for: .normal)
            weightSlider.setThumbImage(thumbImage, for: .normal)
        }
        heightSlider.minimumValue = 0
        heightSlider.maximumValue = 100
        
        weightSlider.minimumValue = 0
        weightSlider.maximumValue = 100
      
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // When the text field is tapped, show the Google Places Autocomplete view
        showAutocomplete()
    }
    func showAutocomplete() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt64(UInt(GMSPlaceField.name.rawValue) |
                                                                   UInt(GMSPlaceField.placeID.rawValue)))
        autocompleteController.placeFields = fields
        
        // Specify a filter to restrict the search to a specific location
        let filter = GMSAutocompleteFilter()
        filter.type = .city
       
//        autocompleteController.tableCellBackgroundColor = .black
//        autocompleteController.primaryTextHighlightColor = .white
//        autocompleteController.primaryTextColor = .white
//        autocompleteController.tableCellSeparatorColor = UIColor.gray
//        autocompleteController.secondaryTextColor = .white
      //  autocompleteController.tintColor = .white
       
        autocompleteController.placeFields = fields
        autocompleteController.autocompleteFilter = filter
        
        // Present the Autocomplete view controller
        present(autocompleteController, animated: true, completion: nil)
    }
    
    //MARK: ---DropDown Function
    func showDropDown(view:UIView,stringArray:[String],textFeild:UITextField){
        dropDown.anchorView = view
        dropDown.dataSource = stringArray
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            textFeild.text = stringArray[index]
            print("Selected item: \(item) at index: \(index)")
            if textFeild == self.txtGender{
            }
        }
    }
    
    //MARK: ---Api Param---
    func completeProfileParam(){
        var param = [String:Any]()
        param[ApiParams.location] = self.txtLocation.text ?? ""
        param[ApiParams.latitude] = "232.3343"
        param[ApiParams.longitude] = "66.77777"
        param[ApiParams.height] = self.lblHeight.text ?? ""
        param[ApiParams.weight] = self.lblWeight.text ?? ""
        param[ApiParams.interest] = self.txtGender.text ?? ""
        param[ApiParams.about_us] = self.txtViewAbout.text ?? ""
        param[ApiParams.profileimgArr] =  UserDefaults.standard.stringArray(forKey: UserDefaultKey.body)
        SKActivityIndicator.show()
        self.model.profileCompleteApi(param: param)
    }
    
    //MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton){
      if sender.tag == 0{
            print("Interest")
          let selectTypes = self.selectGender
          self.showDropDown(view: self.txtGender, stringArray: selectTypes , textFeild: self.txtGender)
      }else if sender.tag == 1{
          print("Back")
          self.navigationController?.popViewController(animated: true)
      }else if sender.tag == 2{
          print("Done")
          completeProfileParam()
         
      }
    }
    
    @IBAction func heightSliderAction(_ sender: SummerSlider) {
        let valueInCentimeters = Int(sender.value)
        lblHeight.text = "\(valueInCentimeters) cm"
        
        let valueInFeet = sender.value * 0.0394
        let formattedFeet = String(format: "%.2f", valueInFeet)
          lblHeightFeet.text = "\(formattedFeet) feet"
    }
    
    @IBAction func weightSliderAction(_ sender: SummerSlider) {
        let valueInKilograms = Int(sender.value)
            lblWeight.text = "\(valueInKilograms) kg"
        
         let valueInPounds = sender.value * 2.205
           let formattedPounds = String(format: "%.2f", valueInPounds) // Format to 2 decimal places
           lblWeightPounds.text = "\(formattedPounds) pounds"
    }
    
}
//MARK: ---Location Picker Functions---
extension UpdateProfileVC: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            // Handle the selected place
            print("Place name: \(place.name ?? "")")
            print("Place ID: \(place.placeID ?? "")")
            txtLocation.text = place.name
        
              // Do something with the state, like updating another text field
              // Example: txtState.text = state
        
            dismiss(animated: true, completion: nil)
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
           
            print("Autocomplete error: \(error.localizedDescription)")
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            // Handle when the user cancels the autocomplete
            dismiss(animated: true, completion: nil)
        }
    }

