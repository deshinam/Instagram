import AlamofireImage
import UIKit

final class FeedPostsCell: UICollectionViewCell {

    private struct Constants {
        static let avatarSize: CGFloat = 80
    }

    static let reuseIdentifier = "FeedPostsCell"

    var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constants.avatarSize / 2
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var userDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        //userDetailsStackView.addSubview(avatarImageView)
        userNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        userNameLabel.setContentHuggingPriority(.required, for: .vertical)
        userDetailsStackView.addSubview(userNameLabel)

        userDetailsStackView.setContentHuggingPriority(.required, for: .vertical)
        userDetailsStackView.setContentCompressionResistancePriority(.required, for: .vertical)

        addSubview(userDetailsStackView)

        NSLayoutConstraint.activate([
            userDetailsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userDetailsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userDetailsStackView.topAnchor.constraint(equalTo: self.topAnchor),
        ])


        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: userDetailsStackView.bottomAnchor, constant: 5)
        ])

        addSubview(postDescriptionLabel)

        NSLayoutConstraint.activate([
            postDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postDescriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        userNameLabel.text = "Masha"
        postDescriptionLabel.text = "description"
        imageView.af.setImage(withURL: URL(string: "https://image.shutterstock.com/image-photo/redirected-1000w-1105302317.jpg")!)
    }
}
