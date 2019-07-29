//
//  StoryViewController.swift
//  JTStories
//
//  Created by Jeff Tabios on 29/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class StoryViewController: UIViewController{
    
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var snippet: UILabel!
    
    var storyViewModel: StoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyImage.load(url: storyViewModel?.image, placeholder: UIImage(named: "noposter"))
        headline.text = storyViewModel?.headline
        snippet.text = storyViewModel?.snippet
        snippet.sizeToFit()
    }
}
