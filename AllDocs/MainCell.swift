//
//  MainCell.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 20.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import BEMCheckBox


class MainCell: UICollectionViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    
    override func awakeFromNib() {
        checkBox.delegate = self
        checkBox.boxType = .circle
    }

}
