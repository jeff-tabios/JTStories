//
//  ListTableViewDelegate.swift
//  JTStories
//
//  Created by Jeff Tabios on 30/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

extension StoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableTermsView{
            return termsVM.count
        }
        return storiesVM.storyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableTermsView{
            let cell = UITableViewCell()
            cell.textLabel?.text = termsVM.getTerm(termsVM.count-indexPath.row-1)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
            cell.storyViewModel = storiesVM.storyViewModels[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchDone()
        if tableView == self.tableTermsView{
            if let query = tableView.cellForRow(at: indexPath)?.textLabel?.text{
                    storiesVM.reload(with: query)
                    searchBar.text = query
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.tableListView{
            let lastElement = storiesVM.storyViewModels.count - 1
            if indexPath.row == lastElement {
                storiesVM.getNextPage()
            }
        }
    }
}
