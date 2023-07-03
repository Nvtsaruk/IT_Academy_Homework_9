//
//  ContactsTableViewController.swift
//  Nick_Tsaruk_Homework_9
//
//  Created by Tsaruk Nick on 2.07.23.
//

import UIKit
struct Person {
    var name: String
    var lastname: String
}
class ContactsTableViewController: UITableViewController {

    @IBOutlet var contactTableView: UITableView!
    private var personArray:[Person] = [] {
        didSet {
            contactTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        self.contactTableView.register(nib, forCellReuseIdentifier: "ContactCell")
        
    }
    private func setupUI() {
        title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact(_:)))
    }
    
    @objc private func addContact(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AddNewContactStoryboard", bundle: nil)
        let newContactVC = storyboard.instantiateViewController(identifier: "AddNewContactViewController") as! AddNewContactViewController
        newContactVC.delegate = self
        present(newContactVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell()}
        
        cell.cellTextLabel.attributedText = getDecoratedString(name: personArray[indexPath.row].name, lastname: personArray[indexPath.row].lastname)
        // Configure the cell...

        return cell
    }
    
    private func getDecoratedString(name: String, lastname: String) -> NSMutableAttributedString {
        let nameFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        let lastnameFont = UIFont.systemFont(ofSize: 16, weight: .light)
        let fullString = NSMutableAttributedString(string: name + " " + lastname)
        let fullLength = NSRange(location: 0, length: fullString.length)
        let nameRange = NSRange(location: 0, length: name.count)
        fullString.addAttributes([.font: lastnameFont, .foregroundColor: UIColor.lightGray], range: fullLength)
        fullString.addAttributes([.font: nameFont, .foregroundColor: UIColor.black], range: nameRange)
        return fullString
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactsTableViewController: ContactDelegate {
    func saveContact(name: String, lastname: String) {
        let newPerson = Person(name: name, lastname: lastname)
        personArray.append(newPerson)
        print(personArray)
    }
}
