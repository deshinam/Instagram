import AlamofireImage
import Alamofire
import UIKit

struct ProfilePostViewModel: Hashable {
    
    let data: PostData

    init(with data: PostData) {
        self.data = data
    }

    func getImage() -> UIImage? {
        let imageURL = data.imageURL
        var image: UIImage? = nil
        AF.request(imageURL, method: .get).response { response in

           switch response.result {
            case .success(let responseData):
                image = UIImage(data: responseData!, scale: 1)

            case .failure(_):
               image = nil
            }
        }
        return image
    }
}
