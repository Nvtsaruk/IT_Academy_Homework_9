import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController(contacts: [Person]?)
    func showAddContacts(contacts: [Person]?)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController(contacts: [Person]?) {
        if let navigationController = navigationController {
            guard let contactsViewController = assemblyBuilder?.createContactModule(router: self, contacts: contacts) else { return }
            navigationController.viewControllers = []
            navigationController.viewControllers = [contactsViewController]
        }
    }
    
    func showAddContacts(contacts: [Person]?) {
        if let navigationController = navigationController {
            guard let addContactViewController = assemblyBuilder?.createAddContactModule(router: self, contacts: contacts) else { return }
            navigationController.viewControllers.first?.present(addContactViewController, animated: true)
        }
    }
}
