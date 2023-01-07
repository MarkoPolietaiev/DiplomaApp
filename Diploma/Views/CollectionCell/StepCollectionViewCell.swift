//
//  StepCollectionViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-05.
//

import UIKit

protocol StepCollectionViewCellDelegate: AnyObject {
    func deleteStep(_ indexPath: IndexPath)
    func editStep(_ indexPath: IndexPath)
}

class StepCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var stepImageView: UIImageView!
    
    weak var delegate: StepCollectionViewCellDelegate?
    
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
    
    func setupWithStep(_ step: Step, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.titleLabel.text = step.name
        if let localImage = step.localImage {
            self.stepImageView.image = localImage
        } else {
            self.stepImageView.sd_setImage(with: URL(string: step.image ?? ""), placeholderImage: UIImage(systemName: "square.grid.3x1.folder.badge.plus"))
        }
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let indexPath = indexPath {
            self.delegate?.deleteStep(indexPath)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if let indexPath = indexPath {
            self.delegate?.editStep(indexPath)
        }
    }
}
