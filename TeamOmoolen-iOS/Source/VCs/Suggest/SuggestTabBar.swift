//
//  SuggestTabBar.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class SuggestTabBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        let suggestTBNib = UINib(nibName:SuggestTabBarCVC.identifier, bundle: nil)
        cv.register(suggestTBNib, forCellWithReuseIdentifier: SuggestTabBarCVC.identifier)
        cv.dataSource = self
        cv.delegate = self
    
        return cv
    }()
    
    let views = ["For You", "운동할 때", "신제품", "여름에 예쁜"]
    
    var suggestViewController : SuggestVC?
    
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
        //움직일때 하이라이트 되는 길이 - 나중에 디테일 잡기
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("PostPosition"), object: indexPath.item)
        suggestViewController?.scrollToSuggestTabBarIndex(tabBarIdx: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestTabBarCVC.identifier, for: indexPath) as! SuggestTabBarCVC
        cell.backgroundColor = .omWhite
        cell.label.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        cell.label.text = views[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
