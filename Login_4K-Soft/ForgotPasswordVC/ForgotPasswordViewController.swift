//
//  ForgotPasswordViewController.swift
//  Login_4K-Soft
//
//  Created by Anna on 08.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var imgBar: UIImageView!
    @IBOutlet weak var emailTextField: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    static func storyboardInstance() -> ForgotPasswordViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        return vc
    }
    
    func initViewController() {
        emailTextField.becomeFirstResponder()
        emailTextField.placeholder = Constant.String.email
    }
    
    //MARK: - Action
    
    @IBAction func popToPreviousVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        
    }
    
}
extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
        }
        return false
    }
}
