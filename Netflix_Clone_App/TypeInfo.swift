//
//  TypeInfo.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/31.
//
// movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all

import Foundation

enum MediaType: Int, CaseIterable {
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    
    var queryValue: String {
        return "\(self)"
    }
    
    var title: String {
        switch self {
        case .movie:
            return "영화"
        case .podcast:
            return "팟캐스트"
        case .music:
            return "뮤직"
        case .musicVideo:
            return "뮤직비디오"
        case .audiobook:
            return "오디오북"
        }
    }
}
