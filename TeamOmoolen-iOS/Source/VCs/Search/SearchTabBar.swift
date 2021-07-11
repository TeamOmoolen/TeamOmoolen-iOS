//
//  SearchTabBar.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import Foundation
import UIKit

class SearchTabBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(SearchTabBarCVC.nib(), forCellWithReuseIdentifier: "SearchTabBarCVC")
        cv.dataSource = self
        cv.delegate = self
    
        return cv
    }()
    
    let views = ["최근 검색어","필터"]
    
    var searchviewcontroller : SearchVC?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .omMainOrange
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBarView)
    
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchviewcontroller?.scrollToSearchTabBarIndex(tabBarIdx: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTabBarCVC", for: indexPath) as! SearchTabBarCVC
        cell.backgroundColor = .omWhite
        cell.label.font = UIFont(name: "NotoSansCJKKR-Regular", size: 15)
        cell.label.text = views[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
