//
//  StepView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-10-16.
//

import Foundation
import UIKit

class StepView: BaseView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var mediaView: UIView!
    
    override func setupXib() {
        super.setupXib()
    }
    
    func setupWithStep(_ step: Step) {
        self.titleLabel.text = step.title
        self.descriptionTextView.text = step.description
//        self.mediaView.setupWithMedia(step.images)
    }
}
