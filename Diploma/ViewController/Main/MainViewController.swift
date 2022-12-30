//
//  MainViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        if let vc = R.storyboard.profile.profileViewController() {
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
