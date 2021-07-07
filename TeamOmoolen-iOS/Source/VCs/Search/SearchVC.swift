//
//  SearchVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/03.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    
    
    let searchViews : [UIViewController] = [RecentSearchVC(), FilterVC()]
    
    lazy var searchTabBar: SearchTabBar = {
        let sTB = SearchTabBar()
        sTB.searchviewcontroller = self
        return sTB
    }()
    
    
    //Mark: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setUI()
        registerNib()
        setCollectionViewDelegate()

    }
    
    //Mark: - Methods
    private func setUpTabBar(){
        view.addSubview(searchTabBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: searchTabBar)
        view.addConstraintsWithFormat(format: "V:|-104-[v0(50)]", views: searchTabBar)
    }
    
    //Mark: - Methods
    func setUI() {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        
        searchBarView.layer.cornerRadius = 6
        searchBarView.backgroundColor = .omFifthGray

        searchTextField.backgroundColor = .omFifthGray
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.omFifthGray.cgColor
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.omFourthGray,
            NSAttributedString.Key.font : UIFont(name: "NotoSansCJKKR-Regular", size: 14)!
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "원하는 렌즈를 검색해보세요",
                                                                   attributes: attributes )

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
        searchTabBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        searchTabBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHomeCVC", for: indexPath) as! SearchHomeCVC
        self.addChild(searchViews[indexPath.item])
        cell.addSubview(searchViews[indexPath.item].view)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
//        return self.collectionView.frame.size
    }
    
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }*/
    
    
    
}
