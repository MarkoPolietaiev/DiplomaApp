//
//  StepViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-02.
//

import UIKit

protocol StepViewControllerDelegate: AnyObject {
    func addStep(_ step: Step)
}

extension StepViewControllerDelegate {
    func addStep(_ step: Step) {return}
}

class StepViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stepImageView: UIImageView!
    @IBOutlet weak var nameTextField: BaseTextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
    weak var delegate: StepViewControllerDelegate?
    
    var step: Step?
    var newImage: UIImage?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.hideKeyboardWhenTappedAround()
        self.isDefaultBackground = false
        self.cancelButton.layer.cornerRadius = 15
        self.cancelButton.layer.borderWidth = 3
        self.cancelButton.layer.borderColor = self.saveButton.backgroundColor?.cgColor
        self.saveButton.layer.cornerRadius = 15
        self.containerView.layer.cornerRadius = 15
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.setupOldStep()
    }
    
    private func setupOldStep() {
        guard let step = step else {return}
        if let localImage = step.localImage {
            self.stepImageView.image = localImage
        } else {
            self.stepImageView.sd_setImage(with: URL(string: step.image ?? ""), placeholderImage: UIImage(systemName: "square.grid.3x1.folder.badge.plus"))
        }
        self.nameTextField.text = step.name
    }
    
    private func openCamera() {
        self.alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            self.imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            self.present(alertController, animated: true)
        }
    }
    
    private func openGallery() {
        self.alert.dismiss(animated: true, completion: nil)
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func saveNewStep() {
        guard let name = self.nameTextField.text, !name.isEmpty else {return}
        let step = Step(name: name, localImage: self.stepImageView.image)
        self.delegate?.addStep(step)
        self.dismiss(animated: true)
    }
    
    private func editOldStep() {
        guard let step = step, let id = step.id, let name = nameTextField.text, !name.isEmpty else {return}
        let newStep = Step(name: name)
        if let newImage = newImage {
            self.networkManager.uploadStepImage(id: id, image: newImage) { step, error in
                if let error = error {
                    self.showErrorAlert(message: error.localizedDescription)
                }
                self.networkManager.updateStep(id: id, step: newStep) { step, error in
                    if let error = error {
                        self.showErrorAlert(message: error.localizedDescription)
                    } else {
                        NotificationCenter.default.post(name: .updateStepsList, object: nil)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        } else {
            self.networkManager.updateStep(id: id, step: newStep) { step, error in
                if let error = error {
                    self.showErrorAlert(message: error.localizedDescription)
                } else {
                    NotificationCenter.default.post(name: .updateStepsList, object: nil)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let step = step {
            self.editOldStep()
        } else {
            self.saveNewStep()
        }
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        self.present(self.alert, animated: true)
    }
}

extension StepViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in

        })
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.newImage = image
        self.stepImageView.image = image
    }
}
