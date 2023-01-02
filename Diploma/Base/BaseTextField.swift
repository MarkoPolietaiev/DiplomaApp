//
//  BaseTextField.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit

class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    let overlayButton = UIButton(type: .custom)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.borderStyle = .none
        
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0) // Use any CGSize
        self.layer.shadowColor = UIColor.gray.cgColor
        
        let color = UIColor.lightGray
        let placeholder = self.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if leftView != nil {
            return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 8))
        }
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if leftView != nil {
            return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 8))
        }
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if leftView != nil {
            return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 8))
        }
        return bounds.inset(by: padding)
    }

    func setupPasswordToggle() {
        let bookmarkImage = UIImage(systemName: "eye")?.withTintColor(R.color.backgroundColor() ?? .black)
        overlayButton.setImage(bookmarkImage, for: .normal)
        overlayButton.addTarget(self, action: #selector(setupSecureEntry),
            for: .touchUpInside)
        overlayButton.sizeToFit()
        
        overlayButton.translatesAutoresizingMaskIntoConstraints = true

        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(overlayButton)

        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: overlayButton.frame.size.width + 10,
                height: overlayButton.frame.size.height + 10
            )
        )

        overlayButton.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )

        rightView = outerView
        self.rightViewMode = .always
    }
    
    @objc private func setupSecureEntry() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        if self.isSecureTextEntry {
            self.overlayButton.setImage(UIImage(systemName: "eye")?.withTintColor(R.color.backgroundColor() ?? .black), for: .normal)
        } else {
            self.overlayButton.setImage(UIImage(systemName: "eye.slash")?.withTintColor(R.color.backgroundColor() ?? .black), for: .normal)
        }
    }
    
    func setIconWith(_ image: UIImage) {
        let iconView = UIImageView(frame:
                       CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                       CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
}
