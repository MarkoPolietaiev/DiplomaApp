//
//  BaseViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit
import ChameleonFramework

class BaseViewController: UIViewController {
    
    let authManager = AuthManager.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.applyGradient()
    }
    
    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let colors = [UIColor.init(hex: "#03045E") ?? .white, UIColor.init(hex: "#02031C") ?? .white]
        self.view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: colors)
    }
    
    private func setupNavigationBarView() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func goToPostDetail(_ post: Post) {
        if let postViewController = R.storyboard.main.postViewController() {
            postViewController.post = post
            self.navigationController?.pushViewController(postViewController, animated: true)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
