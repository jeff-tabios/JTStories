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
    let vm = StoriesViewModel(api: API())
    
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
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StorySegue" {
            let s = sender as! ListCell
            let controller = segue.destination as! StoryViewController
            controller.storyViewModel = s.storyViewModel
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.storyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.storyViewModel = vm.storyViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = vm.storyViewModels.count - 1
        if indexPath.row == lastElement {
            vm.getNextPage()
        }
    }
}
