//
//  Model.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//
import Foundation

// MARK: - Model
struct DaumModel: Codable {
    let newsModel: NewsModel
    
    enum CodingKeys: String, CodingKey {
        case newsModel = "result"
    }
}

struct NewsModel: Codable {
    let newsContents: [NewsContents]
    
    enum CodingKeys: String, CodingKey {
        case newsContents = "contents"
    }
}

struct NewsContents: Codable {
    let titleName: String?
    let newsImage: String?
    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case titleName = "title"
        case newsImage = "thumbnailUrl"
        case company = "cp"
    }
}

struct Company: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "cpName"
    }
}

//MARK: - Network
enum NetworkError: Error {
    case invalidUrl
    case transportError
    case serverError(code: Int)
    case missingData
    case decodingError(error: Error)
}

