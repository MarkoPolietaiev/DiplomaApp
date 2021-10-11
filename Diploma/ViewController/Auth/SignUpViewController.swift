//
//  SignUpViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var createAccountButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.createAccountButton.setupBorder()
        self.createAccountButton.layer.cornerRadius = self.createAccountButton.frame.height/2
        self.containerView.layer.cornerRadius = 15
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        //if registration successfull
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let vc = R.storyboard.main.tabBarViewController() else {return}
        sceneDelegate.window?.rootViewController = vc
        UserData.firstLaunch = false
    }
}
