//
//  StoryboardInstance.swift
//  Login
//
//  Created by Anna on 27.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit
import Foundation

protocol StoryboardInstance {
    static func storyboardInstance(storyboardName: String, controllerID: String) -> Self?
}

extension StoryboardInstance where Self: UIViewController {
    
    static func storyboardInstance() -> Self? {
        let className = String(describing: self)
        return self.storyboardInstance(storyboardName: className, controllerID: className)
    }
    
    static func storyboardInstance(storyboardName: String) -> Self? {
        let className = String(describing: self)
        return self.storyboardInstance(storyboardName: storyboardName, controllerID: className)
    }
    
    static func storyboardInstance(storyboardName: String, controllerID: String) -> Self? {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: controllerID)
        return vc as? Self
    }
}
