import UIKit

// https://iosapptemplates.com/blog/ios-development/sign-in-with-apple-swift

class SignInViewController: UIViewController {
    private var signInTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the Instagram!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignIn", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVC()
    }

    private func setupVC() {
        view.addSubview(signInTitle)

        NSLayoutConstraint.activate([
            signInTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        view.addSubview(signInButton)

        NSLayoutConstraint.activate([
            signInTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: signInTitle.bottomAnchor, constant: 10)
        ])
    }

}
