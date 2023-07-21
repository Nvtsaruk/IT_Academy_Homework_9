import Foundation

protocol ContactsViewProtocol: AnyObject {
    func updateTable()
}

protocol ContactsViewPresenterProtocol: AnyObject {
    init(view: ContactsViewProtocol, router: RouterProtocol, contacts: [Person]?)
    var contacts: [Person]? { get set }
    var contactsDictionary:[Int:[Person]?] { get }
    func addContact()
    func removeContact(index: Int)
    func numberOfRowsInSection(section: Int) -> Int
    func numberOfSections() -> Int
    func titleForHeaderInSection(section: Int) -> String
    func cellText(section: Int, row: Int) -> NSAttributedString
}

final class ContactsPresenter: ContactsViewPresenterProtocol {

    
    weak var view: ContactsViewProtocol?
    var router: RouterProtocol?
    var contacts: [Person]? {
        didSet {
            contactsDictionary = [:]
            fillContactsDictionary(array: &contacts)
        }
    }
    
    var contactsDictionary:[Int:[Person]?] = [:]
    
    required init(view: ContactsViewProtocol, router: RouterProtocol, contacts: [Person]?) {
        self.view = view
        self.router = router
        self.contacts = contacts
        fillContactsDictionary(array: &self.contacts)
    }
    
    private func fillContactsDictionary( array: inout [Person]?) {
        var uniqueLetters: Set<Character> = []
        array?.forEach { person in
            guard let firstLetter = person.firstname.first else { return }
            uniqueLetters.insert(firstLetter)
        }
        var sortedSet = Array(uniqueLetters)
        sortedSet.sort { $0 < $1 }
        for (index, item) in sortedSet.enumerated() {
            var oneLetterArray: [Person] = []
            array?.forEach{ person in
                if person.firstname.first == item {
                    oneLetterArray.append(person)
                }
            }
            contactsDictionary[index] = oneLetterArray
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return contactsDictionary[section]??.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return contactsDictionary.count
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        guard let firstLetter = contactsDictionary[section]??[0].firstname.first else { return ""}
        return String(firstLetter)
    }
    
    func cellText(section: Int, row: Int) -> NSAttributedString {
        guard let name = contactsDictionary[section]??[row].firstname else { return NSAttributedString(string: "")}
        guard let lastname = contactsDictionary[section]??[row].lastname else { return NSAttributedString(string: "")}
        return TextDecoration.getDecoratedString(name: name, lastname: lastname)
    }
    
    func addContact() {
        self.view?.updateTable()
        router?.showAddContacts(contacts: contacts)
    }
    
    func removeContact(index: Int) {
        contacts?.remove(at: index)
        fillContactsDictionary(array: &self.contacts)
        self.view?.updateTable()
    }
    
}

