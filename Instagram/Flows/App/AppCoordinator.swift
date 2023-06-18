import UIKit
import Swinject

class AppCoordinator {
    private var navigationController: UINavigationController
    private var resolver: Resolver

    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }

    func start() {
        guard let feedCoordinator = resolver.resolve(FeedCoordinator.self, argument: navigationController),
              let feedVC = feedCoordinator.createViewController(),
              let profileCoordinator = resolver.resolve(ProfileCoordinator.self, argument: navigationController),
              let profileVC = profileCoordinator.createViewController(),
              let navBarController = resolver.resolve(NavBarViewController.self,
                                                      arguments: feedVC, profileVC) else { return }
        navigationController.pushViewController(navBarController, animated: false)
    }
}

