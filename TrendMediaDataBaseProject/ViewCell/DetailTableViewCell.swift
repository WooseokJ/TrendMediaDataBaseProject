//
//  DetailTableViewCell.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/05.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    // 배우캐릭터명
    @IBOutlet weak var chractorLabel: UILabel!
    // 배우이름
    @IBOutlet weak var nameLabel: UILabel!
    // 배우 포스터이미지
    @IBOutlet weak var profileImageView: UIImageView!
}

extension UIImageView {
    // 이미지 띄우기
    func imageViewURL(path: String){
        print(endPoint.tmdbImageURL+(path))
        let imageURL = URL(string: endPoint.tmdbImageURL+(path))
        self.kf.setImage(with: imageURL)
    }
    func testURL(path: String){
        let imageURL = URL(string: endPoint.tmdbImageURL+(path))
        self.kf.setImage(with: imageURL)
    }
}





extension UILabel {
    // 이름 라벨 디자인
    func titleLabelDesign(titlename:String) {
        self.text = titlename
        print(titlename)
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 15)
    }





}

