//
//  SettingsController.swift
//  wallpapers
//
//  Created by Николай on 28.01.2022.
//

import UIKit
import StoreKit

class SettingsController: UIViewController {

    static var identifier = "SettingsController"
    
    var wallpaper: Wallpaper = Wallpaper()
    
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var btnSource: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        
    }
    
    @IBAction func btnSourceClick(_ sender: Any) {
        
        if let link = URL(string: wallpaper.source_url) {
            UIApplication.shared.open(link)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(wallpaper.source_url.isEmpty) {
            
            labelSource.text = "The Author of this picture is unknown".localized()
            btnSource.isHidden = true
        } else {
            
            btnSource.isHidden = false
            labelSource.text = "Author of this picture".localized()
        }
    }
}
