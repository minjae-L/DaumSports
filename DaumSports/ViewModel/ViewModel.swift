//
//  ViewModel.swift
//  DaumSports
//
//  Created by 이민재 on 2024/04/02.
//

import Foundation

protocol ViewControllerProtocol: AnyObject {
    func didUpdatedData()
}
final class ViewModel {
    weak var delegate: ViewControllerProtocol?
    var news: [NewsContents] = [] {
        didSet {
            delegate?.didUpdatedData()
        }
    }
    
    
    // MARK: - URLSession
    private func getUrl() -> URLComponents {
        let scheme = "https"
        let host = "sports.daum.net"
        let path = "/media-api/harmony/contents.json"
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "0"),
            URLQueryItem(name: "consumerType", value: "HARMONY"),
            URLQueryItem(name: "status", value: "SERVICE"),
            URLQueryItem(name: "createDt", value: "20231026000000~20231026235959"),
            URLQueryItem(name: "discoveryTag%5B0%5D", value: "%257B%2522group%2522%253A%2522media%2522%252C%2522key%2522%253A%2522defaultCategoryId3%2522%252C%2522value%2522%253A%2522100032%2522%257D"),
            URLQueryItem(name: "size", value: "20")
        ]
        return components
    }
    
    private let session = URLSession(configuration: .default)
    
    typealias NetworkResult = (Result<Data, NetworkError>) -> ()
    
    func dataFetch(completion: @escaping NetworkResult) {
        // URL 에러 확인
        guard let url = getUrl().url else {
            completion(.failure(.invalidUrl))
            return
        }
        print(url)
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in 
            // 통신 에러 확인
            guard error == nil else {
                completion(.failure(.transportError))
                return
            }
            // 서버 에러 확인
            let successRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            if !successRange.contains(statusCode) {
                completion(.failure(.serverError(code: statusCode)))
                return
            }
            // 데이터 불러오기 에러 확인
            guard let loadedData = data else {
                completion(.failure(.missingData))
                return
            }
            // 디코딩 에러 확인
            do {
                let parsingData: DaumModel = try
                JSONDecoder().decode(DaumModel.self, from: loadedData)
                self.news = parsingData.newsModel.newsContents
                completion(.success(loadedData))
            } catch let error {
                print(request)
                completion(.failure(.decodingError(error: error)))
            }
            
        }.resume()
    }
}
