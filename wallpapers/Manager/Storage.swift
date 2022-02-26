//
//  Storage.swift
//  wallpapers
//
//  Created by Николай on 19.12.2021.
//

import Foundation

class Storage {
    
    static var categoryStates: [Int: Bool] = [:]
    static var tag: Tag = Tag()
    
    public static func setCategorySwitchState(categoryId: Int, isOn: Bool) {
        categoryStates[categoryId] = isOn
    }
    
    public static func getCategorySwitchState(categoryId: Int) -> Bool {
        
        if(categoryStates[categoryId] != nil) {
            return categoryStates[categoryId]!
        }
        
        return false
    }
    
    public static func getCategorySwitchedIds() -> [Int] {
        var switched: [Int] = []
        for (categoryId, isOnValue) in categoryStates {
            if(isOnValue) {
                switched.append(categoryId)
            }
        }
        return switched
    }
    
    public static func getTag() -> Tag {
        return tag
    }
    
    public static func setTag(tag: Tag) {
        self.tag = tag
    }
}
