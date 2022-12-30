//
//  ProfileViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var userProfile: UserProfile? {
        didSet {
            self.updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
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
