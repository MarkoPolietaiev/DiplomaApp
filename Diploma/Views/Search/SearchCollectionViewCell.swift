//
//  SearchCollectionViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-09-12.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWithPost(_ post: Post) {
        self.imageView.image = post.image
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let selectAction = selectAction {
            selectAction()
        }
    }
}
