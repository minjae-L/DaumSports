//
//  ViewController.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    
    func settingUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        
    }
    func fetchData() {
        let address = "https://sports.daum.net/media-api/harmony/contents.json?page=0&consumerType=HARMONY&status=SERVICE&createDt=20231026000000~20231026235959&discoveryTag%5B0%5D=%257B%2522group%2522%253A%2522media%2522%252C%2522key%2522%253A%2522defaultCategoryId3%2522%252C%2522value%2522%253A%2522100032%2522%257D&size=20"
        
        let task = URLSession.shared.dataTask(with: URL(string: address)!) { data, response, error in
            
            if let data = data {
                do {
                    let res: NewsModel = try
                    JSONDecoder().decode(NewsModel.self, from: data)
                    News.data = res.result.contents
                    
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchData()
        settingUI()
        print(News.data)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return News.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = News.data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                       for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

