//
//  MainScaner.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 15.07.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

extension MainVC: CameraScannerProtocol {

    
    func openScaner() {
        
        let myVC = UIVC_CameraScanner(nibName: "UIVC_CameraScanner", bundle: nil)
        myVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        myVC.cameraScannerDelegate = self
        
        self.present(myVC, animated: true, completion: nil)
    }
    

    
    
    func DocumentCaptured(image: UIImage) {
        let tools = Tools()
        tools.savePhotoToLibrary(image: image, uiViewController: self)
    }


}
