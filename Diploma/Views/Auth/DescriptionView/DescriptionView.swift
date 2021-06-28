//
//  DescriptionView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-27.
//

import UIKit

class DescriptionView: BaseView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func setupXib() {
        super.setupXib()
    }
    
    func setupWithItem(_ item: DescriptionItem) {
        self.imageView.image = item.image
        self.label.text = item.title
    }
}
