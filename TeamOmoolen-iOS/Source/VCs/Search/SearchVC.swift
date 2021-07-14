//
//  SearchVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/03.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    
    //MARK: - Local Variables
    var searchViews : [UIViewController] = []
    private var getSearchData = false
    private var keyword = ""
    private var searchResultResponse: SearchResultResponse?

    lazy var searchTabBar: SearchTabBar = {
        let sTB = SearchTabBar()
        sTB.searchviewcontroller = self
        return sTB
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        setUI()
        registerNib()
        setCollectionViewDelegate()
        setVCs()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name("SearchEntered") , object:nil)
    }

    func setVCs(){
        let storyboard = UIStoryboard(name: "RecentSearchVC", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "RecentSearchVC") as? RecentSearchVC else {return}
        
        let storyboard2 = UIStoryboard(name: "FIlterVC", bundle: nil)
        guard let vc2 = storyboard2.instantiateViewController(identifier: "FilterVC") as? FilterVC else {return}
        
        searchViews.append(vc)
        searchViews.append(vc2)
        collectionView.reloadData()
    }

    //MARK: - IBAction Methods
    @IBAction func searchDidEnd(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("SearchEntered"), object: searchTextField.text)
        //서버통신
        getSearchData = true
        keyword = searchTextField.text!
        getData()
        
    }
    
    @IBAction func touchUpBackButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ReturnHome"), object: nil)
        guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Home, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Home) as? HomeVC else {
            return
        }
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Methods
    private func setUpTabBar(){
        view.addSubview(searchTabBar)
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]|", views: searchTabBar)

        view.addConstraintsWithFormat(format: "V:|-103-[v0(50)]", views: searchTabBar)
    }
    
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        searchBarView.layer.cornerRadius = 6
        searchBarView.backgroundColor = .omFifthGray

        searchTextField.backgroundColor = .omFifthGray
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.omFifthGray.cgColor
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.omFourthGray,
            NSAttributedString.Key.font : UIFont(name: "NotoSansCJKKR-Regular", size: 14)!
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "원하는 렌즈를 검색해보세요",attributes: attributes )

    }
    
    func registerNib() {
        collectionView.register(SearchHomeCVC.nib(), forCellWithReuseIdentifier: "SearchHomeCVC")
    }
    
    func setCollectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func scrollToSearchTabBarIndex(tabBarIdx: Int){
        let indexPath = NSIndexPath(item: tabBarIdx, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        collectionView.isPagingEnabled = true
    }
}

extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTabBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2.1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        searchTabBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHomeCVC", for: indexPath) as! SearchHomeCVC
        self.addChild(searchViews[indexPath.item])
        cell.addSubview(searchViews[indexPath.item].view)
        cell.translatesAutoresizingMaskIntoConstraints = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

//MARK: - Request API
extension SearchVC {
    func getData() {
        if getSearchData {
            requestAPI()
        }
    }
    
    func requestAPI(){
        // let param = SearchKeywordRequest(keyword)
        let param = keyword
        
        print(param)
        
        getSearchResultWithAPI(param: param)
    }
    
    func getSearchResultWithAPI(param: String) {
        SearchAPI.shared.getKeywordResult(param: param) { response in
            print(response)
            self.searchResultResponse = response
            
            guard let searchResultVC = UIStoryboard(name: Const.Storyboard.Name.SearchResult, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SearchResult) as? SearchResultVC else {
                return
            }
            searchResultVC.modalPresentationStyle = .fullScreen
            searchResultVC.modalTransitionStyle = .crossDissolve
            searchResultVC.resultList = self.searchResultResponse?.products
            
            self.navigationController?.pushViewController(searchResultVC, animated: true)
        }
    }
}
