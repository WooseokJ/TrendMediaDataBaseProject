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
