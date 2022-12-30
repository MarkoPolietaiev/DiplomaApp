//
//  StepView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-10-16.
//

import Foundation
import UIKit

class StepView: BaseView, UIScrollViewDelegate {
    
    var step: Step?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaView: UIView!
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var mediaScrollView: UIScrollView!
    @IBOutlet weak var mediaPageControl: UIPageControl!
    
    override func setupXib() {
        super.setupXib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mediaScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.mediaView.frame.height)
        if self.mediaScrollView.subviews.count == 1 {
            self.setupScrollView()
        }
    }
    
    func setupWithStep(_ step: Step) {
        self.step = step
        self.setupMediaView()
        self.titleLabel.text = step.title
        self.descriptionLabel.text = step.description
    }
    
    func setupMediaView() {
        guard let step = step else {
            return
        }
        self.mediaPageControl.numberOfPages = step.images.count
        self.mediaPageControl.addTarget(self, action:#selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    func setupScrollView() {
        guard let step = step else {
            return
        }
        self.mediaScrollView.contentSize = CGSize(width: self.view.frame.width*CGFloat(self.mediaPageControl.numberOfPages), height: self.mediaScrollView.frame.height)
        self.mediaScrollView.isPagingEnabled = translatesAutoresizingMaskIntoConstraints
        for i in 0..<step.images.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i)*self.view.frame.width, y: 0, width: self.view.frame.width, height: self.mediaView.frame.height))
            imageView.contentMode = .scaleAspectFit
            imageView.image = step.images[i]
            mediaScrollView.addSubview(imageView)
        }
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        self.mediaScrollView.setContentOffset(CGPoint(x: CGFloat(current)*self.view.frame.size.width, y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.mediaPageControl.currentPage = Int(floorf(Float(self.mediaScrollView.contentOffset.x) / Float(self.mediaScrollView.frame.size.width)))
    }
}
