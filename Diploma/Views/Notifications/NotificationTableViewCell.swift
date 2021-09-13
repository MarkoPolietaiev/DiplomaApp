//
//  NotificationTableViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-09-12.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var _imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithNotification(_ notification: Notification) {
        self.titleLabel.text = notification.title
    }
    
}
