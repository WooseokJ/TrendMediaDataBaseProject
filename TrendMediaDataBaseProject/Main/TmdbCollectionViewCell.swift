//
//  TmdbCollectionViewCell.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/04.
//

import UIKit

class TmdbCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var overviewLabel: UILabel! //요약
    @IBOutlet weak var titleLabel: UILabel! //제목
    @IBOutlet weak var moveButton: UIButton! //이동하기버튼
    @IBOutlet weak var detailButton: UIButton! //자세히보기버튼
    @IBOutlet weak var posterImageView: UIImageView! //포스터이미지
    @IBOutlet weak var starLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var lineBackView: UIView!
}
