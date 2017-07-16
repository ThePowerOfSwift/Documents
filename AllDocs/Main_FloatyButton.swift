//
//  Buttons.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 21.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import Foundation
import Floaty







extension MainVC: FloatyDelegate {
    
    
    func layoutAddButton() {
        
        floaty.fabDelegate = self
        
        floaty.addItem("Облако", icon: nil) { (item) in
            print("Cloud")
        }
        floaty.addItem("Галерея", icon: nil) { (item) in
            print("Gallery")
            
            //self.openScaner(true)
            self.chooseImagePickerAction()
        }
        floaty.addItem("Камера", icon: nil) { (item) in
            print("Camera")
            
            self.openScaner()
        }
        
        //addFloatyButtons(largeItems: true)
    }

    
    
    // MARK: - Floaty Delegate Methods
    
    func floatyOpened(_ floaty: Floaty) {
        showHideBarButtons(true, cancel: false)
    }
    
    
    
    
    func floatyClosed(_ floaty: Floaty) {
        showHideBarButtons(false, cancel: false)
        //addFloatyButtons(largeItems: true)
    }
    
    

    
}





