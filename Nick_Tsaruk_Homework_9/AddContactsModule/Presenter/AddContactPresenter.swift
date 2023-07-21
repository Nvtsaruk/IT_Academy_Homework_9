//
//  AddContactsPresenter.swift
//  NickTsarukHomewrok_9_MVP
//
//  Created by Tsaruk Nick on 17.07.23.
//

import Foundation

protocol AddContactViewProtocol: AnyObject {}

protocol AddContactViewPresenterProtocol: AnyObject {
    init(view: AddContactViewProtocol, router: RouterProtocol, contacts: [Person]?)
    var contacts: [Person]? { get set }
    func addContact(firstname: String, lastname: String)
}

final class AddContactPresenter: AddContactViewPresenterProtocol {
    
    weak var view: AddContactViewProtocol?
    var router: RouterProtocol?
    var contacts: [Person]?
    
    required init(view: AddContactViewProtocol, router: RouterProtocol, contacts: [Person]?) {
        self.view = view
        self.router = router
        self.contacts = contacts
    }
    
    func addContact(firstname: String, lastname: String) {
        contacts?.append(Person(firstname: firstname, lastname: lastname))
        sortArray(array: &contacts)
        router?.initialViewController(contacts: contacts)
    }
    private func sortArray(array: inout [Person]?) {
        array?.sort { $0.firstname < $1.firstname }
    }
}
