//
//  ListCell.swift
//  JTStories
//
//  Created by Jeff Tabios on 29/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var snippet: UILabel!
    
    var storyViewModel: StoryViewModel? {
        didSet{
            storyImage.load(url: storyViewModel?.image, placeholder: UIImage(named: "noposter")) 
            heading.text = storyViewModel?.headline
            snippet.text = storyViewModel?.snippet
        }
    }
}
