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
    
    var selectAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self._imageView.layer.cornerRadius = self._imageView.frame.height/2
    }
    
    func setupWithNotification(_ notification: Notification) {
        self.titleLabel.text = notification.title
        self._imageView.image = notification.image
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let selectAction = selectAction {
            selectAction()
        }
    }
}
