import Swinject
import UIKit

class ProfileCoordinator {
    private var profileViewController: UIViewController?
    private var resolver: Resolver

    init(resolver: Resolver) {
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
        guard let profileVC = profileViewController else {
            return
        }
        
        let postVC = UIViewController()

        profileVC.present(postVC, animated: true)
    }
}
