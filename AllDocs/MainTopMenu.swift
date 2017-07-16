//
//  MainTopMenu.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 15.07.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import CustomizableActionSheet

extension MainVC {
    
    
    // ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -60 {
            if !topMenuIsShow && !sideMenuIsShow { showHideTopMenu(show: true) }
        } else if scrollView.contentOffset.y > 10 {
            if topMenuIsShow { showHideTopMenu(show: false) }
        }
        
    }
    
    
    
    
    func showHideTopMenu(show: Bool) {
        
        if show {
            floaty.isHidden = true
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
                self.topMenuHeight.constant = 114.0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
                self.topMenuHeight.constant = 64.0
                self.view.layoutIfNeeded()
            })  { (_) in
                if self.sideMenuIsShow == false && self.filterCancelView.isHidden {
                    self.floaty.isHidden = false
                }
            }
        }
        
        topMenuIsShow = show
    }
 
     
    
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        self.floaty.isHidden = true
        self.isFirstCharecter = true
        if searchController.isActive == false {
            present(searchController, animated: true, completion: {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    
                    self.isFirstCharecter = false
                }
            })
        }
    }
    
    
    // <SortedActionSheet>
    @IBAction func sortedPressed(_ sender: UIButton) {
        
        showHideBarItems(show: false, left: false)
        showHideBarItems(show: false, left: true)
        
        var items = [CustomizableActionSheetItem]()
        
        // First view
        if let sampleView = UINib(nibName: "ActSheetSorted", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ActSheetSorted {
            sampleView.delegate = self
            sampleView.changeColor()
            let sampleViewItem = CustomizableActionSheetItem()
            sampleViewItem.type = .view
            sampleViewItem.view = sampleView
            sampleViewItem.height = 230
            items.append(sampleViewItem)
        }
        
        // Cancel Btn
        let closeItem = CustomizableActionSheetItem()
        closeItem.type = .button
        closeItem.label = "Отмена"
        closeItem.height = 50
        closeItem.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        closeItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            self.showHideBarItems(show: true, left: false)
            self.showHideBarItems(show: true, left: true)
            actionSheet.dismiss()
        }
        items.append(closeItem)
        
        let actionSheet = CustomizableActionSheet()
        self.actionSheetSorted = actionSheet
        actionSheet.showInView(self.view, items: items)
    }

    
    // <FilteredActionSheet>
    @IBAction func filteredPressed(_ sender: UIButton) {
        
        showHideBarItems(show: false, left: false)
        showHideBarItems(show: false, left: true)
        
        var items = [CustomizableActionSheetItem]()
        
        // First view
        if let sampleView = UINib(nibName: "ActSheetFiltered", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ActSheetFiltered {
            sampleView.delegate = self
            let sampleViewItem = CustomizableActionSheetItem()
            sampleViewItem.type = .view
            sampleViewItem.view = sampleView
            sampleViewItem.height = 120
            items.append(sampleViewItem)
        }
        
        // Second button
        let closeItem = CustomizableActionSheetItem()
        closeItem.type = .button
        closeItem.label = "Отмена"
        closeItem.height = 50
        closeItem.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        closeItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            self.showHideBarItems(show: true, left: false)
            self.showHideBarItems(show: true, left: true)
            actionSheet.dismiss()
        }
        items.append(closeItem)
        
        let actionSheet = CustomizableActionSheet()
        self.actionSheetFiltered = actionSheet
        actionSheet.showInView(self.view, items: items)
    }
    
    
    // <TagsActionSheet>
    @IBAction func choseTagPressed(_ sender: UIButton) {
        
        showHideBarItems(show: false, left: false)
        showHideBarItems(show: false, left: true)
        
        var items = [CustomizableActionSheetItem]()
        
        // First view
        if let sampleView = UINib(nibName: "ActSheetTags", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ActSheetTags {
            sampleView.delegate = self
            let sampleViewItem = CustomizableActionSheetItem()
            sampleViewItem.type = .view
            sampleViewItem.view = sampleView
            sampleViewItem.height = 100
            items.append(sampleViewItem)
        }
        
        //        // Second button
        //        let clearItem = CustomizableActionSheetItem()
        //        clearItem.type = .button
        //        clearItem.label = "Очистить фильтр"
        //        clearItem.backgroundColor = UIColor(red: 1, green: 0.41, blue: 0.38, alpha: 1)
        //        clearItem.textColor = UIColor.white
        //        clearItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
        //            self.frc.fetchRequest.predicate = nil
        //            self.reloadMainVC()
        //            actionSheet.dismiss()
        //        }
        //        items.append(clearItem)
        
        // Third button
        let closeItem = CustomizableActionSheetItem()
        closeItem.type = .button
        closeItem.label = "Отмена"
        closeItem.height = 50
        closeItem.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        closeItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            self.showHideBarItems(show: true, left: false)
            self.showHideBarItems(show: true, left: true)
            actionSheet.dismiss()
        }
        items.append(closeItem)
        
        let actionSheet = CustomizableActionSheet()
        self.actionSheetTags = actionSheet
        actionSheet.showInView(self.view, items: items)
    }
    
    
    
    
    //MARK: Bottom clear menu (clear filter or tag)
    
    @IBAction func clearFilterPressed(_ sender: UIButton) {
        
        self.frc.fetchRequest.predicate = isFolder ? NSPredicate(format: "toFirst == %@", self.folder!) : nil
        CoreDataManager.instance.performFetch(self.frc)
        arrOfSelectedItems = Array(repeating: false, count: self.frc.fetchedObjects?.count ?? 0)
        self.reloadMainVC()
        self.filterCancelView.isHidden = true
        self.floaty.isHidden = false
        
    }
    
    
}
