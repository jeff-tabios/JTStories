//
//  ViewController.swift
//  JTStories
//
//  Created by Jeff Tabios on 27/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableListView: UITableView!
    @IBOutlet weak var tableTermsView: UITableView!
    let searchBar = UISearchBar()
    
    var vm = StoriesViewModel(api: API())
    var terms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup(){
        vm.getNextPage()
        vm.refreshStoryListClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableListView.reloadData()
            }
        }
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        tableTermsView.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let guide = view.safeAreaLayoutGuide
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableTermsView.translatesAutoresizingMaskIntoConstraints = false
            tableTermsView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -keyboardSize.height+44).isActive = true
        }
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StorySegue" {
            let s = sender as! ListCell
            let controller = segue.destination as! StoryViewController
            controller.storyViewModel = s.storyViewModel
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
