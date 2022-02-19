//
//  Image.swift
//  wallpapers
//
//  Created by Николай on 12.12.2021.
//

import UIKit

class Image {
    
    static var cached: [String: UIImage] = [:]
        
    public static func setImage(from url: String, complete: @escaping (_ image: UIImage) -> Void) {
        
        guard let imageURL = URL(string: url) else {
            complete(UIImage.init(named: "nophoto")!)
            return
        }
        
        /*if(cached[url] != nil) {
            let image = cached[url]
            complete(image!)
            return
        }*/
        
        DispatchQueue.global().async {
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                complete(UIImage.init(named: "nophoto")!)
                return
            }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                //cached[url] = image!
                complete(image!)
            }
        }
    }
}
