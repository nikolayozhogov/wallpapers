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

        /*Purchases.default.initialize {
            [weak self] result in
            guard let self = self else {
                return
            }
            self.hideSpinner()
            switch result {
                case let .success(products):
                DispatchQueue.main.async {
                    self.updateInterface(products: products)
                }
                default:
                break
            }
        }*/
    }
    
    private func updateInterface(products: [SKProduct]) {
        print("updateInterface")
    }
    
    @IBAction func btnPurchaseClick(_ sender: Any) {
        print("click")
        
        Purchases.default.buy()
    }
    
    @IBAction func btnSourceClick(_ sender: Any) {
        
        if let link = URL(string: wallpaper.source_url) {  UIApplication.shared.open(link)}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(wallpaper.source_url.isEmpty) {
            
            labelSource.text = "Источник данного изображения неизвестен"
            btnSource.isHidden = true
        } else {
            
            btnSource.isHidden = false
            labelSource.text = "Источник изображения"
        }
    }
}
