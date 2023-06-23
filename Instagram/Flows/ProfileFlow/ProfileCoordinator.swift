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
        guard let vc = resolver.resolve(ProfileViewController.self, argument: self as ProfileOutput) else {
            return nil
        }
        return vc
    }
}

final class ProfileAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProfileViewController.self) { (r, output: ProfileOutput) in
            let viewModel = ProfileViewModel(networkManager: r.resolve(NetworkManagerProtocol.self)!,
                                             actions: output)
            let vc = ProfileViewController(profileViewModel: viewModel)

            return vc
        }
    }
}

protocol ProfileOutput {
    func openPost()
}

extension ProfileCoordinator: ProfileOutput {
    func openPost() {
        let postVC = UIViewController()

        navigationController.pushViewController(postVC, animated: true)
        print("Open post")
    }
}
