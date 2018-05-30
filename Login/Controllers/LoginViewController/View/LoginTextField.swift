//
//  LoginTextField.swift
//  Login
//
//  Created by Anna on 06.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    let color = Constant.Color.self
    
    enum Style {
        case `default`
        case error
        case active
    }
    
    var style: Style = .default {
        didSet {
            switch style {
            case .default:
                applyStyleWithHEXColor(text: color.grayText, border: color.grayNotActiveTF)
            case .error:
                applyStyleWithHEXColor(text: color.redError, border: color.redError)
            case .active:
                applyStyleWithHEXColor(text: color.grayText, border: color.grayActiveBorderTF)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let placeholderColor = UIColor.init(hex: Constant.Color.grayTxtPlaceholder)
        applyStyleWithHEXColor(text: color.grayText, border: color.grayNotActiveTF)
        
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.sublayerTransform =  CATransform3DMakeTranslation(16, 0, 0)
        attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        style = .active
        return super.becomeFirstResponder()
    }
    @discardableResult override func resignFirstResponder() -> Bool {
        style = .default
        return super.resignFirstResponder()
    }
    
    private func applyStyleWithHEXColor(text: String, border: String) {
        self.textColor = UIColor.init(hex: text)
        self.layer.borderColor = UIColor.init(hex: border).cgColor
    }
}
