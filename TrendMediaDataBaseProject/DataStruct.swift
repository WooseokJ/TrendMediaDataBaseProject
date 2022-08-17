//
//  DataStruct.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/05.
//

import Foundation

// tv data
struct data {
    var titleName : String
    var overView : String
    var posterImage : String
    var release_date : String
    var genreId : Int
    var score : String
    var id : Int
    var backDropPath : String
    
    init(titleName: String, overView : String, posterImage : String, release_date: String, genreId: Int, score: String, id: Int, backDropPath : String) {
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
// tv 배우 데이터
struct castData {
    var name : String
    var character : String
    var profilePath : String
    init(name: String, character: String, profilePath: String) {
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
}
// youtube 링크 데이터
struct youtubeData {
    var youLink : String
    init(youLink: String){
        self.youLink = youLink
    }
}


// 추천 tv data
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
// 영화관 극장 정보 데이터 
struct TheaterData {
    var mapAnnotations: [Theater] = [
        Theater(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}

