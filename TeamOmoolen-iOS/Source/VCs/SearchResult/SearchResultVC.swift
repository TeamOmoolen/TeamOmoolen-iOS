//
//  SearchResultVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import UIKit

class SearchResultVC: UIViewController {

    // MARK: - Properties
    private let resultList = [RecommendLensDataModel]()
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewDelegate()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func resgisterNib() {
            let seasonNib = UINib(nibName: SeasonCVC.identifier, bundle: nil)
            resultCollectionView.register(seasonNib, forCellWithReuseIdentifier: SeasonCVC.identifier)
    }
    
    func setUI() {
        searchBarView.layer.cornerRadius = 6
        searchBarView.backgroundColor = .omFifthGray
    }
    
    func setCollectionViewDelegate() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
    }
    
    func getHomeWithAPI() {
        SearchAPI.shared.getSearchResultWithAPI() { response in
//            response.
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchResultVC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SearchResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        let data = resultList[indexPath.row]
        cell.initCell(brandName: data.brandName, lensName: data.lensName, diameter: data.diameter, cycle: data.cycle, price: data.price)
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchResultVC: UICollectionViewDelegateFlowLayout {
    
}
