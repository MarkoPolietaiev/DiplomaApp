//
//  SignInViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: BaseButton!
    @IBOutlet weak var signUpButton: BaseButton!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.logInButton.setupBorder()
        self.logInButton.layer.cornerRadius = self.logInButton.frame.height/2
        self.containerView.layer.cornerRadius = 15
    }
    
    private func pushToMainVc() {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let vc = R.storyboard.main.mainViewController() else {return}
            let navVc = UINavigationController(rootViewController: vc)
            sceneDelegate.window?.rootViewController = navVc
            UserData.firstLaunch = false
        }
    }

    @IBAction func logInButtonPressed(_ sender: Any) {
        guard let email = usernameTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty
        else {
            self.showErrorAlert(message: "Input error. Email and password should not be empty.")
            return
        }
        self.showActivityIndicator()
        self.authManager.signIn(email: email, password: password) { error in
            self.hideActivityIndicator()
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.pushToMainVc()
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if let signUpViewController = R.storyboard.auth.signUpViewController() {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
}
