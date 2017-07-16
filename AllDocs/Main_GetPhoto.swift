//
//  Main_GetPhoto.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 15.07.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageFromGallery = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            print(imageFromGallery.size)
            // -> Open borderDetect
            let myVC = UIVC_CameraScanner(nibName: "UIVC_CameraScanner", bundle: nil)
            myVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            myVC.cameraScannerDelegate = self
            myVC.isEnterFromGallery = true
            myVC.imageFromGallery = imageFromGallery
            
            self.present(myVC, animated: true, completion: nil)
            
        }
    }
    

    
    
    func chooseImagePickerAction() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }




}
