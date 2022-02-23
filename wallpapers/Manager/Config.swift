//
//  Config.swift
//  wallpapers
//
//  Created by Николай on 03.02.2022.
//

import UIKit

class Config {
    
    static var storyboardName: String = "Main"
    static var apiUrl: String = "https://ozhogov.ru/apps_backend/app_wallpaper/?route="
    
    static var contentEmpty: String = "Ничего не найдено"
    
    static var searchCellHeight: Int = 50
    
    static func getCurrentLanguageCode() -> String {
        let langStr = Locale.current.languageCode ?? "en"
        return langStr
    }
}
