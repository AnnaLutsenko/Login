//
//  TextModel.swift
//  Login
//
//  Created by Anna on 21.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

struct TextModel {
    var text: String
    
    func getCharCount() -> [Character: Int]? {
        var dict = [Character: Int]()
        for char in text {
            if let val = dict[char]{
                dict[char] = val + 1
            } else {
                dict[char] = 1
            }
        }
        
        return dict
    }
}
