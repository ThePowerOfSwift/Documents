//
//  CommonFunctions.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 21.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

enum DocumentType {
    
    case folder
    case pdf
    case png
    case jpeg
    case txt
    case zip
}

func type(_ docType: DocumentType) -> String {
    
    switch docType {
    case .folder: return "folder"
    case .pdf: return "pdf"
    case .png: return "png"
    case .jpeg: return "jpeg"
    case .txt: return "txt"
    case .zip: return "zip"
    }
    
}


enum DocumentTags {
    
    case red
    case orange
    case yellow
    case green
    case blue
}

func tags(_ docType: DocumentTags) -> String {
    
    switch docType {
    case .red: return "red"
    case .orange: return "orange"
    case .yellow: return "yellow"
    case .green: return "green"
    case .blue: return "blue"
    }
    
}


func addNotification(_ name: String, selector: Selector, vc: UIViewController) {
    NotificationCenter.default.addObserver(vc, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
}

func postNotification(_ name: String) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil)
}




