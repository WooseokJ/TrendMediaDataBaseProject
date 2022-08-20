import Foundation
import UIKit

import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    typealias completionHandler = (Int,[data]) -> Void
//    var datalist : [recommendTVData] = []
    // tv 데이터 저장하기
    func fetchImageData(startpage: Int, completionHandler : @escaping completionHandler) {
        let url = endPoint.tmdbURL + "api_key=\(APIKey.TMDBKey)&page=\(startpage)"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData(queue: .global()) { [self] response in // .global()하면 쓰레드에 활동을 분업화 시키기위함. 즉, 네트워크 통신이 빨라지낟.
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var tempList : [data] = []
                for item in json["results"].arrayValue {
                    let newdata = data(
                        titleName: item["original_name"].stringValue,
                        overView: item["overview"].stringValue,
                        posterImage: item["poster_path"].stringValue,
                        release_date: item["first_air_date"].stringValue,
                        genreId: item["genre_ids"][0].intValue,
                        score: String(format: "%.1f", item["vote_average"].doubleValue),
                        id: item["id"].intValue,
                        backDropPath: item["backdrop_path"].stringValue)
                    tempList.append(newdata)
                }
                let totalCount = json["total_pages"].intValue
                completionHandler(totalCount,tempList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // detail 부문에서 id,poster이미지 불러오기
    func callRequest(tv_id: Int, completionHandler: @escaping([recommendTVData]) -> () ) { //json파일 인풋
        let url  = endPoint.tvURL + "\(tv_id)/recommendations?api_key=\(APIKey.TMDBKey)"
        print(url)
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var tempList : [recommendTVData] = []
                // tv 포스터 정보 리스트
                for item in json["results"].arrayValue {
                    let data = recommendTVData(
                        tvID:item["id"].intValue,
                        tvName:item["name"].stringValue,
                        poster_path:item["poster_path"].stringValue)
                    tempList.append(data)
                }
//                self.datalist = tempList
                completionHandler(tempList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // 추천 데이터 넣기
    func recommendInsert(tvIDList: [Int] , completionHandler: @escaping ([[recommendTVData]]) -> ()) {
        var recommendTVDataList : [[recommendTVData]] = []
//        print("tvid는 이거야 : ",tv_id)
        guard tvIDList.count >= 4 else {
            return
        }
        APIManager.shared.callRequest(tv_id: tvIDList[0]) { value in
            recommendTVDataList.append(value)
            APIManager.shared.callRequest(tv_id: tvIDList[1]) { value in
                recommendTVDataList.append(value)
                APIManager.shared.callRequest(tv_id: tvIDList[2]) { value in
                    recommendTVDataList.append(value)
                    APIManager.shared.callRequest(tv_id: tvIDList[3]) { value in
                        recommendTVDataList.append(value)
                        completionHandler(recommendTVDataList)
                    }
                }
            }
        }
        
       
    }
    
    // youtube 링크
    func youtube(tv_id : Int , completionHandler: @escaping ([youtubeData]) -> () ){
        let url = endPoint.tvURL+"\(tv_id)/videos?api_key=\(APIKey.TMDBKey)"
        DispatchQueue.global().async { // 동시 여러작업 가능하게 해줘!
            AF.request(url, method: .get).validate().responseData(queue: .global()) { reponse in
                switch reponse.result {
                case .success(let value):
                    var youtubeList : [youtubeData] = []
                    let json = JSON(value)
                    UserDefaults.standard.set(json["results"][0]["key"].stringValue, forKey: "youtubeKey")
                    let tempData = youtubeData(youLink : json["results"][0]["key"].stringValue)
                    youtubeList.append(tempData)
                    completionHandler(youtubeList)
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
    }
    
    // tvdetail 데이터 받아오기
    
    func castInsert(tv_id: Int , completionHandler: @escaping ([castData]) -> () ){
        let url = "\(endPoint.tvURL)\(tv_id)/credits?api_key=\(APIKey.TMDBKey)"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var castList : [castData] = []
                for item in json["cast"].arrayValue{
                    let data = castData(
                        name: item["name"].stringValue,
                        character: item["character"].stringValue,
                        profilePath: item["profile_path"].stringValue)
                    castList.append(data)
                }
                completionHandler(castList)
            case .failure(let error):
                print(error)
            }
        }
    }
}

