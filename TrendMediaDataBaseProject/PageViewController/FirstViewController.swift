//
//  FirstViewController.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/17.
//

import UIKit
import SnapKit
class FirstViewController: UIViewController {

    // 백그라운드 이미지
        var backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
        // 텍스트 라벨
        var contentLabel: UILabel = {
            let label = UILabel()
            label.text = "TMDB에 대한 소개 1"
            label.textColor = .white
            label.font = .systemFont(ofSize: 30)
            label.numberOfLines = 0
            
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            configure()
            
        }
        
        func configure() {
            //등록
            [backgroundView,contentLabel].forEach {
                view.addSubview($0)
            }
            
    //        //백그라운드 이미지
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
    //        // 텍스트 라벨
            contentLabel.snp.makeConstraints {
                $0.top.equalTo(view.bounds.height / 8)
                $0.leading.equalTo(view.bounds.width / 10)
                $0.trailing.equalTo(-(view.bounds.width / 10))
                
            }
        }
    

}
