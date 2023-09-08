import UIKit
import Swinject

class AppCoordinator {
    private var navigationController: UINavigationController
    private var resolver: Resolver
    private var profileCoordinator: ProfileCoordinator?
    private var feedCoordinator: FeedCoordinator?

    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }

    func signIn() {
        guard let signInViewController = resolver.resolve(SignInViewController.self, argument: navigationController) else { return }
        navigationController.pushViewController(signInViewController, animated: false)
    }

    func start() {
        feedCoordinator = resolver.resolve(FeedCoordinator.self, argument: UINavigationController())
        profileCoordinator = resolver.resolve(ProfileCoordinator.self, argument: UINavigationController())

        guard let feedCoordinator = feedCoordinator,
              let feedVC = feedCoordinator.createViewController(),
              let profileCoordinator = profileCoordinator,
              let profileVC = profileCoordinator.createViewController(),
              let navBarController = resolver.resolve(NavBarViewController.self,
                                                      arguments: feedVC, profileVC) else { return }
        navigationController.pushViewController(navBarController, animated: false)
    }
}

