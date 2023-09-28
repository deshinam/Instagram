import UIKit

class FeedViewController: UIViewController {

    private var label: UILabel = {
        let label = UILabel()
        label.text = "Here I will add feed soon!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVC()
    }

    private func setupVC() {
        let cell = FeedPostsCell()
        cell.configure()
        view.addSubview(cell)

        NSLayoutConstraint.activate([
            cell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cell.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
