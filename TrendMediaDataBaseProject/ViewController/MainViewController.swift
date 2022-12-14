

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class MainViewController: UIViewController{
    // 컬렉션뷰
    @IBOutlet weak var collectionView: UICollectionView!
    // 데이터
    var tvDataList : [data] = []
    // 전체 데이터 개수
    var totalCount : Int = 0
    // 페이지 시작 개수
    var pageStartNum : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listClicked))
        navigationItem.navBarDesign()
        fetchImageList(startpage: pageStartNum)
        layoutSetting(collectionview: collectionView)
        collectionView.backgroundColor = .black

    }
    
    // 다른영화추천목록 보기
    @IBAction func moveButtonClicked(_ sender: UIButton) {
        let next = UIStoryboard(name: "Main", bundle: nil)
        let vc = next.instantiateViewController(withIdentifier: TMDBViewController.reuseIdentifier) as! TMDBViewController
//        vc.id = dataList[sender.tag].id
        print("sender.tag:",tvDataList[sender.tag].id)
        APIManager.shared.callRequest(tv_id: tvDataList[sender.tag].id) { data in
            print(data)
            let tvIDList = data.map {
                $0.tvID
            }
            let tvNameList = data.map{
                $0.tvName
            }
            print("tvIDLIST: ",tvIDList)
            vc.tvList = tvIDList
            vc.tvNameList = tvNameList
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
      
        
        
    }
    
    // 유투브 링크버튼 클릭
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        let next = UIStoryboard(name: "Main", bundle: nil)
        let vc = next.instantiateViewController(withIdentifier: YoutubeWebViewController.reuseIdentifier) as! YoutubeWebViewController
        let nav = UINavigationController(rootViewController: vc)
        let tvid = tvDataList[sender.tag].id
        APIManager.shared.youtube(tv_id: tvid) { youtubedata in
            DispatchQueue.main.async { //메인쓰레드로 바꿈
                self.collectionView.reloadData()
                vc.youtubeTVID = youtubedata[0].youLink
                self.present(nav,animated: true)
            }
        }
        
    }
    
   
    
}
extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    // 색션개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvDataList.count
    }
    // 셀삽입
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        cell.backgroundColor = .black
        // 자세히 보기
        cell.detailButton.buttonDesign(title: "자세히 보기",imageName: "")
        // 이동하기
        cell.moveButton.buttonDesign(title: "",imageName: "chevron.forward")
        // 밑줄라인
        cell.lineBackView.backgroundColor = .black // 라인 칼러
        // 개봉일
        cell.releaseDateLabel.dateDesign(dateString: tvDataList[indexPath.item].release_date)
        // 설명
        cell.overviewLabel.LabelDesign(title: tvDataList[indexPath.item].overView,color: .white, backgroundColor: .black)
        // 제목
        cell.titleLabel.text = tvDataList[indexPath.item].titleName
        cell.titleLabel.textColor = .white
        // 이미지
        let imageurl = URL(string: endPoint.tmdbImageURL+tvDataList[indexPath.item].posterImage)
        cell.posterImageView.kf.setImage(with:imageurl)
        cell.posterImageView.contentMode = .scaleToFill
        // 장르
        let genreName = tvDataList[indexPath.item].genreId
        cell.genreLabel.genreDesign(title: genreData.genreList[genreName] ?? "No genre")
        // 백그라운드
        cell.backView.viewDesign()
        // 평점
        cell.starLabel.LabelDesign(title: "평점", color: .white,backgroundColor: UIColor(red: 172/255, green: 146/255, blue: 237/255, alpha: 1))
        // 점수
        cell.scoreLabel.LabelDesign(title: String(tvDataList[indexPath.item].score), color: .black, backgroundColor: .white)
        // 링크버튼
        cell.linkButton.linkButtonDesing(title: "", imageName: "paperclip")
        cell.linkButton.tag = indexPath.item
        cell.moveButton.tag = indexPath.item
        cell.backgroundColor = .black
        
        return cell
    }
    
    // item 선택할떄
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // push의경우 13.0이상부터 가능
        // detail 페이지로 이동
        @available (iOS 13.0 , *)
        func nextViewController() {
            guard let detailVc = self.storyboard?.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as? DetailViewController else { return }
            
            // tv id 저장
            detailVc.tvId = tvDataList[indexPath.row].id
            // 백그라운드 포스터 경로
            detailVc.backPath = tvDataList[indexPath.row].backDropPath
            // 앞면 포스터 경로
            detailVc.forePath = tvDataList[indexPath.row].posterImage
            // tv 프로그램 제목
            detailVc.titleName = tvDataList[indexPath.row].titleName
            // tv 프로그램 요약
            detailVc.overViewContent = tvDataList[indexPath.row].overView
            
            
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
        nextViewController()
    }
    // 무한스크롤
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if (totalCount > tvDataList.count) && (tvDataList.count - 1 == index.item) {
                pageStartNum += 30
                fetchImageList(startpage: pageStartNum)
            }
        }
    }
    // 저장된거 datList와 전체 데이터개수 저장하기
    func fetchImageList(startpage: Int) {
        APIManager.shared.fetchImageData(startpage: pageStartNum) { totalCount, dataList in
            self.totalCount = totalCount
            self.tvDataList.append(contentsOf: dataList)
            DispatchQueue.main.async { // main 쓰레드에 모아서 갱신하거나 할떄 주로쓰임 (주로 ui관련작업에서 많이쓰임)
                self.collectionView.reloadData()
            }
        }
    }
}





        
    




