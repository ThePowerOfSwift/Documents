//
//  MainSearch.swift
//  AllDocs
//
//  Created by Владимир Моисеев on 23.06.17.
//  Copyright © 2017 iCo. All rights reserved.
//

import UIKit

extension MainVC: UISearchResultsUpdating {//, UISearchBarDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            
            if self.isFirstCharecter == false {
                collectionView.reloadData()
            }
        }
    }
    
    
    func filterContent(searchText: String) {
        
        CoreDataManager.instance.performFetch(self.frc)
        
        
        if isFolder == false {
            
            searchResultFirst = self.frc.fetchedObjects as! [First]
            searchResultFirst = searchResultFirst.filter({ (entity: First) -> Bool in
                let nameMatch = entity.name?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                
                if searchText.characters.count == 0 {
                    
                    return nameMatch == nil
                } else {
                    return nameMatch != nil
                }
            })
        
        } else {
            
            searchResultSecond = self.frc.fetchedObjects as! [Second]
            searchResultSecond = searchResultSecond.filter({ (entity: Second) -> Bool in
                let nameMatch = entity.name?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                
                if searchText.characters.count == 0 {
                    
                    return nameMatch == nil
                } else {
                    return nameMatch != nil
                }
            })
        }
    }
}
