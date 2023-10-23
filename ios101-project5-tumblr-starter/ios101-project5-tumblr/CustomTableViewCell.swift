//
//  CustomTableViewCell.swift
//  ios101-project5-tumblr
//
//  Created by Abenezer Getachew on 10/21/23.
//

import Foundation
import UIKit
import Nuke

class CustomTableViewCell: UITableViewCell {
    // Your code will go here later
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var summaryLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

    func configureCell(with post: Post) {
        summaryLabel.text = post.summary
        
        if let photo = post.photos.first {
            let imageUrl = photo.originalSize.url // If url is already a URL, no need to convert
            
            // Using Nuke to load the image from the URL
            Nuke.loadImage(with: imageUrl, into: postImageView)
        }
    }


        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
    }
