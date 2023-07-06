import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let assembler = registerDependencies()
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        appCoordinator = assembler.resolver.resolve(AppCoordinator.self, argument: navigationController)
        appCoordinator?.start()
    }
}

private extension SceneDelegate {
    private func registerDependencies() -> Assembler {
        let serviceAssembler = Assembler([ServicesAssembly()])
        let modulesAssembler = Assembler([ProfileAssembly(), FeedAssembly()], parent: serviceAssembler)
        let appAssembler = Assembler([AppAssembly()], parent: modulesAssembler)

        return appAssembler
    }
}

final class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { (r, navigationController: UINavigationController) in
            return AppCoordinator(navigationController: navigationController, resolver: r)
        }

        container.register(ProfileCoordinator.self) { (r, navigationController: UINavigationController) in
            return ProfileCoordinator(resolver: r)
        }

        container.register(FeedCoordinator.self) { (r, navigationController: UINavigationController) in
            return FeedCoordinator(navigationController: navigationController, resolver: r)
        }

        container.register(SignInViewController.self) { (r, navigationController: UINavigationController) in
            return SignInViewController()
        }

        container.register(NavBarViewController.self) { r, feedVC, profileVc in
            let vc = NavBarViewController(feedViewController: feedVC,
                                          profileViewController: profileVc)
            return vc
        }
    }
}

final class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkManagerProtocol.self) { _ in NetworkManager() }
    }
}
