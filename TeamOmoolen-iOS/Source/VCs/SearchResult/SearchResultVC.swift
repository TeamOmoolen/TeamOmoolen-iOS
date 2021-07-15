//
//  SearchResultVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import UIKit
import PanModal

class SearchResultVC: UIViewController {

    // MARK: - Properties
    var resultList: [Product]?
    var productCount = 0
    var searchKeyword = "keyword"

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var serperatorView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var countBackView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewDelegate()
        resgisterNib()
        setNotification()
        resultCollectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - @IBAction Properties
    @IBAction func sortButton(_ sender: Any) {
        let vc = UIStoryboard(name: Const.Storyboard.Name.SortPanModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SortPanModal) as! SortPanModalVC
        presentPanModal(vc)
    }
    

    @IBAction func popToSearch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnToSearch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    // MARK: - Methods
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceLowOrder), name: Notification.Name("SetLowOrder"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceHighOrder), name: Notification.Name("SetHighOrder"), object: nil)
    }
    
    func resgisterNib() {
            let seasonNib = UINib(nibName: SeasonCVC.identifier, bundle: nil)
            resultCollectionView.register(seasonNib, forCellWithReuseIdentifier: SeasonCVC.identifier)
    }
    
    func setUI() {
        serperatorView.backgroundColor = .omFifthGray
        
        searchBarView.layer.cornerRadius = 6
        searchBarView.backgroundColor = .omFifthGray
        
        searchTextField.backgroundColor = .omFifthGray
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.omFifthGray.cgColor
        // 화면전환될 때 같이 데이터 전달.
        searchTextField.text = searchKeyword
        
        countBackView.layer.cornerRadius = 10
        countBackView.backgroundColor = .omFifthGray
        
        productCount = resultList?.count ?? 0
        countLabel.text = "총 \(productCount)개의 상품"
        countLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 13)
        countLabel.textColor = .omSecondGray
    }
    
    func setCollectionViewDelegate() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
    }
    
    // MARK: - @objc Methods
    @objc
    func setPriceLowOrder() {
        print("setPriceLowOrder()")
        resultList!.sort(by: {$0.price < $1.price})
        resultCollectionView.reloadData()
    }
    
    @objc
    func setPriceHighOrder() {
        print("setPriceHighOrder")
        resultList!.sort(by: {$0.price > $1.price})
        resultCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension SearchResultVC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SearchResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCVC.identifier, for: indexPath) as? SeasonCVC else {
            return UICollectionViewCell()
        }
        let cellData = resultList![indexPath.row]
        cell.initCell(imageList: cellData.imageList, brandName: cellData.brand, lensName: cellData.name, diameter: cellData.diameter, minCycle: cellData.changeCycleMinimum, maxCycle: cellData.changeCycleMaximum, pieces: cellData.pieces, price: cellData.price, colorList: cellData.otherColorList)
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
//        let height = collectionView.frame.height
        let cellWidth = (width - 24) / 3
        let cellHeight = 201
        return CGSize(width: cellWidth, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
