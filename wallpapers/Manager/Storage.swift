//
//  Storage.swift
//  wallpapers
//
//  Created by Николай on 19.12.2021.
//

import Foundation

class Storage {
    
    static var states: [Int: Bool] = [:]
    
    public static func setCategorySwitchState(categoryId: Int, isOn: Bool) {
        states[categoryId] = isOn
    }
    
    public static func getCategorySwitchState(categoryId: Int) -> Bool {
        
        if(states[categoryId] != nil) {
            return states[categoryId]!
        }
        
        return false
    }
    
    public static func getCategorySwitchedIds() -> [Int] {
        var switched: [Int] = []
        for (categoryId, isOnValue) in states {
            if(isOnValue) {
                switched.append(categoryId)
            }
        }
        return switched
    }
}
