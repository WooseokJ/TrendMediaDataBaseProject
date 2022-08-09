//
//  DetailTableViewCell.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/05.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var chractorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
}

func imageViewURL(path: String, imageView: UIImageView){
    let imageURL = URL(string: endPoint.tmdbImageURL+(path))
    imageView.kf.setImage(with: imageURL)
}
func titleLabelDesign(title: UILabel,titlename:String?) {
    guard let name = titlename else{
        title.text = "제목없음"
        return
    }
    title.text = name
    title.textColor = .white
    
    title.font = .boldSystemFont(ofSize: 30)
}




