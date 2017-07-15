//
//  MainActSheetFiltered.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import CustomizableActionSheet


extension MainVC: ActSheetFilteredDelegate {
    
    func setNameForPredicate(_ name: String) {
        if let actionSheetFiltered = self.actionSheetFiltered {
            actionSheetFiltered.dismiss()
        }
        
        if self.isFolder {
            let firstPredicate = NSPredicate(format: "toFirst == %@", self.folder!)
            let secondPredicate = NSPredicate(format: "type == '\(name)'", self.frc)
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [firstPredicate, secondPredicate])
            self.frc.fetchRequest.predicate = compound
        } else {
            self.frc.fetchRequest.predicate = NSPredicate(format: "type == '\(name)'", self.frc)
        }
        self.reloadMainVC()
        
        self.floaty.isHidden = true
        
        showHideBarItems(show: true, left: false)
        showHideBarItems(show: true, left: true)
        
        filterCancelView.frame = CGRect(x: 8, y: UIScreen.main.bounds.height + 10, width: UIScreen.main.bounds.width - 16.0, height: 50)
        filterCancelView.isHidden = false
        
        self.filterOrTag.text = "Фильтр по типу:"
        self.miniTagColor.isHidden = true
        self.filterName.isHidden = false
        
        switch name {
        case "folder":
            self.filterName.text = "Папка"
        case "pdf":
            self.filterName.text = "PDF"
        case "png":
            self.filterName.text = "PNG"
        case "jpeg":
            self.filterName.text = "JPEG"
        case "txt":
            self.filterName.text = "TXT"
        case "zip":
            self.filterName.text = "Архив"
        default:
            break
        }
        
        UIView.animate(withDuration: 0.5) {
            self.filterCancelView.frame = CGRect(x: 8, y: UIScreen.main.bounds.height - 58, width: UIScreen.main.bounds.width - 16.0, height: 50)
            self.view.layoutIfNeeded()
        }
        
    }
}
