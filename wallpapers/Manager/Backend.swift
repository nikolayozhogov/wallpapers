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
    
    static var wallpapers:Wallpaper = Wallpaper()
    
    public static func incDownload(id: Int) {
        
        let url = Backend.url + "item.inc_download"
        print("id = \(id)")
        let parameters: Parameters = [
            "id": id
        ]
        
        AF.request(url,
                   method: .get,
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
            "id": parts.joined(separator: ",")
        ]
        
        AF.request(url,
                   method: .get,
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
            "q": q,
            "lang": Config.getCurrentLanguageCode(),
        ]
        
        AF.request(url,
            method: .get,
            parameters: parameters
        ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                let json = value as! [String:Any]
                let items = json["data"] as! [NSDictionary]
                
                var tags:[Tag] = []
                
                items.forEach { (item) in
                    
                    tags.insert(Tag(
                        id: (item["id"] as! NSString).integerValue,
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
        
        AF.request(url).responseJSON { responseJSON in
            
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
    
    public static func wallpaper(id: Int, category_id: [Int], limit: Int, complete: @escaping (_ status: Bool, _ result: Wallpaper) -> Void) {
        
        let url = Backend.url + "item.list"
        
        //print(Storage.switch_state)
        
        var category_ids: [String] = []
        for (index, element) in Storage.switch_state.enumerated() {
            if(Bool(element)) {
                category_ids.append(String(index))
            }
        }
        
        let parameters: Parameters = [
            "id": id,
            "limit": limit,
            "category_id": category_ids.joined(separator: ",")
        ]
        
        AF.request(url,
            method: .get,
            parameters: parameters
        ).responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                let json = value as! [String:Any]
                let items = json["data"] as! [NSDictionary]
                
                items.forEach { (item) in
                    
                    self.wallpapers = Wallpaper(
                        id: (item["id"] as! NSString).integerValue,
                        url: item["url"] as! String,
                        source_url: item["source_url"] as! String
                        //source_url: ""
                    )
                }
                
                complete(true, self.wallpapers)
                
            case .failure(let error):
                print(error)
                complete(false, self.wallpapers)
            }
        }
    }
}
