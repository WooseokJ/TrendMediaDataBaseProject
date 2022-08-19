//
//  ThirdViewController.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/17.
//

import UIKit
import SnapKit
class ThirdViewController: UIViewController {
    
    //    // 백그라운드 이미지
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    // 텍스트 라벨
    var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "TMDB에 대한 소개 3"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0
        
        return label
    }()
    // 시작하기 버튼
    var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
        startButton.addTarget(self, action: #selector(startButtonClciked), for: .touchUpInside)
    }
    
    @objc func startButtonClciked() {
        let next = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = next.instantiateViewController(withIdentifier: MainViewController.reuseIdentifier) as? MainViewController else {return}
        let nav = UINavigationController(rootViewController: vc)
        UserDefaults.standard.set(true, forKey: "first")
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav,animated: false)
    }
    
    func configure() {
        //등록
        [backgroundView,contentLabel,startButton].forEach {
            view.addSubview($0)
        }
        
        //백그라운드 이미지
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        // 텍스트 라벨
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(view.bounds.height / 8)
            $0.leading.equalTo(view.bounds.width / 10)
            $0.trailing.equalTo(-(view.bounds.width / 10))
        }
        //버튼 위치
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(-view.bounds.height / 8)
            $0.trailing.equalTo(-30)
            $0.leading.equalTo(30)
            $0.height.equalTo(view.bounds.height / 13)
        }
    }
    
    
    
    
}
