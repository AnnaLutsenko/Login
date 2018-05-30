//
//  ValidationManager.swift
//  Login
//
//  Created by Anna on 10.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import Foundation

class ValidationManager {
    
    static func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
