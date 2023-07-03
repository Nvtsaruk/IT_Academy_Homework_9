//
//  AddNewContactViewController.swift
//  Nick_Tsaruk_Homework_9
//
//  Created by Tsaruk Nick on 2.07.23.
//

import UIKit

class AddNewContactViewController: UIViewController {
    weak var delegate: ContactDelegate?
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let lastname = lastnameTextField.text else { return }
        delegate?.saveContact(name: name, lastname: lastname)
        dismiss(animated: true)
    }
    private func setupUI() {
        cancelButtonOutlet.layer.borderColor = UIColor.tintColor.cgColor
        cancelButtonOutlet.layer.borderWidth = 1
        cancelButtonOutlet.layer.cornerRadius = 10
        
        saveButtonOutlet.backgroundColor = UIColor.systemBlue
        saveButtonOutlet.setTitleColor(.white, for: .normal)
        saveButtonOutlet.layer.cornerRadius = 10
    }

}
