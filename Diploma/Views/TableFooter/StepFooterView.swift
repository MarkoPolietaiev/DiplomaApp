//
//  StepFooterView.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-02.
//

import UIKit

protocol StepFooterViewDelegate: AnyObject {
    func addNewStep()
}

class StepFooterView: BaseView {

    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: StepFooterViewDelegate?
    
    override func setupXib() {
        super.setupXib()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.delegate?.addNewStep()
    }
}
