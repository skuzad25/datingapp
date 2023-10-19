//
//  LoginVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: ---Outlets---
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    //MARK: ---Variables---
    var model = MainViewModel()
    var getMyDetailModelData : getMyDetailModel?
    //MARK: ---ViewLyfe cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Api Param---
    func loginParams(){
        var param = [String:Any]()
        param[ApiParams.email] = self.txtEmail.text ?? ""
        param[ApiParams.password] = self.txtPassword.text ?? ""
        SKActivityIndicator.show()
        self.model.loginApiCalling(param: param)
    }
    
    //MARK: ---Button Actions---
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("login")
            guard validateLoginData() else {
                return
            }
            loginParams()
        }else if sender.tag == 1{
            print("Register")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
//MARK: - VALIDATE SIGNIN DATA
extension LoginVC{
    func validateLoginData() -> Bool {
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
        guard !txtPassword.isEmptyy()  else {
            Alert.showSimpleAlert(AlertsMessage.enterPassword)
            Animations.requireUserAttention(on: viewPassword)
            
            self.txtPassword.resignFirstResponder()
            self.viewPassword.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.1490196078, blue: 0.337254902, alpha: 1)
            self.viewPassword.layer.borderWidth = 1
            
            return false
        }
        return true
    }
}
