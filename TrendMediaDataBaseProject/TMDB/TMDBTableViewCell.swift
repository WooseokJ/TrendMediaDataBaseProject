//
//  TMDBTableViewCell.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/09.
//

import UIKit

class TMDBTableViewCell: UITableViewCell {

    @IBOutlet weak var contentCollecionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewSetUI()
        contentCollecionView.collectionViewLayout = collectionViewLayout()
        
    }
    // 테이블뷰 UI 구성(라벨 폰트크기,색상,백그라운드색상)
    func tableViewSetUI(){
        titleLabel.font = .boldSystemFont(ofSize: 24)
//        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        
    }
    // 컬렉션뷰 
    func collectionViewLayout()-> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 162)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }

}
