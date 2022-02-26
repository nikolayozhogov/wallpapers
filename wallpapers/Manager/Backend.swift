//
//  Backend.swift
//  wallpapers
//
//  Created by Николай on 12.12.2021.
//

import Alamofire
import UIKit

public class Backend {
    
    static let url = Config.apiUrl
    
    public static func incDownload(id: Int) {
        
        let url = Backend.url + "item.inc_download"
        print("id = \(id)")
        let parameters: Parameters = [
            "id": id,
            "access_key": Config.accessKey
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters
                   ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func categoryIncClaim(id: [Int]) {
        
        let url = Backend.url + "category.inc_claim"
        
        var parts: [String] = []
        
        for number in id {
            parts.append(String(number))
        }
        
        let parameters: Parameters = [
            "access_key": Config.accessKey,
            "id": parts.joined(separator: ",")
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters
                   ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func tagSearch(q: String, complete: @escaping (_ result: [Tag]) -> Void) {
        
        let url = Backend.url + "tag.search"
        
        let parameters: Parameters = [
            "access_key": Config.accessKey,
            "q": q,
            "lang": Config.getCurrentLanguageCode(),
        ]
        
        AF.request(url,
            method: .post,
            parameters: parameters
        ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                let json = value as! [String:Any]
                let items = json["data"] as! [NSDictionary]
                
                var tags:[Tag] = []
                
                items.forEach { (item) in
                    
                    tags.insert(Tag(
                        id: item["id"] as! Int,
                        name: item["name"] as! String,
                        name_en: item["name_en"] as! String
                    ), at: tags.count)
                }
                
                complete(tags)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func categoryList(complete: @escaping (_ result: [Category]) -> Void) {
        
        let url = Backend.url + "category.list"
        
        let parameters: Parameters = [
            "access_key": Config.accessKey,
        ]
        
        AF.request(url,
            method: .post,
            parameters: parameters
        ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                let json = value as! [String:Any]
                let items = json["data"] as! [NSDictionary]
                
                var categories: [Category] = []
                
                items.forEach { (item) in
                    
                    categories.insert(Category(
                        id: (item["id"] as! NSString).integerValue,
                        name: item["name"] as! String,
                        name_en: item["name_en"] as! String,
                        is_on: false
                    ), at: categories.count)
                }
                
                complete(categories)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func wallpaper(id: Int, categoryId: [Int], tag: Int, complete: @escaping (_ status: Bool, _ result: Wallpaper) -> Void) {
        
        let url = Backend.url + "item.list"
        
        var category_ids: [String] = []
        for element in categoryId {
            category_ids.append(String(element))
        }
        
        let parameters: Parameters = [
            "access_key": Config.accessKey,
            "id": id,
            "category_id": category_ids.joined(separator: ","),
            "tag_id": tag
        ]
        
        var wallpaper = Wallpaper()
        
        AF.request(url,
            method: .post,
            parameters: parameters
        ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                let json = value as! [String:Any]
                let items = json["data"] as! [NSDictionary]
                
                items.forEach { (item) in
                    
                    wallpaper = Wallpaper(
                        id: (item["id"] as! NSString).integerValue,
                        url: item["url"] as! String,
                        source_url: item["source_url"] as! String
                    )
                }
                
                complete(true, wallpaper)
                
            case .failure(let error):
                print(error)
                complete(false, wallpaper)
            }
        }
    }
}
