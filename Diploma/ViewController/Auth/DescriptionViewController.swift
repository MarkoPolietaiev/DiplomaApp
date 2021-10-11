//
//  DescriptionViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit

class DescriptionViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [DescriptionView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.setupSlideScrollView(slides)
    }
    
    private func createSlides() -> [DescriptionView] {
        let slide1 = DescriptionView()
        let item1 = DescriptionItem(title: R.string.localizable.slide1Text(), image: R.image.welcomeImage() ?? UIImage())
        slide1.setupWithItem(item1)
        
        let slide2 = DescriptionView()
        let item2 = DescriptionItem(title: R.string.localizable.slide2Text(), image: R.image.welcomeImage() ?? UIImage())
        slide2.setupWithItem(item2)
        
        let slide3 = DescriptionView()
        let item3 = DescriptionItem(title: R.string.localizable.slide3Text(), image: R.image.welcomeImage() ?? UIImage())
        slide3.setupWithItem(item3)
        
        let slide4 = DescriptionView()
        let item4 = DescriptionItem(title: R.string.localizable.slide4Text(), image: R.image.welcomeImage() ?? UIImage())
        slide4.setupWithItem(item4)
        
        let slide5 = DescriptionView()
        let item5 = DescriptionItem(title: R.string.localizable.slide5Text(), image: R.image.welcomeImage() ?? UIImage())
        slide5.setupWithItem(item5, isLast: true)
        slide5.action = {
            self.goToSignUp()
        }
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    private func setupSlideScrollView(_ slides: [DescriptionView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    private func goToSignUp() {
        if let signUpViewController = R.storyboard.auth.signInViewController() {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
}

extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
    
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)

        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)

        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
}
