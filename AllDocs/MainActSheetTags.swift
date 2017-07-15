//
//  MainActSheetTags.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import CustomizableActionSheet


extension MainVC: ActSheetTagsDelegate {
    
    func setTagColor(_ color: String) {
        if let actionSheetTags = self.actionSheetTags {
            actionSheetTags.dismiss()
        }
        
        if self.isFolder {
            let firstPredicate = NSPredicate(format: "toFirst == %@", self.folder!)
            let secondPredicate = NSPredicate(format: "type == '\(color)'", self.frc)
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [firstPredicate, secondPredicate])
            self.frc.fetchRequest.predicate = compound
        } else {
            self.frc.fetchRequest.predicate = NSPredicate(format: "tag == '\(color)'", self.frc)
        }
        self.reloadMainVC()
        
        self.floaty.isHidden = true

        showHideBarItems(show: true, left: false)
        showHideBarItems(show: true, left: true)
        
        filterCancelView.frame = CGRect(x: 8, y: UIScreen.main.bounds.height + 10, width: UIScreen.main.bounds.width - 16.0, height: 50)
        filterCancelView.isHidden = false
        
        self.filterOrTag.text = "Фильтр по тегу:"
        self.filterName.isHidden = true
        self.miniTagColor.isHidden = false
        self.miniTagColor.alpha = 0.5
        
        switch color {
        case "red":
            self.miniTagColor.backgroundColor =  UIColor.red
        case "orange":
            self.miniTagColor.backgroundColor = UIColor.orange
        case "yellow":
            self.miniTagColor.backgroundColor = UIColor.yellow
        case "green":
            self.miniTagColor.backgroundColor = UIColor.green
        case "blue":
            self.miniTagColor.backgroundColor = UIColor.blue
            
        default:
            break
        }
        
        UIView.animate(withDuration: 0.5) {
            self.filterCancelView.frame = CGRect(x: 8, y: UIScreen.main.bounds.height - 58, width: UIScreen.main.bounds.width - 16.0, height: 50)
            self.view.layoutIfNeeded()
        }
    }
    
}
