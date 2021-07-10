//
//  RecommendVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class SuggestVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Local Variables
    var suggestViews : [UIViewController] = []
    
    lazy var suggestTabBar: SuggestTabBar = {
        let suggestTB = SuggestTabBar()
        suggestTB.suggestViewController = self
        return suggestTB
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setVCs()
        setUpTabBar()
        registerXib()
        setCollectionViewDelegate()
    
    }
    
   //MARK: - Methods
    func setUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        searchView.layer.cornerRadius = 6
        searchView.backgroundColor = .omFifthGray
        
        searchTextField.backgroundColor = .omFifthGray
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.omFifthGray.cgColor
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.omFourthGray,
            NSAttributedString.Key.font : UIFont(name: "NotoSansCJKKR-Regular", size: 14)!
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "원하는 렌즈를 검색해보세요",attributes: attributes )
        
    }
    
    func setVCs(){
        let foryouSB = UIStoryboard(name: "ForYou", bundle:nil)
        guard let foryouVC = foryouSB.instantiateViewController(identifier: "ForYouVC") as? ForYouVC else {return}
        
        let situationSB = UIStoryboard(name: "Situation", bundle:nil)
        guard let situationVC = situationSB.instantiateViewController(identifier: "SituationVC") as? SituationVC else {return}
        
        let newproductSB = UIStoryboard(name:"NewProduct", bundle:nil)
        guard let newproductVC = newproductSB.instantiateViewController(identifier:"NewProductVC") as? NewProductVC else {return}
        
        let seasonSB = UIStoryboard(name:"Season", bundle: nil)
        guard let seasonVC = seasonSB.instantiateViewController(identifier: "SeasonVC") as? SeasonVC else {return}
        
        suggestViews.append(foryouVC)
        suggestViews.append(situationVC)
        suggestViews.append(newproductVC)
        suggestViews.append(seasonVC)
        collectionView.reloadData()
        
    }
    
    private func setUpTabBar(){
        view.addSubview(suggestTabBar)
        
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-10-|", views: suggestTabBar)

        view.addConstraintsWithFormat(format: "V:|-120-[v0(53)]", views: suggestTabBar)
    }
    
    func registerXib() {
        
        let suggestHomeNib = UINib(nibName: SuggestHomeCVC.identifier, bundle: nil)
        collectionView.register(suggestHomeNib, forCellWithReuseIdentifier: SuggestHomeCVC.identifier)
        
    }
    
    func setCollectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func scrollToSuggestTabBarIndex(tabBarIdx: Int){
        let indexPath = NSIndexPath(item: tabBarIdx, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        collectionView.isPagingEnabled = true
    }
}

extension SuggestVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        suggestTabBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        suggestTabBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestHomeCVC", for: indexPath) as! SuggestHomeCVC
        self.addChild(suggestViews[indexPath.item])
        cell.addSubview(suggestViews[indexPath.item].view)
        cell.translatesAutoresizingMaskIntoConstraints = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
