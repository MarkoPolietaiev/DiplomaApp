//
//  ImageDetailViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-02.
//

import UIKit

class ImageDetailViewController: BaseViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isDefaultBackground = false
        self.detailImageView.image = image
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: self.detailImageView.frame.height + self.detailImageView.frame.origin.y + 30.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
