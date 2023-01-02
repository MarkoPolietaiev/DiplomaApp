//
//  NewPostingViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-01.
//

import UIKit

class PostingViewController: BaseViewController {

    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var secondContainer: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: BaseTextField!
    
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var tagsTextField: BaseTextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var stepsTableView: UITableView!
    
    var minutes: [Int] = Array(stride(from: 10, through: 120, by: 10)).reversed()
    
    var posting: Posting? {
        didSet {
            self.steps = posting?.steps ?? []
        }
    }
    
    var steps: [Step] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.stepsTableView.register(R.nib.stepTableViewCell)
        self.hideKeyboardWhenTappedAround()
        self.closeButton.setTitle("", for: .normal)
        self.minutesPickerView.setValue(R.color.backgroundColor(), forKeyPath: "textColor")
        self.descriptionTextView.layer.cornerRadius = 15
        self.firstContainer.layer.cornerRadius = 15
        self.secondContainer.layer.cornerRadius = 15
        self.saveButton.layer.cornerRadius = 15
        self.nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter Goal Name Here",
            attributes: [NSAttributedString.Key.foregroundColor: R.color.backgroundColor()]
        )
        self.tagsTextField.attributedPlaceholder = NSAttributedString(
            string: "Goal's Tags",
            attributes: [NSAttributedString.Key.foregroundColor: R.color.backgroundColor()]
        )
        if let posting = posting {
            self.setupEdit()
        } else {
            self.setupNew()
        }
    }
    
    private func setupEdit() {
        guard let posting = posting else {return}
        self.nameTextField.text = posting.title
        self.tagsTextField.text = posting.tags.map({$0.name}).joined(separator: ", ")
        if let index = minutes.firstIndex(of: posting.timeMinutes) {
            self.minutesPickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
    private func setupNew() {
        self.minutesPickerView.selectRow(self.minutes.count-1, inComponent: 0, animated: true)
    }
    
    private func saveNewPosting() {
        guard let name = self.nameTextField.text, !name.isEmpty else {return}
        guard let tagsString = self.tagsTextField.text, !tagsString.isEmpty else {return}
        let tags = tagsString.split(separator: ",").map({return Tag(name: String($0))})
        let timeMinutes = self.minutes[self.minutesPickerView.selectedRow(inComponent: 0)]
        guard let description = self.descriptionTextView.text, !description.isEmpty else {return}
        let posting = Posting(title: name, timeMinutes: timeMinutes, link: "", tags: tags, steps: [], description: description)
        self.networkManager.createPosting(posting: posting) { postingResponse, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let postingResponse = postingResponse {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    private func patchOldPosting() {
        guard let id = posting?.id else {return}
        guard let name = self.nameTextField.text, !name.isEmpty else {return}
        guard let tagsString = self.tagsTextField.text, !tagsString.isEmpty else {return}
        let tags = tagsString.split(separator: ",").map({return Tag(name: String($0))})
        let timeMinutes = self.minutes[self.minutesPickerView.selectedRow(inComponent: 0)]
        let description = self.descriptionTextView.text
        let posting = Posting(title: name, timeMinutes: timeMinutes, link: "", tags: tags, steps: [], description: description ?? "")
        
        self.networkManager.updatePosting(id: id, posting: posting) { response, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let posting = posting {
            self.patchOldPosting()
        } else {
            self.saveNewPosting()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension PostingViewController: StepFooterViewDelegate {
    func addNewStep() {
        return
    }
}

extension PostingViewController: StepTableViewCellDelegate {
    func showImage(_ image: UIImage) {
        if let vc = R.storyboard.main.imageDetailViewController() {
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .pageSheet
            vc.image = image
            if #available(iOS 15.0, *) {
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
            } else {
                // Fallback on earlier versions
            }
            self.present(vc, animated: true)
        }
    }
}

extension PostingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.minutes.count
    }
}

extension PostingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.minutes[row])
    }
}

extension PostingViewController: UITextViewDelegate {
    
}

extension PostingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.stepTableViewCell, for: indexPath)!
        let item = self.steps[indexPath.row]
        cell.setupWithStep(item)
        cell.delegate = self
        return cell
    }
}

extension PostingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = StepFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            handler(false)
        }
        editAction.backgroundColor = .gray
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        return configuration
    }
}
