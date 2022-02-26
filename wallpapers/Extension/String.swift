//
//  String.swift
//  wallpapers
//
//  Created by Николай on 26.02.2022.
//

import Foundation

extension String {
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
}
