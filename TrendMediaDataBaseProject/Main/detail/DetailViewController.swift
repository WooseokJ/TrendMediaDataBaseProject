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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    var tvId : String?
    var castDataList : [cast] = []
    var backPath : String?
    var forePath : String?
    var titleName : String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.rowHeight = 100
        let backImageURL = URL(string: endPoint.tmdbImageURL+(backPath ?? ""))
        backImageView.kf.setImage(with: backImageURL)
        
        let foreImageURL = URL(string: endPoint.tmdbImageURL+(forePath ?? ""))
        posterImageView.kf.setImage(with: foreImageURL)
        guard let name = titleName else{
            titleLabel.text = "제목없음"
            return
        }
        titleLabel.text = name
        titleLabel.textColor = .white
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        tvdetail()
    }
    func tvdetail(){
        let url = "\(endPoint.castURL)\(String(describing: tvId!))/credits?api_key=\(APIKey.TMDBKey)"
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


