import AlamofireImage
import UIKit

final class ProfilePostsCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProfilePostsCell"
    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: ProfilePostViewModel) {
        imageView.af.setImage(withURL: URL(string: "https://image.shutterstock.com/image-photo/redirected-1000w-1105302317.jpg")!)

//        imageView.image = viewModel.getImage()
    }
}
