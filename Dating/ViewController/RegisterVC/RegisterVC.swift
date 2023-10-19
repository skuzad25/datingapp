//
//  RegisterVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit
import DropDown
import FTIndicator

class RegisterVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewame: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var btnPassEye: UIButton!
    
    //MARK: ---Variables--
    let datePicker = UIDatePicker()
    let dropDown = DropDown()
    var selectGender = ["Male","Female", "Others"]
    var model = MainViewModel()
    var genderType = ""
    //MARK: ---ViewLife cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        self.txtPassword.isSecureTextEntry = true
        self.model.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //loginParams()
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
    
    //MARK: ---Api Param---
    func signUpParams(){
        var param = [String:Any]()
        param[ApiParams.email] = self.txtEmail.text ?? ""
        param[ApiParams.name] = self.txtName.text ?? ""
        param[ApiParams.gender] = self.genderType
        param[ApiParams.dob] = self.txtDob.text ?? ""
        param[ApiParams.password] = self.txtPassword.text ?? ""
        SKActivityIndicator.show()
        self.model.signUpApiCalling(param: param)
    }
    
    //MARK: ---Button Actions---
    
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Login")
            guard validateSignUpData() else {
                return
            }
                self.signUpParams()
           
           
        }else if sender.tag == 1{
            print("Already have account login")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 2{
            print("Click on checkBox")
            self.btnCheckBox.isSelected = !self.btnCheckBox.isSelected
        }else if sender.tag == 3{
            print("Gender")
            let selectTypes = self.selectGender
            self.showDropDown(view: self.txtGender, stringArray: selectTypes , textFeild: self.txtGender)
        }else if sender.tag == 4{
            print("view password")
            self.btnPassEye.isSelected = !self.btnPassEye.isSelected
            if self.btnPassEye.isSelected{
                self.txtPassword.isSecureTextEntry = false
            }else{
                self.txtPassword.isSecureTextEntry = true
            }
        }
    }
    
}
//MARK: - VALIDATE SIGNUP DATA
extension RegisterVC{
    
    func validateSignUpData() -> Bool {
        guard !txtName.isEmptyy() else {
            Alert.showSimpleAlert(AlertsMessage.enterName)
            Animations.requireUserAttention(on: viewame)
            
            self.txtName.resignFirstResponder()
            self.viewame.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewame.layer.borderWidth = 1
        
            return false
        }
        guard !txtEmail.isEmptyy()  else {
            Alert.showSimpleAlert(AlertsMessage.enterEmail)
            Animations.requireUserAttention(on: viewEmail)
            
            self.txtEmail.resignFirstResponder()
            self.viewEmail.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewEmail.layer.borderWidth = 1
        
            return false
        }
        guard !txtEmail.isValidEmailAddress() == false else {
            Alert.showSimpleAlert(AlertsMessage.validEmail)
            Animations.requireUserAttention(on: viewEmail)
            
            self.txtEmail.resignFirstResponder()
            self.viewEmail.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewEmail.layer.borderWidth = 1
            
            return false
        }
        
        guard !txtPassword.isEmptyy() else {
            Alert.showSimpleAlert(AlertsMessage.enterPassword)
            Animations.requireUserAttention(on: viewPassword)
            
            self.txtPassword.resignFirstResponder()
            self.viewPassword.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewPassword.layer.borderWidth = 1
            
            return false
        }
        
        guard txtPassword.text?.count ?? 0 > 6 else {
            Alert.showSimpleAlert(AlertsMessage.validPassword)
            Animations.requireUserAttention(on: viewPassword)
            
            self.txtPassword.resignFirstResponder()
            self.viewPassword.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewPassword.layer.borderWidth = 1
            
            return false
        }
        
        guard btnCheckBox.isSelected else{
            Alert.showSimpleAlert(AlertsMessage.selectTermConditions)
            return false
        }
        return true
    }
}
