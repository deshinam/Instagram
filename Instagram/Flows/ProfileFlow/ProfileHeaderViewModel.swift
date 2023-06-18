import UIKit

struct ProfileHeaderViewModel: Hashable {
    
    let data: ProfileHeaderData

    init(with data: ProfileHeaderData) {
        self.data = data
    }

    func getUserName() -> String {
        return data.userName
    }

    func getUserDetails() -> String {
        return data.userDetails
    }

    func getAvatar() -> UIImage {
        return UIImage(named: "photo1")!
    }
}
