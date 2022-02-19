//
//  Tag.swift
//  wallpapers
//
//  Created by Николай on 18.02.2022.
//

import UIKit

public struct Tag {
    
    var id: Int
    var name: String
    var name_en: String
    
    init () {
        self.id = 0
        self.name = ""
        self.name_en = ""
    }
    
    init (id: Int, name: String, name_en: String) {
        
        self.id = id
        self.name = name
        self.name_en = name_en
    }
}
