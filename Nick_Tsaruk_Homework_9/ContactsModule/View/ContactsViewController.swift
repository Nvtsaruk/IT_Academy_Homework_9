import UIKit

final class ContactsViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var presenter: ContactsViewPresenterProtocol!
    
    private var canEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContactCell")
    }
    
    private func setupUI() {
        title = "Contacts"
        tableView.rowHeight = 60
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editContacts(_:)))
    }
    
    @objc private func addContact(_ sender: UIButton!) {
        presenter.addContact()
    }
    
    @objc private func editContacts(_ sender: UIButton) {
        if !canEdit && !(presenter.contacts?.isEmpty ?? false) {
            navigationItem.leftBarButtonItem?.title = "Done"
            tableView.isEditing = true
            canEdit = !canEdit
        } else {
            navigationItem.leftBarButtonItem?.title = "Edit"
            tableView.isEditing = false
            canEdit = !canEdit
        }
    }
}

extension ContactsViewController: ContactsViewProtocol {
    func updateTable() {
        tableView.reloadData()
    }
}

extension ContactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell()}
        cell.cellTextLabel.attributedText = presenter.cellText(section: indexPath.section, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var indexSum = 0
            var i = 0
            while  i < indexPath.section {
                indexSum += tableView.numberOfRows(inSection: i)
                i += 1
            }
            indexSum += indexPath.row
            presenter.removeContact(index: indexSum)
        }
    }
}

