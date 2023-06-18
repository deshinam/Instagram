import UIKit

final class ProfileHeaderCell: UICollectionViewCell {

    private struct Constants {
        static let avatarSize: CGFloat = 80
    }

    static let reuseIdentifier = "ProfileHeaderCell"

    var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constants.avatarSize / 2
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var userDetailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize),
        ])

        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

        addSubview(userDetailsLabel)
        NSLayoutConstraint.activate([
            userDetailsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            userDetailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            userDetailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ProfileHeaderViewModel) {
        nameLabel.text = viewModel.getUserName()
        userDetailsLabel.text = viewModel.getUserDetails()
        avatarImageView.image = viewModel.getAvatar()
    }
}
