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
    
    static var searchCellHeight: Int = 30
    
    //access key read only granted
    static var accessKey: String = "e5271715-fc77-458f-b960-9b3e3af35256"
    
    static func getCurrentLanguageCode() -> String {
        let langStr = Locale.current.languageCode ?? "en"
        return langStr
    }
}
