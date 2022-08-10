
import Foundation

import Alamofire
import SwiftyJSON
class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    private init() {}
    var tvList : [recommendTVData] = []
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(query: Int, completionHandler: @escaping([recommendTVData]) -> () ) { //json파일 인풋
        let url  = "https://api.themoviedb.org/3/tv/\(query)/recommendations?api_key=\(APIKey.TMDBKey)&language=en-US&page=1"
        AF.request(url, method: .get).validate().responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // tv 포스터 정보 리스트
                print(json)
                for item in json["results"].arrayValue {
                    let data = recommendTVData(tvID: item["id"].intValue, tvName: item["poster_path"].stringValue,poster_path: item["poster_path"].stringValue)
                    tvList.append(data)
                }
                completionHandler(tvList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(tv_id: Int ,completionHandler: @escaping ([[recommendTVData]]) -> ()) {
        var posterList : [[recommendTVData]] = []
        
        
        TMDBAPIManager.shared.callRequest(query: tv_id) { _ in
            
            
            TMDBAPIManager.shared.callRequest(query: self.tvList[0].tvID) { value in
                posterList.append(value)
                
                TMDBAPIManager.shared.callRequest(query: self.tvList[1].tvID) { value in
                    posterList.append(value)
                    
                    TMDBAPIManager.shared.callRequest(query: self.tvList[2].tvID) { value in
                        posterList.append(value)
                        
                        TMDBAPIManager.shared.callRequest(query: self.tvList[3].tvID) { value in
                            posterList.append(value)
                            
                            TMDBAPIManager.shared.callRequest(query: self.tvList[4].tvID) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[5].tvID) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[6].tvID) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



