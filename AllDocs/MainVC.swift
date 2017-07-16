//
//  MainVC.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 20.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit
import Floaty
import CoreData
import CustomizableActionSheet


func addThreeObjects() {
    
    let first = First()
    first.name = "Archive"
    first.type = type(.zip)
    first.date = NSDate()
    
    
    let fir = First()
    fir.name = "PDF"
    fir.type = type(.pdf)
    fir.date = NSDate()
    
    
    let firs = First()
    firs.name = "Txt"
    firs.type = type(.txt)
    firs.date = NSDate()
    
    
    
    let fird = First()
    fird.name = "Jpeg"
    fird.type = type(.jpeg)
    fird.date = NSDate()
    
    CoreDataManager.instance.saveContext()
    
}


class MainVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var topMenuHeight    : NSLayoutConstraint!
    @IBOutlet weak var sortedBy         : UILabel!
    @IBOutlet weak var filteredBy       : UILabel!
    @IBOutlet weak var floaty           : Floaty!
    @IBOutlet weak var bottomMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var filterCancelView: UIView!
    @IBOutlet weak var filterOrTag: UILabel!
    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var miniTagColor: UIView!

    
    var frc: NSFetchedResultsController<NSFetchRequestResult>!
    
    var isFolder         = false
    var topMenuIsShow    = false
    var sideMenuIsShow   = false
    var isFirstCharecter = false
    
    
    var folder: First?
    
    var imageFromGallery: UIImage?
    
    var searchResultFirst  = [First]()
    var searchResultSecond = [Second]()
    var arrOfSelectedItems = [Bool]()
    
    var actionSheetSorted  : CustomizableActionSheet?
    var actionSheetFiltered: CustomizableActionSheet?
    var actionSheetTags    : CustomizableActionSheet?
    
    var settings:   UIBarButtonItem!
    var addFolder:  UIBarButtonItem!
    var choose:     UIBarButtonItem!
    var cancel:     UIBarButtonItem!
    var back:       UIBarButtonItem?
    
    var longPressGesture: UILongPressGestureRecognizer!
    
    var searchController: UISearchController = ({
        
        let controller = UISearchController(searchResultsController: nil)
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barTintColor = UIColor.gray
        
        //controller.searchBar.textField?.tintColor = UIColor.gray // в скан есть extention
        controller.searchBar.tintColor = .white
        controller.searchBar.layer.borderWidth = 1
        controller.searchBar.layer.borderColor = UIColor.white.cgColor

        
        return controller
    })()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frc = isFolder ? CoreDataManager.instance.FRC("Second") : CoreDataManager.instance.FRC("First")
        
        if isFolder == true {
            frc.fetchRequest.predicate = NSPredicate(format: "toFirst == %@", self.folder!)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        frc.delegate = self
        CoreDataManager.instance.performFetch(frc)
        
        layoutAddButton()
        layoutBarButtons()
        
        searchController.searchResultsUpdater = self
        searchController.loadViewIfNeeded()
        
        bottomMenuWidth.constant = 0
        
        arrOfSelectedItems = Array(repeating: false, count: self.frc.fetchedObjects?.count ?? 0)

        
        
        //-----------------
//        addThreeObjects()
//        reloadMainVC()
        //-----------------
//        let obj = frc.fetchedObjects?.first as! First
//
//        let sec = Second()
//        sec.name = "png"
//        sec.type = type(.png)
//        sec.date = NSDate()
//        sec.toFirst = obj
//        
//
//        let se = Second()
//        se.name = "txt"
//        se.type = type(.txt)
//        se.date = NSDate()
//        se.toFirst = obj
//        
//        CoreDataManager.instance.saveContext()
    
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        
        addNotification("reloadMain", selector: #selector(reloadMainVC), vc: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.began && sideMenuIsShow == false {
            
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else { return }
            showBottomMenu()
            
            let visibleItems = self.collectionView.indexPathsForVisibleItems
            self.arrOfSelectedItems[selectedIndexPath.row] = true
            self.collectionView.reloadItems(at: visibleItems)
            
            if topMenuIsShow {
                floaty.isHidden = false
            }
        }
    }

    

    
    func reloadMainVC () {
        
        CoreDataManager.instance.performFetch(frc)
        
        //TODO: обновить только последний
        collectionView.reloadData()
    }
    
    
    func reloadVisibleCells() {
        
        CoreDataManager.instance.performFetch(frc)
        let visibleCells = collectionView.indexPathsForVisibleItems
        collectionView.reloadItems(at: visibleCells)
    }
    
    
}





