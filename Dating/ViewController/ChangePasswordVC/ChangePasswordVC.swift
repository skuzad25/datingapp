//
//  ChangePasswordVC.swift
//  Dating
//
//  Created by Abhishek Chauhan on 06/10/23.
//

import UIKit
import IBAnimatable
var callBackProducePopUp: ((Bool) -> ())?
class ChangePasswordVC: UIViewController {

    
    // MARK: --- OUTLETS ---
    
    @IBOutlet weak var txtOldPassWord: AnimatableTextField!
    @IBOutlet weak var txtConfirmPassword: AnimatableTextField!
    @IBOutlet weak var txtNewPassword: AnimatableTextField!
    // MARK: --- VARIABLES ---
    var model = MainViewModel()
    
    // MARK: --- VIEW LIFE CYCLE ---
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Api Param---
    func changePass(){
        var param = [String:Any]()
        param[ApiParams.oldPassword] = self.txtOldPassWord.text ?? ""
        param[ApiParams.newPassword] = self.txtNewPassword.text ?? ""
        SKActivityIndicator.show()
        self.model.changePasswordApi(param: param)
    }
    
    // MARK: --- ACTIONS ---
    
    @IBAction func btnChangePassWord(_ sender: UIButton){
        if sender.tag == 0{
            changePass()
            
        }else if sender.tag == 1{
            dismiss(animated: true)
        }
        
    }
 
}
