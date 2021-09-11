//
//  FeedTableViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-09-08.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    var moreAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moreButton.layer.cornerRadius = self.moreButton.frame.height/2
        // Initialization code
    }
    
    
    func setupWithPost(_ post: Post) {
        self.usernameLabel.text = post.skill.user.username
        self.skillLabel.text = post.skill.title
        self.userImageView.image = post.skill.user.image
        self.postImageView.image = post.image
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        if let moreAction = moreAction {
            moreAction()
        }
    }
    
}
