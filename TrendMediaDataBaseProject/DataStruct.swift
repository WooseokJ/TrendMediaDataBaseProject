//
//  DataStruct.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/05.
//

import Foundation

struct data {
    var titleName : String
    var overView : String
    var posterImage : String
    var release_date : String
    var genreId : Int
    var score : String
    var id : String
    var backDropPath : String
    
    init(titleName: String, overView : String, posterImage : String, release_date: String, genreId: Int, score: String, id: String, backDropPath : String) {
        self.titleName = titleName
        self.overView = overView
        self.posterImage = posterImage
        self.release_date = release_date
        self.genreId = genreId
        self.score = score
        self.id = id
        self.backDropPath = backDropPath
    }
}

struct cast {
    var name : String
    var character : String
    var profilePath : String
    init(name: String, character: String, profilePath: String){
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
}
 
struct youtube {
    var youLink : String
    init(youLink: String){
        self.youLink = youLink
    }
}


// TMDB 에서 색션명
enum titleLabel : CaseIterable {
    case zero,one,two,third
    var sectionTitle : String {
        switch self{
            case.zero : return "아는 와이프와 비슷한 컨텐츠"
        case.one : return "미스터 선샤인과 비슷한 컨텐츠"
            case.two : return "액션 SF"
            case.third : return "미국 TV 프로그램"
        }
    }
}

struct recommendTVData{
    var tvID : Int
    var tvName : String
    var poster_path : String
    init(tvID: Int, tvName: String, poster_path: String) {
        self.tvID = tvID
        self.tvName = tvName
        self.poster_path = poster_path
    }
}

// 영화관 지도 위치 정보
struct Theater {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}

struct TheaterList {
    var mapAnnotations: [Theater] = [
        Theater(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}


/*
 Location Authorization Custom Alert
 */
//
//func showRequestLocationServiceAlert() {
//  let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
//  let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
//
//  }
//  let cancel = UIAlertAction(title: "취소", style: .default)
//  requestLocationServiceAlert.addAction(cancel)
//  requestLocationServiceAlert.addAction(goSetting)
//
//  present(requestLocationServiceAlert, animated: true, completion: nil)
//}