// MARK: Collection View DataSource/Delegate

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchController.isActive {
            
            return isFolder ? searchResultSecond.count : searchResultFirst.count
        } else {
            return frc.sections?[0].numberOfObjects ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCell
        
        if isFolder {
            
            // In Folder
            
            let object = searchController.isActive ? searchResultSecond[indexPath.row] : frc.object(at: indexPath) as! Second
            
            cell.name.text = object.name
            cell.checkBox.isHidden = sideMenuIsShow ? false : true
            cell.checkBox.on = arrOfSelectedItems[indexPath.row]
            
            switch object.type {
            case type(.pdf)?    : cell.image.image = UIImage(named: "pdf")
            case type(.jpeg)?   : cell.image.image = UIImage(named: "jpeg")
            case type(.txt)?    : cell.image.image = UIImage(named: "txt")
            case type(.zip)?    : cell.image.image = UIImage(named: "zip")
            default : cell.image.image = UIImage(named: "png")
            }
           
            return cell
            
        } else {
            
            // Main
            
            let object = searchController.isActive ? searchResultFirst[indexPath.row] : frc.object(at: indexPath) as! First
            
            cell.name.text = object.name
            cell.checkBox.isHidden = sideMenuIsShow ? false : true
            cell.checkBox.on = arrOfSelectedItems[indexPath.row]
            
            switch object.type {
            case type(.folder)? : cell.image.image = UIImage(named: "Folder")
            case type(.pdf)?    : cell.image.image = UIImage(named: "pdf")
            case type(.jpeg)?   : cell.image.image = UIImage(named: "jpeg")
            case type(.txt)?    : cell.image.image = UIImage(named: "txt")
            case type(.zip)?    : cell.image.image = UIImage(named: "zip")
            default : cell.image.image = UIImage(named: "Folder")
            }
            
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isFolder {
            
            // In Folder
            
            let object = searchController.isActive ? searchResultSecond[indexPath.row] : frc.object(at: indexPath) as! Second
            let cell = collectionView.cellForItem(at: indexPath) as! MainCell
            
            if sideMenuIsShow {
                
                arrOfSelectedItems[indexPath.row] = !arrOfSelectedItems[indexPath.row]
                cell.checkBox.setOn(arrOfSelectedItems[indexPath.row], animated: true)
                
                
            } else {
                
                switch object.type! {
                case type(.pdf)    : print("pdf")
                case type(.jpeg)   : print("jpeg")
                case type(.txt)    : print("txt")
                case type(.zip)    : print("zip")
                    
                default:
                    break
                }
            }
            
        } else {
            
            //Main
            
            let object = searchController.isActive ? searchResultFirst[indexPath.row] : frc.object(at: indexPath) as! First
            let cell = collectionView.cellForItem(at: indexPath) as! MainCell
            
            if sideMenuIsShow {
                
                arrOfSelectedItems[indexPath.row] = !arrOfSelectedItems[indexPath.row]
                cell.checkBox.setOn(arrOfSelectedItems[indexPath.row], animated: true)
                
                
            } else {
                
                switch object.type! {
                    
                case type(.folder) :
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "mainvc") as! MainVC
                    controller.isFolder = true
                    controller.folder = object
                    
                    if let nav = navigationController {
                        nav.show(controller, sender: self)
                    }
                    
                case type(.pdf)    : print("pdf")
                case type(.jpeg)   : print("jpeg")
                case type(.txt)    : print("txt")
                case type(.zip)    : print("zip")
                    
                default:
                    break
                }
            }
        }
        
        
        if searchController.isActive {
            searchController.isActive = false
        }
    }
    
}






// MARK: Collection View Data/Delegate

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat = (UIScreen.main.bounds.width / 3) - 12.5
        let height : CGFloat = 116.0
        
        return CGSize(width: width, height: height)
    }
}



