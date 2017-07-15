//
//  MainFunctions.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 15.07.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import CustomizableActionSheet

extension MainVC {
    
    
    func showBottomMenu() {
        floaty.isHidden = true
        showHideBarButtons(true, cancel: true)
        sideMenuIsShow = true
        
        if topMenuIsShow { showHideTopMenu(show: false) }
        if filterCancelView.isHidden == false {
            self.filterCancelView.isHidden = true
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomMenuWidth.constant = 58
            self.view.layoutIfNeeded()
        }) { (_) in
            self.view.setNeedsLayout()
        }
    }
    
    
    
    func hideBottomMenu() {
        
        showHideBarButtons(false, cancel: false)
        sideMenuIsShow = false
        
        let visibleItems = self.collectionView.indexPathsForVisibleItems
        self.collectionView.reloadItems(at: visibleItems)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomMenuWidth.constant = 0
            self.view.layoutIfNeeded()
            
        }) { (_) in
            
            self.floaty.isHidden = false
            if self.isFolder {
                if self.frc.fetchRequest.predicate != NSPredicate(format: "toFirst == %@", self.folder!) {
                    self.frc.fetchRequest.predicate = NSPredicate(format: "toFirst == %@", self.folder!)
                }
                
            } else {
                
                if self.frc.fetchRequest.predicate != nil {
                    self.frc.fetchRequest.predicate = nil
                }
            }
            CoreDataManager.instance.performFetch(self.frc)
            self.arrOfSelectedItems = Array(repeating: false, count: self.frc.fetchedObjects?.count ?? 0)
            self.reloadMainVC()
        }
    }
    
    
    
    
    //MARK: Bottom menu buttons actions
    
    @IBAction func copyPressed(_ sender: UIButton) {
    }
    
    @IBAction func movePressed(_ sender: UIButton) {
    }
    
    @IBAction func renamePressed(_ sender: UIButton) {
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
    }
    
    @IBAction func stillPressed(_ sender: UIButton) {
    }
    
    
}
