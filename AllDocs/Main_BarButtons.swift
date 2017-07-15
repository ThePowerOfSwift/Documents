//
//  MainBarButtons.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 15.07.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

extension MainVC {
    
    
    
    func layoutBarButtons() {
        
        settings = UIBarButtonItem(title: "Настройки", style: .plain, target: self, action: #selector(settingsPressed))
        choose = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(choosePressed))
        addFolder = UIBarButtonItem(title: "Папка", style: .plain, target: self, action: #selector(addFolderPressed))
        cancel = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(hideBottomMenu))
        
        
        navigationItem.rightBarButtonItem = choose
        
        if isFolder == false {
            navigationItem.leftBarButtonItem = settings
        }

    }
    
    
    
    //MARK: - Bar Buttons Actions
    
    func settingsPressed(_ sender: UIBarButtonItem) {
        print("settingsPressed")
        //if topMenuIsShow { showHideTopMenu(show: false) }
        
    }
    
    
    
    func choosePressed(_ sender: UIBarButtonItem) {
        
        arrOfSelectedItems = Array(repeating: false, count: self.frc.fetchedObjects?.count ?? 0)
        showBottomMenu()
        let visibleItems = self.collectionView.indexPathsForVisibleItems
        self.collectionView.reloadItems(at: visibleItems)
        
    }
    
    
    
    
    func addFolderPressed(_ sender: UIBarButtonItem) {
        print("addFolderPressed")
        floaty.close()
        floaty.isHidden = true
        
        _ = SweetAlert().showAlertWithTxtFld("Новая Папка", subTitle: nil, style: .customImag(imageFile: "Folder-icon"), buttonTitle: "Сохранить", buttonColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), otherButtonTitle: "Отмена", action: { (isSaveBtn) in
            if isSaveBtn {
                print("Сохранить")
                self.floaty.isHidden = false
            } else {
                print("Отмена")
                self.floaty.isHidden = false
            }
        })
        
    }
    
    
    
    func showHideBarButtons(_ show: Bool, cancel: Bool) {
        
        if show && cancel {
            navigationItem.rightBarButtonItem  = self.cancel
            showHideBarItems(show: false, left: true)
            
        } else if show {
            navigationItem.leftBarButtonItem = isFolder ? nil : self.addFolder
            showHideBarItems(show: false, left: false)
            
        } else {
            navigationItem.leftBarButtonItem = isFolder ? nil : settings
            navigationItem.rightBarButtonItem = choose
            showHideBarItems(show: true, left: false)
            showHideBarItems(show: true, left: true)
        }
        
    }
    
    
    
    func showHideBarItems(show: Bool, left: Bool) {
        
        if show && left {
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.leftBarButtonItem?.tintColor = .blue
        } else if show && left == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .blue
        } else if show == false && left {
            navigationItem.leftBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.tintColor = .clear
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
        }
    }

    
}
