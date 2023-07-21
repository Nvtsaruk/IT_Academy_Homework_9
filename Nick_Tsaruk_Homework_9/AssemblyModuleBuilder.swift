import UIKit

protocol AssemblyBuilderProtocol {
    func createContactModule(router: RouterProtocol, contacts: [Person]?) -> UIViewController
    func createAddContactModule(router: RouterProtocol, contacts: [Person]?) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createContactModule(router: RouterProtocol, contacts: [Person]?) -> UIViewController {
        let view = ContactsViewController()
        let presenter = ContactsPresenter(view: view, router: router, contacts: contacts)
        view.presenter = presenter
        return view
    }
    
    func createAddContactModule(router: RouterProtocol, contacts: [Person]?) -> UIViewController {
        let view = AddContactViewController()
        let presenter = AddContactPresenter(view: view, router: router, contacts: contacts)
        view.presenter = presenter
        return view
    }
}
