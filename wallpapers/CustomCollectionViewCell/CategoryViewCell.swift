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
        let index = Int(sender.restorationIdentifier!)!
        Storage.switch_state[index] = sender.isOn
        
        print("set \(index) value \(sender.isOn)")
    }
    
    public func configure(index: Int, name: String, is_on: Bool) {
        labelName.text = name
        radioEnable.setOn(is_on, animated: false)
        
        if(is_on) {
            print("configure \(index) value \(is_on)")
        }
        
        radioEnable.restorationIdentifier = String(index);
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
