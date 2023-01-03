//
//  StepTableViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-02.
//

import UIKit
import SDWebImage

protocol StepTableViewCellDelegate: AnyObject {
    func showImage(_ image: UIImage)
}

class StepTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepImageView: UIImageView!
    
    weak var delegate: StepTableViewCellDelegate?
    
    var step: Step?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWithStep(_ step: Step) {
        self.step = step
        self.titleLabel.text = step.name
        if let localImage = step.localImage {
            self.stepImageView.image = localImage
        } else {
            self.stepImageView.sd_setImage(with: URL(string: step.image ?? ""), placeholderImage: UIImage(systemName: "square.grid.3x1.folder.badge.plus"))
        }
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        self.delegate?.showImage(self.stepImageView.image ?? UIImage())
    }
}
