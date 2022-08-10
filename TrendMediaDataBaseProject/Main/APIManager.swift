import Foundation
import UIKit

import Alamofire
import SwiftyJSON

class APIManager {
    var dataList : [data] = []
    static let shared = APIManager()
    typealias completionHandler = (Int,[data]) -> Void
    
    func fetchImageData(startpage: Int, completionHandler : @escaping completionHandler) {
        let url = "\(endPoint.tmdbURL)api_key=\(APIKey.TMDBKey)&page=\(startpage)"
        print(url)
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["results"].arrayValue {
                    let newdata = data(
                        titleName: item["original_name"].stringValue,
                        overView: item["overview"].stringValue,
                        posterImage: item["poster_path"].stringValue,
                        release_date: item["first_air_date"].stringValue,
                        genreId: item["genre_ids"][0].intValue,
                        score: String(format: "%.1f", item["vote_average"].doubleValue),
                        id: item["id"].stringValue,
                        backDropPath: item["backdrop_path"].stringValue)
                    dataList.append(newdata)
                }
                let totalCount = json["total_pages"].intValue
                completionHandler(totalCount,dataList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
//    typealias completion =
//
//    func tvdetail(){
//
//        let url = "\(endPoint.tvURL)\(String(describing: tvId!))/credits?api_key=\(APIKey.TMDBKey)&display=40"
//        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//                for item in json["cast"].arrayValue{
//                    let data = cast(name: item["name"].stringValue, character: item["character"].stringValue, profilePath: item["profile_path"].stringValue)
//                    castDataList.append(data)
//                }
//                tableView.reloadData()
//                print(castDataList)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}


     
