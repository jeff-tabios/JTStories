//
//  StoriesViewController+SearchDelegate.swift
//  JTStories
//
//  Created by Jeff Tabios on 30/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

extension StoriesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if termsVM.count > 0 {
            tableTermsView.isHidden = false
        }
        tableTermsView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDone()
        if searchBar.text == "" {
            storiesVM.reload()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchDone()
        if let query = searchBar.text {
            termsVM.save(term:query)
            storiesVM.reload(with: query)
        }
    }
    
    func searchDone(){
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        tableTermsView.isHidden = true
    }
}
