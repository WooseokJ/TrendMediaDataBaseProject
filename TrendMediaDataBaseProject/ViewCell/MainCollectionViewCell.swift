//
//  TmdbCollectionViewCell.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/04.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var overviewLabel: UILabel! //요약
    @IBOutlet weak var titleLabel: UILabel! //제목
    @IBOutlet weak var moveButton: UIButton! //이동하기버튼
    @IBOutlet weak var detailButton: UIButton! //자세히보기버튼
    @IBOutlet weak var posterImageView: UIImageView! //포스터이미지
    @IBOutlet weak var starLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var lineBackView: UIView!
  
}

func layoutSetting(collectionview: UICollectionView) {
    let layout = UICollectionViewFlowLayout()
    let spacing : CGFloat = 15
    let layoutwidth = UIScreen.main.bounds.width - (spacing * 2)
    layout.itemSize = CGSize(width: layoutwidth , height: (layoutwidth / 2) * 2.5)
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    collectionview.collectionViewLayout = layout
}



extension UIButton {
    func buttonDesign(title: String, imageName: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        self.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    
    func linkButtonDesing(title:String,imageName: String) {
        self.setTitle(title, for: .normal)
        self.setImage(UIImage(systemName: imageName), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .black
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.clipsToBounds = true
    }
}

extension UILabel {
    func LabelDesign(title: String, color: UIColor, backgroundColor:UIColor) {
        self.text = title
        self.numberOfLines = 1
        self.textColor = color
        self.textAlignment = .center
        self.backgroundColor = backgroundColor
        
    }
    func dateDesign(dateString: String) {
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let date = format.date(from: dateString)
        format.dateFormat = "MM/dd/yyyy"
        guard date != nil else {return}
        self.text = format.string(from: date ?? Date())
        self.textColor = .white
    }
    func genreDesign(title: String) {
        self.text = ("#"+title)
        self.font = .preferredFont(forTextStyle: .title2, compatibleWith: .none)
        self.textColor = .white
    }
}

extension UIView {
    func viewDesign() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}



