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
    var productCount = -1
    var searchKeyword = ""
    
    private var currPage: Int = 1
    private var totalPage: Int = -1
    private var canFetchData: Bool = true
    private var sort = ""
    private var order = ""

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var serperatorView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var countBackView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    // MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewDelegate()
        resgisterNib()
        setNotification()
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
            let searchResultNib = UINib(nibName: SearchResultCVC.identifier, bundle: nil)
            resultCollectionView.register(searchResultNib, forCellWithReuseIdentifier: SearchResultCVC.identifier)
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
        
//        productCount = resultList?.count ?? 0
        countLabel.text = "총 \(productCount)개의 상품"
        countLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 13)
        countLabel.textColor = .omSecondGray
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setCollectionViewDelegate() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
    }
    
    func getSearchResultMoreWithAPI(page: Int, sort: String, order: String) {
        
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height {
            print("끝에 닿음")
            if canFetchData, currPage < totalPage {
                currPage += 1
                canFetchData = false
                // 서버 통신하는 곳
                getSearchResultMoreWithAPI(page: currPage, sort: sort, order: order)
            }
            //refresh
            resultCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.id = resultList![indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

// MARK: - UICollectionViewDataSource
extension SearchResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVC.identifier, for: indexPath) as? SearchResultCVC else {
            return UICollectionViewCell()
        }
        let cellData = resultList?[indexPath.row] ?? Product(id: "", name: "", imageList: [""], otherColorList: [""], price: 0, brand: "", diameter: 0, changeCycleMinimum: 0, changeCycleMaximum: 0, pieces: 0)
        
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
