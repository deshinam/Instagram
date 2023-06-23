import Foundation

class ProfileViewModel {
    
    var userDetailsViewModel: ProfileHeaderViewModel?
    var postsViewModels: [ProfilePostViewModel] = []

    let networkManager: NetworkManagerProtocol

    let actions: ProfileOutput

    init(networkManager: NetworkManagerProtocol, actions: ProfileOutput) {
        self.networkManager = networkManager
        self.actions = actions
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
