//
//  ViewController.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//

import UIKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = ViewModel()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        print(viewModel.getUrl())
        viewModel.dataFetch() { result in
            switch result {
            case .success(let data):
                print("success")
            case .failure(.invalidUrl):
                print("invalidUrl")
            case .failure(.transportError):
                print("transportError")
            case .failure(.serverError(code: let code)):
                print("server Error code: \(code)")
            case .failure(.missingData):
                print("missingData")
            case .failure(.decodingError(error: let error)):
                print("decodingError: \(error)")
            }
        }
        settingUI()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let news = News.data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                       for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
//        cell.configure(with: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

