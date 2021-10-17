//
//  PostViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-09-10.
//

import UIKit

class PostViewController: BaseViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var skillTitleLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame = CGRect(x: 0, y: self.titleView.frame.height+10, width: self.view.frame.width, height: self.view.frame.height-self.titleView.frame.height-self.pageControl.frame.height-20.0)
        if self.scrollView.subviews.count == 2 {
            self.setupScrollView()
        }
    }
    
    private func setupPageControl() {
        guard let post = post else { return }
        self.pageControl.numberOfPages = post.steps.count
        self.pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current)*self.view.frame.size.width, y: 0), animated: true)
    }
    
    private func setupScrollView() {
        guard let post = self.post else { return }
        self.scrollView.contentSize = CGSize(width: self.view.frame.width*CGFloat(self.pageControl.numberOfPages), height: self.view.frame.height-self.titleView.frame.height-self.pageControl.frame.height)
        for i in 0..<post.steps.count {
            let page = StepView(frame: CGRect(x: CGFloat(i)*self.view.frame.width, y: self.scrollView.frame.origin.y, width: self.view.frame.width, height: self.scrollView.frame.height))
            page.setupWithStep(post.steps[i])
        }
    }

}
