//
//  EditProfileVC.swift
//  Dating
//
//  Created by Iram Khan on 06/10/23.
//

import UIKit
import SummerSlider
import DropDown
import GoogleMaps
import GooglePlaces

class EditProfileVC: UIViewController,UITextFieldDelegate {

    //MARK: ---Outlets---
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblHeightFeet: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblweightPounds: UILabel!
    @IBOutlet weak var sliderHeight: SummerSlider!
    @IBOutlet weak var sliderWeight: SummerSlider!
    @IBOutlet weak var txtInterest: UITextField!
    @IBOutlet weak var txtabout: UITextView!
    
    //MARK: ---Variables---
    let datePicker = UIDatePicker()
    let dropDown = DropDown()
    var selectGender = ["Men","Women", "Others"]
    var genderType = ""
    var model = MainViewModel()
    var getMyDetailModelData : getMyDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        self.model.delegate = self
        self.txtLocation.delegate = self
        if let thumbImage = UIImage(named: "thumb") {
            sliderHeight.setThumbImage(thumbImage, for: .normal)
            sliderWeight.setThumbImage(thumbImage, for: .normal)
        }
        sliderHeight.minimumValue = 0
        sliderHeight.maximumValue = 100
        
        sliderWeight.minimumValue = 0
        sliderWeight.maximumValue = 100
        
        self.txtName.text = self.getMyDetailModelData?.name ?? ""
        if self.getMyDetailModelData?.gender == 1{
            self.txtGender.text = "Men"
        }else if self.getMyDetailModelData?.gender == 2{
            self.txtGender.text = "Women"
        }else if self.self.getMyDetailModelData?.gender == 3{
            self.txtGender.text = "Others"
        }
        self.txtDob.text = self.getMyDetailModelData?.dob ?? ""
        self.txtLocation.text = self.getMyDetailModelData?.location ?? ""
        self.lblHeight.text = self.getMyDetailModelData?.height ?? ""
        self.lblWeight.text = self.getMyDetailModelData?.weight ?? ""
        self.txtInterest.text = self.getMyDetailModelData?.interest ?? ""
        self.txtabout.text = self.getMyDetailModelData?.about_us ?? ""
        
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
                if index == 0{
                    genderType = "1"
                }else if index == 1{
                    genderType = "2"
                }else if index == 2{
                    genderType = "3"
                }
            }
        }
    }
    
    //MARK: ---Date Picker Functions---
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *){
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.maximumDate = Calendar.current.date(byAdding: DateComponents(), to: Date())!
            print(datePicker.maximumDate ?? "")
            datePicker.minimumDate =   Calendar.current.date(byAdding: .year, value: -123, to: Date())!
        }else{
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker1))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        self.txtDob.inputAccessoryView = toolbar
        self.txtDob.inputView = datePicker
    }
    
    @objc func donedatePicker(){            // DONE DATEPICKER
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        self.txtDob.text = outputFormatter.string(from: datePicker.date)
        self.txtDob.resignFirstResponder()
    }
    
    @objc func cancelDatePicker1(){         // CANCEL DATEPICKER
        self.txtDob.resignFirstResponder()
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
       
//        autocompleteController.tableCellBackgroundColor = .white
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
    
    //MARK: ---Api Param---
    func editParam(){
        var param = [String:Any]()
        param[ApiParams.name] = self.txtName.text ?? ""
        param[ApiParams.gender] = self.genderType
        param[ApiParams.dob] = self.txtDob.text ?? ""
        param[ApiParams.location] = self.txtLocation.text ?? ""
        param[ApiParams.latitude] = "232.3343"
        param[ApiParams.longitude] = "66.77777"
        param[ApiParams.height] = self.lblHeight.text ?? ""
        param[ApiParams.weight] = self.lblWeight.text ?? ""
        param[ApiParams.interest] = self.txtInterest.text ?? ""
        param[ApiParams.about_us] = self.txtabout.text ?? ""
        SKActivityIndicator.show()
        self.model.editProfileApi(param: param)
    }
    
    @IBAction func heightSlider(_ sender: SummerSlider) {
        let valueInCentimeters = Int(sender.value)
        lblHeight.text = "\(valueInCentimeters) cm"
        
        let valueInFeet = sender.value * 0.0394
        let formattedFeet = String(format: "%.2f", valueInFeet)
          lblHeightFeet.text = "\(formattedFeet) feet"
    }
    

    @IBAction func weightSlider(_ sender: SummerSlider) {
        let valueInKilograms = Int(sender.value)
            lblWeight.text = "\(valueInKilograms) kg"
        
         let valueInPounds = sender.value * 2.205
           let formattedPounds = String(format: "%.2f", valueInPounds) // Format to 2 decimal places
           lblweightPounds.text = "\(formattedPounds) pounds"
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Back")
            self.navigationController?.popViewController(animated: true)
        }else if sender.tag == 1{
            print("Done")
            editParam()
        }else if sender.tag == 2{
            print("Gender")
            let selectTypes = self.selectGender
            self.showDropDown(view: self.txtGender, stringArray: selectTypes , textFeild: self.txtGender)
        }else if sender.tag == 3{
            print("Interest")
            let selectTypes = self.selectGender
            self.showDropDown(view: self.txtInterest, stringArray: selectTypes , textFeild: self.txtInterest)
        }
    }
    
}
//MARK: ---Location Picker Functions---
extension EditProfileVC: GMSAutocompleteViewControllerDelegate{
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
