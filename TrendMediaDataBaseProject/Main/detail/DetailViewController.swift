//
//  DetailViewController.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class DetailViewController: UIViewController {
    static var identifier = "DetailViewController"
    
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    var tvId : String?
    var castDataList : [cast] = []
    var backPath : String?
    var forePath : String?
    var titleName : String?
    var overViewContent : String?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.rowHeight = 100
        //백그라운드 탑 이미지
        imageViewURL(path: backPath ?? "", imageView: backImageView)
        //포그라운드 탑 이미지
        imageViewURL(path: forePath ?? "", imageView: posterImageView)
        //영화 제목
        titleLabelDesign(title: titleLabel, titlename: titleName)
        overViewTextView.text = overViewContent
        tvdetail()
    }
    func tvdetail(){
        
        let url = "\(endPoint.tvURL)\(String(describing: tvId!))/credits?api_key=\(APIKey.TMDBKey)&display=40"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["cast"].arrayValue{
                    let data = cast(name: item["name"].stringValue, character: item["character"].stringValue, profilePath: item["profile_path"].stringValue)
                    castDataList.append(data)
                }
                tableView.reloadData()
                print(castDataList)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        cell.nameLabel.text = castDataList[indexPath.row].name
        cell.chractorLabel.text = castDataList[indexPath.row].character
        
        let imageURL = URL(string: endPoint.tmdbImageURL+castDataList[indexPath.row].profilePath)
        cell.profileImageView.contentMode = .scaleAspectFit
        cell.profileImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    
}
