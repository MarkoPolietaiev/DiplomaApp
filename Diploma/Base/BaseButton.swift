//
//  BaseButton.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit

class BaseButton: UIButton {
    
    func setupBorder(color: UIColor = .black, width: CGFloat = 2) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
