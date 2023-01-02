//
//  PostingTableViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-02.
//

import UIKit

class PostingTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var posting: Posting?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWithPosting(_ posting: Posting) {
        self.posting = posting
        self.titleLabel.text = posting.title
        self.tagsLabel.text = posting.tags.map({$0.name}).joined(separator: ", ")
        self.timeLabel.text = "Requires \(posting.timeMinutes) minutes"
    }
}
