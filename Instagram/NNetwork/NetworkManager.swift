import Foundation

protocol NetworkManagerProtocol {
    func getUserData() -> ProfileHeaderData
    func getPosts() -> [PostData]
}

class NetworkManager: NetworkManagerProtocol {
    
    func getUserData() -> ProfileHeaderData {
        return ProfileHeaderData(userName: "Deshina Masha",userDetails: "London", avatarURL: URL(filePath: "https://hips.hearstapps.com/hmg-prod/images/champagne-beach-espiritu-santo-island-vanuatu-royalty-free-image-1655672510.jpg?crop=1.00xw:0.755xh;0,0.173xh&resize=1200:*"), postCount: 5)
    }

    func getPosts() -> [PostData] {
        let url = URL(string: "https://image.shutterstock.com/image-photo/redirected-1000w-1105302317.jpg")
        let postData = [
            PostData(imageURL: url!),
            PostData(imageURL: url!)
        ]
        return postData
    }
}
