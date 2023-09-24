import UIKit

class NavBarViewController: UITabBarController {

    let feedViewController: FeedViewController
    let profileNavigationController: UINavigationController

    init(feedViewController: FeedViewController,
         profileNavigationController: UINavigationController) {
        self.feedViewController = feedViewController
        self.profileNavigationController = profileNavigationController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }

    private func setupVCs() {
        viewControllers = [
            createNavController(for: feedViewController, image: UIImage(systemName: "house")!),
            createNavController(for: profileNavigationController, image: UIImage(systemName: "person")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        return navController
    }
}
