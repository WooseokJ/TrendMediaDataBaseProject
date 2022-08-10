//
//  cardView.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/09.
//

import Foundation
import UIKit

class cardView : UIView {
    // 포스터 이미지
    @IBOutlet weak var posterImageVIew: UIImageView!
    required init?(coder: NSCoder) {
        super.init(coder:coder) //부모(UIVIEW) 가 초기화
        let view = UINib(nibName: "cardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
//        view.backgroundColor = .black // 컬렉션뷰에서 하나의 셀에대한 백그라운드 칼러
        self.addSubview(view)
        
    }
}
