import Swinject
import UIKit

class FeedCoordinator {
    private var navigationController: UINavigationController
    private var resolver: Resolver

    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }

    func createViewController() -> FeedViewController? {
        guard let vc = resolver.resolve(FeedViewController.self) else {
            return nil
        }

        return vc
    }
}


final class FeedAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FeedViewController.self) { r in
            let vc = FeedViewController()
            return vc
        }
    }
}



