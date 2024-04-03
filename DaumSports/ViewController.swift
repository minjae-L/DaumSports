//
//  ViewController.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    }
}
