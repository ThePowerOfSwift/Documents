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
