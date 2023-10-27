//
//  Model.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//
import Foundation

// MARK: - Model
struct NewsModel: Codable {
    let result: Result
}

struct Result: Codable {
    let contents: [Contents]
}

struct Contents: Codable {
    let title: String
    let thumbnailUrl: String
    let cp: Cp
}

struct Cp: Codable {
    let cpName: String
}

class News {
    static var data = [Contents]()
}
