import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

private enum Section: Hashable {
    case header
    case posts
}

private enum Item: Hashable {
    case header(ProfileHeaderViewModel)
    case post(ProfilePostViewModel)
}

class ProfileViewController: UIViewController {
    private var datasource: DataSource!
    private var collectionView: UICollectionView!
    private var profileViewModel: ProfileViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupCollectionView()
        profileViewModel.loadData()
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
        case .header(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCell.reuseIdentifier, for: indexPath) as! ProfileHeaderCell
            cell.configure(with: viewModel)
            return cell
        case .post(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostsCell.reuseIdentifier, for: indexPath) as! ProfilePostsCell
            cell.configure(with: viewModel)
            return cell
        }
    }

    private func configureDatasource() {
        datasource = DataSource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        datasource.apply(snapshot(), animatingDifferences: false)
    }

    private func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        let demoProfileData = ProfileHeaderData(userName: "Deshina Masha",
                                                userDetails: "London",
                                                avatarURL: URL(filePath: "https://hips.hearstapps.com/hmg-prod/images/champagne-beach-espiritu-santo-island-vanuatu-royalty-free-image-1655672510.jpg"),
                                                postCount: 5)
        let profileHeaderViewModel = ProfileHeaderViewModel(with: demoProfileData)

        if let userDetails = profileViewModel.userDetailsViewModel {
            snapshot.appendSections([.header])
            snapshot.appendItems([.header(userDetails)], toSection: .header)
        }

        snapshot.appendSections([.posts])
        let posts = profileViewModel.postsViewModels.map { Item.post($0) }
        snapshot.appendItems(posts, toSection: .posts)

        return snapshot
    }
}
