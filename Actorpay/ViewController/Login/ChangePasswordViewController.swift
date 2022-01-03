//
//  ChangePasswordViewController.swift
//  Actorpay
//
//  Created by iMac on 09/12/21.
//

import UIKit
import Alamofire

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var changePasswordLabelView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    var isPassTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topCorners(bgView: changePasswordLabelView, cornerRadius: 10, maskToBounds: true)
        bottomCorner(bgView: buttonView, cornerRadius: 10, maskToBounds: true)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.view.removeFromSuperview()
            }
        });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.first?.view != changePasswordView){
            removeAnimate()
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton){
        removeAnimate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func passwordToggleButton(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 1001{
            // login password
            isPassTap = !isPassTap
            currentPasswordTextField.isSecureTextEntry = !isPassTap
            sender.setImage(UIImage(named: isPassTap ? "hide" : "show"), for: .normal)
        } else if sender.tag == 1002{
            // login password
            isPassTap = !isPassTap
            newPasswordTextField.isSecureTextEntry = !isPassTap
            sender.setImage(UIImage(named: isPassTap ? "hide" : "show"), for: .normal)
        }else{
            //signup Password
            isPassTap = !isPassTap
            confirmNewPasswordTextField.isSecureTextEntry = !isPassTap
            sender.setImage(UIImage(named: isPassTap ? "hide" : "show"), for: .normal)
        }
    }
    
    @IBAction func okButtonAction(_ sender: UIButton){
        
        if currentPasswordTextField.text?.trimmingCharacters(in: .whitespaces).count == 0{
            self.view.makeToast("Please Enter a current Password.")
            return
        }
        
        if newPasswordTextField.text?.trimmingCharacters(in: .whitespaces).count == 0{
            self.view.makeToast("Please Enter a current Password.")
            return
        }
        
        if confirmNewPasswordTextField.text?.trimmingCharacters(in: .whitespaces).count == 0{
            self.view.makeToast("Please Enter a current Password.")
            return
        }
        
        if newPasswordTextField.text != confirmNewPasswordTextField.text {
            self.view.makeToast("New password and confirm password does not match.")
            return
        }
        
        let params: Parameters = [
            "currentPassword": "\(currentPasswordTextField.text ?? "")",
            "newPassword": "\(newPasswordTextField.text ?? "")",
            "confirmPassword": "\(confirmNewPasswordTextField.text ?? "")"
        ]
        showLoading()
        APIHelper.changePassword(params: params) { (success,response)  in
            if !success {
                dissmissLoader()
                let message = response.message
                myApp.window?.rootViewController?.view.makeToast(message)
            }else {
                dissmissLoader()
                let message = response.message
                myApp.window?.rootViewController?.view.makeToast(message)
                self.removeAnimate()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}