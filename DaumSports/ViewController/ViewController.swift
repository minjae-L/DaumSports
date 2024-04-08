//
//  ViewController.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    lazy private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        return view
    }()
    
    private func viewModelDataFetch() {
        viewModel.dataFetch() { result in
            switch result {
            case .success(_):
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        viewModelDataFetch()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self,
                       forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(CustomCollectionHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CustomCollectionHeaderReusableView.identifier)
        collectionView.backgroundColor = .gray
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // 섹션안 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    // 섹션의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    // 재사용 셀 선언 및 적용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
//    MARK: - Header
    // 헤더 뷰 선언 및 적용
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: CustomCollectionHeaderReusableView.identifier,
                                                                               for: indexPath)
                    as? CustomCollectionHeaderReusableView
            else { return UICollectionReusableView() }
            header.backgroundColor = .white
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    // 특정 헤더에 대한 사이즈 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section > 0 {
            return CGSizeZero
        }
        return CGSize(width: view.frame.width, height: 60)
    }
}

//MARK: - FlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    // 섹션 안 셀의 개수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 120)
    }
    // 연속되는 셀의 행 열 간격 (스크롤 방향 주의)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // 연속되는 셀의 아이템의 행 열 간격 (스크롤 방향 주의)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // 특정 섹션에 대한 CollectionView와의 간격
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section < 2 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
}

