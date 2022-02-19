//
//  TagViewCell.swift
//  wallpapers
//
//  Created by Николай on 03.02.2022.
//

import UIKit

class TagViewCell: UICollectionViewCell {

    static var identifier = "TagViewCell"
    
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(tag: Tag) {
        
        labelName.text = tag.name
        if(Config.getCurrentLanguageCode() == "en") {
            labelName.text = tag.name_en
        }
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
