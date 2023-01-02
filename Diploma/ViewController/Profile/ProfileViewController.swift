//
//  ProfileViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var usernameTextField: BaseTextField!
    @IBOutlet weak var emailTextField: BaseTextField!
    @IBOutlet weak var passwordTextFIeld: BaseTextField!
    @IBOutlet weak var confirmPasswordTextFIeld: BaseTextField!
    
    var userProfile: UserProfile? {
        didSet {
            self.updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.getData()
    }
    
    private func getData() {
        self.networkManager.getMe { profile, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let profile = profile {
                self.userProfile = profile
            }
        }
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.usernameTextField.text = self.userProfile?.name
            self.emailTextField.text = self.userProfile?.email
        }
    }
    
    private func setupView() {
        self.hideKeyboardWhenTappedAround()
        self.isDefaultBackground = false
        self.cancelButton.layer.cornerRadius = 15
        self.cancelButton.layer.borderWidth = 3
        self.cancelButton.layer.borderColor = self.saveButton.backgroundColor?.cgColor
        self.saveButton.layer.cornerRadius = 15
        self.containerView.layer.cornerRadius = 15
        self.passwordTextFIeld.setupPasswordToggle()
        self.confirmPasswordTextFIeld.setupPasswordToggle()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var email: String?
        var password: String?
        var name: String?
        if let newEmail = emailTextField.text, let oldEmail = self.userProfile?.email, newEmail != oldEmail {
            email = newEmail
        }
        if let newName = usernameTextField.text, let oldName = self.userProfile?.name, newName != oldName {
            name = newName
        }
        if let newPassword = self.passwordTextFIeld.text,
           !newPassword.isEmpty,
           let confirmPassword = self.confirmPasswordTextFIeld.text,
           !confirmPassword.isEmpty,
           newPassword == confirmPassword {
            password = newPassword
        }
        self.networkManager.updateUser(email: email, password: password, name: name) { profile, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if profile != nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate, let vc = R.storyboard.auth.signInViewController() else {return}
            UserData.authToken = nil
            let navVc = UINavigationController(rootViewController: vc)
            sceneDelegate.window?.rootViewController = navVc
        }
    }
}
