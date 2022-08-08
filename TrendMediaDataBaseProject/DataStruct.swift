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
