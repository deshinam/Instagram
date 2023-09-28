import UIKit

class NavBarViewController: UITabBarController {
    let feedNavigationController: UINavigationController
    let profileNavigationController: UINavigationController
    
    init(feedNavigationController: UINavigationController, 
         profileNavigationController: UINavigationController) {
        self.feedNavigationController = feedNavigationController
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
            feedNavigationController,
            profileNavigationController
        ]
    }
}
