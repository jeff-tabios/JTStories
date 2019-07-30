//
//  ListViewController+SearchDelegate.swift
//  JTStories
//
//  Created by Jeff Tabios on 30/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if terms.count > 0 {
            tableTermsView.isHidden = false
        }
        tableTermsView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDone()
        if searchBar.text == "" {
            vm.reload()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchDone()
        if let query = searchBar.text {
            terms.append(query)
            vm.reload(with: query)
        }
    }
    
    func searchDone(){
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        tableTermsView.isHidden = true
    }
}
