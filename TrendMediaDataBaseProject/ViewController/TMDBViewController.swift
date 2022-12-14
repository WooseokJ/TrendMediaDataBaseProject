import UIKit

import Kingfisher
class TMDBViewController: UIViewController {
    
//    var id : Int?
    let color : [UIColor] = [.yellow,.blue,.lightGray,.systemGreen]
    var recommendList : [[recommendTVData]] = []
    var initList : [recommendTVData]?
    var tvList: [Int]?
    var tvNameList: [String]?
    @IBOutlet weak var tmdbTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tmdbTableView.delegate = self
        tmdbTableView.dataSource = self
        APIManager.shared.recommendInsert(tvIDList: tvList!) { data in
            self.recommendList = data
            DispatchQueue.main.async {
                self.tmdbTableView.reloadData()
            }
        }
    }
}
//테이블뷰
extension TMDBViewController : UITableViewDelegate, UITableViewDataSource {
    //테이블뷰 색션개수
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return recommendList.count
    }
    // 테이블뷰 셀개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //테이블뷰 셀 값넣기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBTableViewCell.reuseIdentifier, for: indexPath) as? TMDBTableViewCell else{return UITableViewCell()}
        //        cell.contentCollecionView.backgroundColor = .black
        cell.contentCollecionView.delegate = self
        cell.contentCollecionView.dataSource = self
        cell.contentCollecionView.register(UINib(nibName: TMDBCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier)
        cell.contentCollecionView.tag = indexPath.section
        cell.contentCollecionView.reloadData() // index out of range 해결
        
        cell.titleLabel.text = tvNameList?[indexPath.section]
        //        cell.backgroundColor = .black
        return cell
    }
    //테이블뷰 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

// 컬렉션뷰
extension TMDBViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    //색션개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList[collectionView.tag].count
    }
    
    //셀 값넣기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier, for: indexPath) as? TMDBCollectionViewCell else{return UICollectionViewCell()}
        cell.cardCellView.posterImageVIew.backgroundColor = indexPath.item.isMultiple(of: 2) ? .systemYellow : .green
        cell.cardCellView.posterImageVIew.layer.cornerRadius = 20
        
        let url = URL(string: endPoint.tmdbImageURL + recommendList[collectionView.tag][indexPath.item].poster_path)
        cell.cardCellView.posterImageVIew.kf.setImage(with: url)
        
        return cell
    }
    // 컬렉션뷰 레이아웃잡기
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}
//
