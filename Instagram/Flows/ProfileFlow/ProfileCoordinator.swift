import Swinject
import UIKit

class ProfileCoordinator {
    private var navigationController: UINavigationController
    private var resolver: Resolver

    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }

    func createViewController() -> ProfileViewController? {
        guard let vc = resolver.resolve(ProfileViewController.self) else {
            return nil
        }
        return vc
    }
}

final class ProfileAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProfileViewController.self) { r in
            let vc = ProfileViewController()
            return vc
        }
    }
}
