//
//  FirstViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import UIKit

class FirstViewController: BaseViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        self.setupView()
    }
    
    private func setupView() {
        self.startButton.layer.cornerRadius = self.startButton.frame.height/2
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if let descriptionViewController =  R.storyboard.auth.descriptionViewController() {
            self.navigationController?.pushViewController(descriptionViewController, animated: true)
        }
    }
}
