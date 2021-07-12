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

    @IBAction func logInButtonPressed(_ sender: Any) {
        // log in
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if let signUpViewController = R.storyboard.auth.signUpViewController() {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
    }
}
