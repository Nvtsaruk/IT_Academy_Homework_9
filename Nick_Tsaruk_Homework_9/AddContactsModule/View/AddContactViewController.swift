import UIKit

final class AddContactViewController: UIViewController {
    //MARK: - IBOutlet
    
    @IBOutlet private weak var saveButtonOutlet: UIButton!
    @IBOutlet private weak var cancelButtonOutlet: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var lastnameTextField: UITextField!
    
    //MARK: - Variables
    
    var presenter: AddContactViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        cancelButtonOutlet.layer.borderColor = UIColor.systemBlue.cgColor
        cancelButtonOutlet.layer.borderWidth = 1
        cancelButtonOutlet.layer.cornerRadius = 10
        
        saveButtonOutlet.backgroundColor = UIColor.systemBlue
        saveButtonOutlet.setTitleColor(.white, for: .normal)
        saveButtonOutlet.layer.cornerRadius = 10
    }
    
    //MARK: - IBAction
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        guard let firstname = nameTextField.text else { return }
        guard let lastname = lastnameTextField.text else { return }
        presenter?.addContact(firstname: firstname, lastname: lastname)
        dismiss(animated: true)
    }
}

extension AddContactViewController: AddContactViewProtocol {}
