import Foundation

class ProfileViewModel {
    
    var userDetailsViewModel: ProfileHeaderViewModel?
    var postsViewModels: [ProfilePostViewModel] = []

    let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func loadData() {
        getUserData()
        getPosts()
    }

    private func getUserData() {
        userDetailsViewModel = ProfileHeaderViewModel(with: networkManager.getUserData())
    }

    private func getPosts() {
        postsViewModels = networkManager.getPosts().map { ProfilePostViewModel(with: $0) }
    }
}


// https://developers.facebook.com/docs/instagram-api/
