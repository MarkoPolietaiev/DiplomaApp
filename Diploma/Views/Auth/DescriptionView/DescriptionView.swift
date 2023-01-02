//
//  DescriptionView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-27.
//

import UIKit

struct DescriptionItem {
    var title: String
    var image: UIImage
}

class DescriptionView: BaseView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var action: (() -> ())?
    
    override func setupXib() {
        super.setupXib()
        self.button.layer.cornerRadius = self.button.frame.height/2
        self.button.isHidden = true
    }
    
    func setupWithItem(_ item: DescriptionItem, isLast: Bool = false) {
        self.imageView.image = item.image
        self.label.text = item.title
        if isLast {
            self.button.isHidden = false
        }
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if let action = action {
            action()
        }
    }
}
