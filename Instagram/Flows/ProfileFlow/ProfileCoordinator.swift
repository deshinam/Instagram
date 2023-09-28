import Swinject
import UIKit

class ProfileCoordinator {
    private var profileNavigationController: UINavigationController?
    private var resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func createNavigationController() -> UINavigationController? {
        guard let vc = resolver.resolve(ProfileViewController.self, argument: self as ProfileOutput) else {
            return nil
        }
        profileNavigationController = UINavigationController(rootViewController: vc)
        profileNavigationController!.tabBarItem.image =  UIImage(systemName: "person")!

        return profileNavigationController
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
        guard let profileNavigationController = profileNavigationController else {
            return
        }
        
        let postVC = PostViewController(nibName: "PostViewController", bundle: nil)
        profileNavigationController.pushViewController(postVC, animated: true)
    }
}
