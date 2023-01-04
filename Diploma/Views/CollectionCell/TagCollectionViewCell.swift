//
//  TagCollectionViewCell.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-03.
//

import UIKit

protocol TagCollectionViewCellDelegate: AnyObject {
    func deleteTag(_ indexPath: IndexPath)
    func editTag(_ indexPath: IndexPath)
}

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: TagCollectionViewCellDelegate?
    
    var indexPath: IndexPath?
    var _tag: Tag?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
    
    func setupWithTag(_ tag: Tag, indexPath: IndexPath) {
        self._tag = tag
        self.indexPath = indexPath
        self.titleLabel.text = tag.name
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let indexPath = indexPath {
            self.delegate?.deleteTag(indexPath)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if let indexPath = indexPath {
            self.delegate?.editTag(indexPath)
        }
    }
}
