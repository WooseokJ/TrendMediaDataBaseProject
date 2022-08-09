import UIKit

class TMDBViewController: UIViewController {
   
    let color : [UIColor] = [.yellow,.blue,.lightGray,.systemGreen]
    let numberList : [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](51...60),
        [Int](61...70),
        [Int](71...80),
        [Int](81...100)
    ]
    
    @IBOutlet weak var tmdbTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tmdbTableView.delegate = self
        tmdbTableView.dataSource = self
        view.backgroundColor = .black
    }
}
//테이블뷰
extension TMDBViewController : UITableViewDelegate, UITableViewDataSource {
    //테이블뷰 색션개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleLabel.allCases.count
    }
    // 테이블뷰 셀개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //테이블뷰 셀 값넣기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBTableViewCell.reuseIdentifier, for: indexPath) as? TMDBTableViewCell else{return UITableViewCell()}
        cell.contentCollecionView.backgroundColor = .black
        cell.contentCollecionView.delegate = self
        cell.contentCollecionView.dataSource = self
        cell.contentCollecionView.register(UINib(nibName: TMDBCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier)
        cell.contentCollecionView.tag = indexPath.section
        cell.titleLabel.text = titleLabel.allCases[indexPath.section].sectionTitle
        cell.backgroundColor = .black
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
        return numberList[collectionView.tag].count
    }

    //셀 값넣기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier, for: indexPath) as? TMDBCollectionViewCell else{return UICollectionViewCell()}
        
        cell.cardCellView.posterImageVIew.backgroundColor = indexPath.item.isMultiple(of: 2) ? .systemYellow : .green
        cell.cardCellView.posterImageVIew.layer.cornerRadius = 20
        
        
        return cell
    }
    // 컬렉션뷰 레이아웃잡기
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height:
                                    UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }

}
//
