//
//  SignInViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: BaseTextField!
    @IBOutlet weak var passwordTextField: BaseTextField!
    
    @IBOutlet weak var logInButton: BaseButton!
    @IBOutlet weak var signUpButton: BaseButton!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.logInButton.setupBorder()
        self.logInButton.layer.cornerRadius = self.logInButton.frame.height/2
        self.containerView.layer.cornerRadius = 15
        self.registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
        self.passwordTextField.setupPasswordToggle()
    }
    
    deinit {
        self.deregisterFromKeyboardNotifications()
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
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
   }


   private func deregisterFromKeyboardNotifications() {
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
   }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func signIn() {
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

    @IBAction func logInButtonPressed(_ sender: Any) {
        self.signIn()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if let signUpViewController = R.storyboard.auth.signUpViewController() {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            self.signIn()
        }
        return true
    }
}
