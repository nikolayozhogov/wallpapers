//
//  CategoryViewCell.swift
//  wallpapers
//
//  Created by Николай on 19.12.2021.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {

    static var identifier = "CategoryViewCell"
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var radioEnable: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        
        let categoryId = Int(sender.restorationIdentifier!)!
        Storage.setCategorySwitchState(categoryId: categoryId, isOn: sender.isOn)
        print("set \(categoryId) value \(sender.isOn)")
    }
    
    public func configure(category: Category) {
        
        labelName.text = category.name
        if(Config.getCurrentLanguageCode() != "ru") {
            labelName.text = category.name_en
        }
        
        radioEnable.setOn(Storage.getCategorySwitchState(categoryId: category.id), animated: false)
        
        radioEnable.restorationIdentifier = String(category.id);
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
