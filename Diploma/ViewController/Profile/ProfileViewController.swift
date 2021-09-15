//
//  ProfileViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-10.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statsStackView: UIStackView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupDataSource() {
        self.populateData()
    }
    
    private func setupView() {
        guard let user = user else { return }
        self.profileImageView.image = user.image
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2
        self.setupStackView()
    }
    
    private func setupStackView() {
        for (idx, view) in self.statsStackView.subviews.enumerated() {
            if let view = view as? StatsView, let user = user {
                view.setupWithItem(user.stats[idx])
            }
        }
    }
}

private extension ProfileViewController {
    
    func populateData() {
        let statsItem1 = StatsItem(number: 5, title: "Aims achieved")
        let statsItem2 = StatsItem(number: 100, title: "Posts")
        let statsItem3 = StatsItem(number: 13, title: "Deadlines missed")
        
        let user = User(username: "MarkoPolietaiev", image: R.image.user1()!, stats: [statsItem1,statsItem2,statsItem3])
        self.user = user
    }
    
}
