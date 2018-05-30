//
//  PasswordTextField.swift
//  Login
//
//  Created by Anna on 10.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class PasswordTextField: LoginTextField, ValidProtocol {
    
    func isValidData() -> Bool {
        guard let text = text else { return false }
        return text.count >= 6
    }
}
