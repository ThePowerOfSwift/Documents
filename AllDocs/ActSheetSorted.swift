//
//  ActSheetSorted.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

protocol ActSheetSortedDelegate {
    func setNameForSort(_ name: String, accending: Bool)
}

class ActSheetSorted: UIView {
    
    @IBOutlet weak var nameDown: UIView!
    @IBOutlet weak var nameUp: UIView!
    @IBOutlet weak var dateDown: UIView!
    @IBOutlet weak var dateUp: UIView!
    @IBOutlet weak var typeDown: UIView!
    @IBOutlet weak var typeUp: UIView!
    
    
    var delegate: ActSheetSortedDelegate?

    @IBAction func nameDown(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("name", accending: true)
        
    }
    
    @IBAction func nameUp(_ sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("name", accending: false)
    }
    
    @IBAction func dateDown(_ sender: UIButton) {
        UserDefaults.standard.set(2, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("date", accending: true)
    }
    
    @IBAction func dateUp(_ sender: UIButton) {
        UserDefaults.standard.set(3, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("date", accending: false)
    }
    
    @IBAction func typeDown(_ sender: UIButton) {
        UserDefaults.standard.set(4, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("type", accending: true)
    }
    
    @IBAction func typeUp(_ sender: UIButton) {
        UserDefaults.standard.set(5, forKey: "sortColor")
        changeColor()
        delegate?.setNameForSort("type", accending: false)
    }
    
    
    func changeColor() {
        let arr = [nameDown, nameUp, dateDown, dateUp, typeDown, typeUp]
        for i in arr {
            i?.backgroundColor = .green
        }
        arr[UserDefaults.standard.value(forKey: "sortColor") as? Int ?? 4]?.backgroundColor = .red
    }

}
