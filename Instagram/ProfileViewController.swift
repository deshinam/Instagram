
import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

class ProfileViewController: UIViewController {
    private var datasource: DataSource!
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        configureDatasource()
    }

    private func setupCollectionView() {
        collectionView = .init(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: ProfileHeaderCell.reuseIdentifier)
        collectionView.register(ProfilePostsCell.self, forCellWithReuseIdentifier: ProfilePostsCell.reuseIdentifier)

        view.addSubview(collectionView)
    }

    private func createHeaderSection() -> NSCollectionLayoutSection {
        let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), subitems: [headerItem])

        return NSCollectionLayoutSection(group: headerGroup)
    }

    private func createPostsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.sectionFor(index: index, environment: env)
        }
    }

    private func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]

        switch section {
        case .header:
            return createHeaderSection()
        case .posts:
            return createPostsSection()
        }
    }

    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        switch item {
        case .header(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCell.reuseIdentifier, for: indexPath) as! ProfileHeaderCell
            cell.configure(with: data)
            return cell
        case .post(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostsCell.reuseIdentifier, for: indexPath) as! ProfilePostsCell
            cell.configure(with: data)
            return cell
        }
    }

    private func configureDatasource() {
        datasource = DataSource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        datasource.apply(snapshot(), animatingDifferences: false)
    }

    private func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        let demoProfileData = ProfileHeaderData(userName: "Deshina Masha",userDetails: "London", avatar: UIImage(named: "avatar")!, postCount: 5)
        let demoProfilePhotos = [
            Item.post(PostData(image: UIImage(named: "photo1")!)),
            Item.post(PostData(image: UIImage(named: "photo2")!)),
            Item.post(PostData(image: UIImage(named: "photo1")!)),
            Item.post(PostData(image: UIImage(named: "photo2")!)),
            Item.post(PostData(image: UIImage(named: "photo1")!)),
            Item.post(PostData(image: UIImage(named: "photo2")!)),
        ]

        snapshot.appendSections([.header])
        snapshot.appendItems([.header(demoProfileData)], toSection: .header)
        snapshot.appendSections([.posts])
        snapshot.appendItems(demoProfilePhotos, toSection: .posts)

        return snapshot
    }
}

enum Section: Hashable {
    case header
    case posts
}

enum Item: Hashable {
    case header(ProfileHeaderData)
    case post(PostData)
}

struct ProfileHeaderData: Hashable {
    let userName: String
    let userDetails: String
    let avatar: UIImage
    let postCount: Int
}

struct PostData: Hashable {
    let id = UUID()
    let image: UIImage
}
