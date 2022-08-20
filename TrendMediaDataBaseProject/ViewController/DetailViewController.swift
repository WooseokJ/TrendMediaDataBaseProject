

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI
import Accelerate

class DetailViewController: UIViewController {
    
    // 영화제목
    @IBOutlet weak var titleLabel: UILabel!
    // 앞이미지 포스터
    @IBOutlet weak var posterImageView: UIImageView!
    // 백이미지 포스터
    @IBOutlet weak var backImageView: UIImageView!
    // tv_id
    var tvId : Int?
    // 배우정보 담는 그릇
    var castDataList : [castData] = []
    // 백이미지
    var backPath : String?
    // 앞이미지
    var forePath : String?
    //  배우이름
    var titleName : String?
    // overView
    var overViewContent : String?
    // 더보기를위한 변수
    var isselect = false
    // 테이블뷰
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
//        print(#function)
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //Xib 연결
        tableView.register(UINib(nibName: DetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: OverViewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        //테이블뷰 높이
        tableView.rowHeight = 100
        guard let back = backPath , let fore = forePath else {return}

        //백그라운드 탑 이미지
        backImageView.imageViewURL(path: back)
        //포그라운드 탑 이미지
        posterImageView.testURL(path: fore)
        //영화 제목        
        titleLabel.titleLabelDesign(titlename: titleName!)
        
        detailImage()
    }
    
    func detailImage() {

        APIManager.shared.castInsert(tv_id: tvId!) { data in
            print(data)
            self.castDataList = data
            DispatchQueue.main.async { // main 쓰레드에 모아서 갱신하거나 할떄 주로쓰임 (주로 ui관련작업에서 많이쓰임)
                self.tableView.reloadData()
            }
        }
        
    }
}
extension DetailViewController : UITableViewDataSource ,UITableViewDelegate{
    // 색션개수
    func numberOfSections(in tableView: UITableView) -> Int {
//        print(#function)
        return 2
    }
    // 테이블뷰 row개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(#function)
        if section == 0 {
            return 1
        }
        else{
            
            return castDataList.count
        }
    }
    //테이블뷰 셀 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        if indexPath.section == 0 {
            let overCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as! OverViewTableViewCell
            overCell.overViewLabel.text = overViewContent
            overCell.overViewLabel.font = .systemFont(ofSize: 16)
            overCell.overViewLabel.textAlignment = .center
            overCell.overViewLabel.numberOfLines = isselect ? 0 : 1
            overCell.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            overCell.moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
            return overCell
        }
        cell.nameLabel.text = castDataList[indexPath.row].name
        cell.chractorLabel.text = castDataList[indexPath.row].character
        let imageURL = URL(string: endPoint.tmdbImageURL + castDataList[indexPath.row].profilePath)
        cell.profileImageView.contentMode = .scaleAspectFit
        cell.profileImageView.kf.setImage(with: imageURL)
        return cell
    }
    // 테이블뷰 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        print(#function)
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        else{
            return UIScreen.main.bounds.height * 0.1
        }
    }
    // overview 더보기 버튼
    @objc func moreButtonClicked() {
        isselect = !isselect
        tableView.reloadData()
    }
}


