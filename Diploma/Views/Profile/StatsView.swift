//
//  StatsView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-09-15.
//

import UIKit

class StatsView: BaseView {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setupXib() {
        super.setupXib()
    }
    
    func setupWithItem(_ statsItem: StatsItem) {
        self.numberLabel.text = String(statsItem.number)
        self.titleLabel.text = statsItem.title
    }

}
