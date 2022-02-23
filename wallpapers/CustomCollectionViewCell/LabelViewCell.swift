//
//  LabelViewCell.swift
//  wallpapers
//
//  Created by Николай on 18.02.2022.
//

import UIKit

class LabelViewCell: UICollectionViewCell {

    static var identifier = "LabelViewCell"
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(text: String) {
        labelName.text = text
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
