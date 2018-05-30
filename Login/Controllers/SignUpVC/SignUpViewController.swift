//
//  SignUpViewController.swift
//  Login
//
//  Created by Anna on 08.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, StoryboardInstance {
    
    /// UI Elements
    @IBOutlet weak var nameTF: NameTextField!
    @IBOutlet weak var emailTF: EmailTextField!
    @IBOutlet weak var passwordTF: PasswordTextField!
    @IBOutlet weak var signUpBtn: LoginButton!
    
    /// Managers
    let dataProvider: AuthorizatorProtocol & DataProviderProtocol = NetworkDataProvider.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    func storyboardInstance() {
        
    }
    
    func initViewController() {
        nameTF.becomeFirstResponder()
        //
        nameTF.placeholder = Constant.String.name
        emailTF.placeholder = Constant.String.email
        passwordTF.placeholder = Constant.String.password
        //
        signUpBtn.isEnabled = false
    }
    
    func isValidEmailAndPassword() -> Bool {
        return emailTF.isValidData() && passwordTF.isValidData()
    }
    
    func openStatisticTableView() {
        guard let vc = StatisticTableViewController.storyboardInstance() else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    //MARK: - Action
    
    @IBAction func popToPreviousVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editChanged(_ sender: UITextField) {
        signUpBtn.isEnabled = (isValidEmailAndPassword() && !(nameTF.text?.isEmpty)!)
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        guard let name = nameTF.text,
            let email = emailTF.text,
            let pass = passwordTF.text else { return }
        dataProvider.signUp(name: name, email: email, password: pass, success: { (token) in
            debugPrint(token)
            self.openStatisticTableView()
        }) { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTF:
            emailTF.becomeFirstResponder()
        case emailTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            passwordTF.resignFirstResponder()
        default:
            break
        }
        return false
    }
}
