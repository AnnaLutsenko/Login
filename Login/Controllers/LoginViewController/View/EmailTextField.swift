//
//  EmailTextField.swift
//  Login
//
//  Created by Anna on 10.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import Foundation
protocol ValidProtocol {
    func isValidData() -> Bool
}

class EmailTextField: LoginTextField, ValidProtocol {
    
    func isValidData() -> Bool {
        guard let text = text else { return false }
        return ValidationManager.isValid(email: text)
    }
}
