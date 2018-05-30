//
//  LoginViewController.swift
//  Login
//
//  Created by Anna on 05.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    /// UI Elements
    @IBOutlet weak var lblEnter: UILabel!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var enterBtn: UIButton!
    
    /// Managers
    var dataProvider: AuthorizatorProtocol & DataProviderProtocol = NetworkDataProvider.shared
    let validationManager = ValidationManager()
    
    /// Constants
    let color = Constant.Color.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewController()
    }
    
    func initViewController() {
        enterBtn.isEnabled = false
        emailTextField.becomeFirstResponder()
        //
        emailTextField.placeholder = Constant.String.email
        passwordTextField.placeholder = Constant.String.password
        //
        emailTextField.text = "test+1@mail.com"
        passwordTextField.text = "testtest"
        //
        enterBtn.isEnabled = isValidEmailAndPassword()
    }
    
    func isValidEmailAndPassword() -> Bool {
        return emailTextField.isValidData() && passwordTextField.isValidData()
    }
    
    func openStatisticTableView() {
        guard let vc = StatisticTableViewController.storyboardInstance() else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    //MARK: - Action
    @IBAction func signUp(_ sender: UIButton) {
        guard let vc = SignUpViewController.storyboardInstance(storyboardName: "Main") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        dataProvider.login(email: email, password: password, success: { (token) in
            // push text controller and make text request
            debugPrint(token)
            self.emailTextField.style = .default
            self.openStatisticTableView()
        }) { (error) in
            debugPrint(error.localizedDescription)
            //
            self.lblEnter.text = error.localizedDescription
            self.lblEnter.textColor = UIColor.init(hex:  self.color.redError)
            self.passwordTextField.style = .error
        }
        
    }
    
    @IBAction func valueCanged(_ sender: LoginTextField) {
        lblEnter.text = Constant.String.enter
        lblEnter.textColor = UIColor.init(hex: color.grayText)
        sender.style = .active
        enterBtn.isEnabled = isValidEmailAndPassword()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

