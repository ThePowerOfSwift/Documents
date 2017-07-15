//
//  ActSheetTags.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

protocol ActSheetTagsDelegate {
    func setTagColor(_ color: String)
}

class ActSheetTags: UIView {

    var delegate: ActSheetTagsDelegate?
    
    @IBAction func color1WasTapped() {
        self.delegate?.setTagColor(tags(.red))
    }
    
    @IBAction func color2WasTapped() {
        self.delegate?.setTagColor(tags(.orange))
    }
    
    @IBAction func color3WasTapped() {
        self.delegate?.setTagColor(tags(.yellow))
    }
    
    @IBAction func color4WasTapped() {
        self.delegate?.setTagColor(tags(.green))
    }
    
    @IBAction func color5WasTapped() {
        self.delegate?.setTagColor(tags(.blue))
    }
}

