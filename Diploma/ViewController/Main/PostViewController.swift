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
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 60.0
        let y = self.titleView.frame.origin.y + self.titleView.frame.height
        self.scrollView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height-y-tabBarHeight-self.pageControl.frame.height-10)
        if self.scrollView.subviews.count == 3 {
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
        self.scrollView.contentSize = CGSize(width: self.view.frame.width*CGFloat(self.pageControl.numberOfPages), height: self.scrollView.frame.height)
        self.scrollView.isPagingEnabled = true
        for i in 0..<post.steps.count {
            let page = StepView(frame: CGRect(x: CGFloat(i)*self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrollView.frame.height))
            page.setupWithStep(post.steps[i])
            scrollView.addSubview(page)
        }
    }

}

extension PostViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(floorf(Float(self.scrollView.contentOffset.x) / Float(self.scrollView.frame.size.width)))
    }
}
