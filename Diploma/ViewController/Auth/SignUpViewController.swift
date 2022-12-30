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
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.createAccountButton.setupBorder()
        self.createAccountButton.layer.cornerRadius = self.createAccountButton.frame.height/2
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

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text,
              !username.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              let email = emailTextField.text,
              !email.isEmpty,
              let confirmEmail = confirmEmailTextField.text,
              !confirmEmail.isEmpty,
              let repeatPassword = repeatPasswordTextField.text,
              !repeatPassword.isEmpty
        else {
            self.showErrorAlert(message: "Input error. All fields should not be empty.")
            return
        }
        guard password == repeatPassword else {
            self.showErrorAlert(message: "Input error. Passwords do not match.")
            return
        }
        guard email == confirmEmail else {
            self.showErrorAlert(message: "Input error. Emails do not match.")
            return
        }
        // create an account
        self.showActivityIndicator()
        self.authManager.signUp(email: email, password: password, name: username) { response, error in
            if let error = error {
                self.hideActivityIndicator()
                self.showErrorAlert(message: error.localizedDescription)
            } else if response != nil {
                // sign in with the new account
                self.authManager.signIn(email: email, password: password) { error in
                    self.hideActivityIndicator()
                    if let error = error {
                        self.showErrorAlert(message: error.localizedDescription)
                    } else {
                        self.pushToMainVc()
                    }
                }
            }
        }
    }
}
