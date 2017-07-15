//
//  MainActSheetSorted.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import CustomizableActionSheet


extension MainVC: ActSheetSortedDelegate {
    
    func setNameForSort(_ name: String, accending: Bool) {
        
        UserDefaults.standard.set(name, forKey: "sortName")
        UserDefaults.standard.set(accending, forKey: "accending")
        
        self.frc.fetchRequest.sortDescriptors = [NSSortDescriptor(key: name, ascending: accending)]
        self.reloadMainVC()
        
        self.floaty.isHidden = true

        showHideBarItems(show: true, left: false)
        showHideBarItems(show: true, left: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
            if let actionSheetSorted = self.actionSheetSorted {
                actionSheetSorted.dismiss()
            }
        }
    }
}
