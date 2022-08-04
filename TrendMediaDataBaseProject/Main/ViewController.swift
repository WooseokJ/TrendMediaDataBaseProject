

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

struct data {
    var titleName : String
    var overView : String
    var posterImage : String
    var release_date : String
    var genreId : Int
    var score : Int
    
    init(titleName: String, overView : String, posterImage : String, release_date: String, genreId: Int, score: Int) {
        self.titleName = titleName
        self.overView = overView
        self.posterImage = posterImage
        self.release_date = release_date
        self.genreId = genreId
        self.score = score
   
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    var dataList : [data] = []
    var genreList : [Int : String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.navBarDesign()
        tmdbAPI()
        layoutSetting()

    }
    // https://api.themoviedb.org/3/tv/197067/credits?api_key=f489dc25fbe453f2a6afaf7b182defd5
    // https://api.themoviedb.org/3/genre/movie/list?api_key=f489dc25fbe453f2a6afaf7b182defd5
    func tmdbAPI(){
        let url = "\(endPoint.tmdbURL)api_key=\(APIKey.TMDBKey)"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["results"].arrayValue {
                    let newdata = data(titleName: item["original_name"].stringValue, overView: item["overview"].stringValue, posterImage: item["poster_path"].stringValue, release_date: item["first_air_date"].stringValue, genreId: item["genre_ids"][0].intValue, score: item["popularity"].intValue)
                    dataList.append(newdata)
                }
            case .failure(let error):
                print(error)
            }
            collectionView.reloadData()
        }
        
        let genreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(APIKey.TMDBKey)"
        AF.request(genreURL, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for new in json["genres"].arrayValue{
                    genreList[new["id"].rawValue as! Int] = new["name"].rawValue as? String
                }
                
            case .failure(let error):
                print(error)
            }
            
            collectionView.reloadData()
        }
    }
    
    func layoutSetting() {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 15
        let layoutwidth = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: layoutwidth , height: (layoutwidth / 2) * 2.5)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
  
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TmdbCollectionViewCell", for: indexPath) as! TmdbCollectionViewCell
        // 자세히보기버튼
        cell.detailButton.setTitle("자세히 보기", for: .normal)
        cell.detailButton.tintColor = .black
        
        // 이동하기버튼
        cell.moveButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        cell.moveButton.setTitle("", for: .normal)
        cell.moveButton.tintColor = .black
        cell.lineBackView.backgroundColor = .black
        
        
        cell.titleLabel.text = dataList[indexPath.item].titleName
        
        cell.overviewLabel.text = dataList[indexPath.item].overView
        cell.overviewLabel.numberOfLines = 1
        cell.overviewLabel.textColor = .systemGray2
        // https://image.tmdb.org/t/p/w500/
        let imageurl = URL(string: "https://image.tmdb.org/t/p/w500/"+dataList[indexPath.item].posterImage)
        cell.posterImageView.kf.setImage(with:imageurl)
        cell.posterImageView.contentMode = .scaleToFill
        
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let date = format.date(from:dataList[indexPath.item].release_date)
        format.dateFormat = "MM/dd/yyyy"
        cell.releaseDateLabel.text = format.string(from: date!)
        cell.releaseDateLabel.textColor = .systemGray2
        cell.genreLabel.text = ("#"+(genreList[dataList[indexPath.item].genreId] ?? "no genre"))
        cell.genreLabel.font = .preferredFont(forTextStyle: .title2, compatibleWith: .none)
        cell.backView.layer.borderColor = UIColor.gray.cgColor
        cell.backView.layer.shadowColor = UIColor.gray.cgColor
        cell.backView.layer.borderWidth = 1
        cell.posterImageView.layer.borderWidth = 2
        cell.starLabel.text = "평점" //172 146 237
        cell.starLabel.backgroundColor = UIColor(red: 172/255, green: 146/255, blue: 237/255, alpha: 1)
        cell.scoreLabel.text = String(dataList[indexPath.item].score)
        cell.scoreLabel.backgroundColor = .white
        cell.starLabel.textAlignment = .center
        cell.scoreLabel.textAlignment = .center
        return cell
    }

    
}

