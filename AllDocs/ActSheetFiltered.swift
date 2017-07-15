//
//  ActSheetFiltered.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

protocol ActSheetFilteredDelegate {
    func setNameForPredicate(_ name: String)
}

class ActSheetFiltered: UIView {
    
    var delegate: ActSheetFilteredDelegate?

    @IBAction func folder(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.folder))
    }

    @IBAction func pdf(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.pdf))
    }
    
    @IBAction func png(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.png))
    }
    
    @IBAction func jpeg(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.jpeg))
    }
    
    @IBAction func txt(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.txt))
    }
    
    @IBAction func zip(_ sender: UIButton) {
        delegate?.setNameForPredicate(type(.zip))
    }
    
}
