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

    var tvData : [data] = []
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    var tvId : String?
    var castDataList : [cast] = []
    var backPath : String?
    var forePath : String?
    var titleName : String?
    var overViewContent : String?
    var isselect = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //Xib 연결
        tableView.register(UINib(nibName: DetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: OverViewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        //테이블뷰 높이
        tableView.rowHeight = 100
        //백그라운드 탑 이미지
        imageViewURL(path: backPath ?? "", imageView: backImageView)
        //포그라운드 탑 이미지
        imageViewURL(path: forePath ?? "", imageView: posterImageView)
        //영화 제목
        titleLabelDesign(title: titleLabel, titlename: titleName)
        tvdetail()
    }
    // 영화 등장인물소개
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
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension DetailViewController : UITableViewDataSource ,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 테이블뷰 색션개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return 1}
        else{
            return castDataList.count}
    }
    //테이블뷰 셀 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        if indexPath.section == 0 {
            let overCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as! OverViewTableViewCell
            print(tvData)
            overCell.overViewLabel.text = overViewContent
            overCell.overViewLabel.font = .systemFont(ofSize: 16)
            overCell.overViewLabel.textAlignment = .center
            print(isselect)
            overCell.overViewLabel.numberOfLines = isselect ? 0 : 1
            
            
            overCell.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            overCell.moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
            return overCell
        }
        
        cell.nameLabel.text = castDataList[indexPath.row].name
        cell.chractorLabel.text = castDataList[indexPath.row].character
        
        let imageURL = URL(string: endPoint.tmdbImageURL+castDataList[indexPath.row].profilePath)
        cell.profileImageView.contentMode = .scaleAspectFit
        cell.profileImageView.kf.setImage(with: imageURL)
        
        return cell
    }

    @objc func moreButtonClicked() {
        isselect = !isselect
        tableView.reloadData()
    }
    
    
}


