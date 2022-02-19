//
//  Wallpaper.swift
//  wallpapers
//
//  Created by Николай on 12.12.2021.
//

import UIKit

public struct Wallpaper {
    
    var id: Int
    var url: String
    var source_url: String
    
    init() {
                
        self.id = 0
        self.url = ""
        self.source_url = ""
    }
    
    init(id: Int, url: String, source_url: String) {
                
        self.id = id
        self.url = url
        self.source_url = source_url
    }
}
