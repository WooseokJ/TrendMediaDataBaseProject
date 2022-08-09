

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    var dataList : [data] = []
    var totalCount : Int = 0
    var pagestart : Int = 1
    var row : Int?
    var youtubeLink : String?
    var tv_id : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        navigationItem.navBarDesign()
        fetchImage(startpage: pagestart)
        layoutSetting(collectionview: collectionView)
    }
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        let next = UIStoryboard(name: "Main", bundle: nil)
        let vc = next.instantiateViewController(withIdentifier: YoutubeWebViewController.reuseIdentifier) as! YoutubeWebViewController
        let nav = UINavigationController(rootViewController: vc)
        vc.link = youtubeLink
        self.present(nav,animated: true)
    }
    
    func fetchImage(startpage: Int) {
        APIManager.shared.fetchImageData(startpage: pagestart) { totalCount, dataList in
            self.totalCount = totalCount
            self.dataList.append(contentsOf: dataList)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func youtube(){
        let url = endPoint.tvURL+"\(tv_id!)"+"/videos?api_key=\(APIKey.TMDBKey)"
        DispatchQueue.global().async { // 동시 여러작업 가능하게 해줘!
       AF.request(url, method: .get).validate().responseData(queue: .global()) { [self] reponse in
           switch reponse.result {
           case .success(let value):
               let json = JSON(value)
               youtubeLink = json["results"][0]["key"].stringValue
           case .failure(let error):
               print(error)
                }
            }
        }
    }
}
extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmdbCollectionViewCell.reuseIdentifier, for: indexPath) as! TmdbCollectionViewCell
        //자세히 보기
        cell.detailButton.buttonDesign(title: "자세히 보기",imageName: "")
        //이동하기
        cell.moveButton.buttonDesign(title: "",imageName: "chevron.forward")
        //밑줄라인
        cell.lineBackView.backgroundColor = .black // 라인 칼러
        // 개봉일
        cell.releaseDateLabel.dateDesign(dateString: dataList[indexPath.item].release_date)
        // 설명
        cell.overviewLabel.LabelDesign(title: dataList[indexPath.item].overView,color: .systemGray2,backgroundColor: .white)
        // 제목
        cell.titleLabel.text = dataList[indexPath.item].titleName
        // 이미지
        let imageurl = URL(string: endPoint.tmdbImageURL+dataList[indexPath.item].posterImage)
        cell.posterImageView.kf.setImage(with:imageurl)
        cell.posterImageView.contentMode = .scaleToFill
        // 장르
        let genreName = dataList[indexPath.item].genreId
        cell.genreLabel.genreDesign(title: genreData.genreList[genreName] ?? "No genre")
        // 백그라운드
        cell.backView.viewDesign()
        // 평점
        cell.starLabel.LabelDesign(title: "평점", color: .white,backgroundColor: UIColor(red: 172/255, green: 146/255, blue: 237/255, alpha: 1))
        // 점수
        cell.scoreLabel.LabelDesign(title: String(dataList[indexPath.item].score), color: .black, backgroundColor: .white)
        //링크버튼
        cell.linkButton.linkButtonDesing(title: "", imageName: "paperclip")
        tv_id = dataList[indexPath.row].id

        youtube()
        return cell
    }
}


extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        @available (iOS 13.0 , *) // push의경우 13.0이상부터 가능
        func nextViewController() {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as? DetailViewController else {return}
            nextVC.tvId = dataList[indexPath.row].id
            nextVC.backPath = dataList[indexPath.row].backDropPath
            nextVC.forePath = dataList[indexPath.row].posterImage
            nextVC.titleName = dataList[indexPath.row].titleName
            nextVC.overViewContent = dataList[indexPath.row].overView

            self.navigationController?.pushViewController(nextVC, animated: true) //push타입
        }
        nextViewController()
    }
}

extension ViewController : UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            pagestart += 1
            fetchImage(startpage: pagestart)
        }
    }
}
        
    


