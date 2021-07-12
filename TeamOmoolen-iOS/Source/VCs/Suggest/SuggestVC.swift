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
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - Local Variables
    
    var suggestViews : [UIViewController] = []
    var position: Int = 0
    
    lazy var suggestTabBar: SuggestTabBar = {
        let suggestTB = SuggestTabBar()
        suggestTB.suggestViewController = self
        return suggestTB
    }()
    
    //MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if position == 0 {
            self.collectionView?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
            
            suggestTabBar.collectionView.selectItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, animated: true, scrollPosition: .left)
        } else if position == 1 {
            self.collectionView?.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true)
            
            suggestTabBar.collectionView.selectItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, animated: true, scrollPosition: .left)
        } else if position == 2 {
            self.collectionView?.scrollToItem(at: NSIndexPath(item: 2, section: 0) as IndexPath, at: .left, animated: true)
            
            suggestTabBar.collectionView.selectItem(at: NSIndexPath(item: 2, section: 0) as IndexPath, animated: true, scrollPosition: .left)
        } else {
            self.collectionView?.scrollToItem(at: NSIndexPath(item: 3, section: 0) as IndexPath, at: .left, animated: true)
            
            suggestTabBar.collectionView.selectItem(at: NSIndexPath(item: 3, section: 0) as IndexPath, animated: true, scrollPosition: .left)
        }
        
        navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(getPosition(_:)), name: NSNotification.Name("PostPosition"), object: nil)
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setVCs()
        setUpTabBar()
        registerXib()
        setCollectionViewDelegate()
        setPhoneResolution()
    }
    
    // MARK: - IB Actions
    
    @IBAction func touchUpBackButton(_ sender: Any) {
        guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Home, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Home) as? HomeVC else {
            return
        }
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        navigationController?.popViewController(animated: true)
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
        
        if UIDevice.current.isiPhoneSE2 {
            view.addConstraintsWithFormat(format: "H:|-20-[v0]-70-|", views: suggestTabBar)
            view.addConstraintsWithFormat(format: "V:|-80-[v0(45)]", views: suggestTabBar)

        } else if (UIDevice.current.isiPhone12Pro) {
            view.addConstraintsWithFormat(format: "H:|-20-[v0]-70-|", views: suggestTabBar)
            view.addConstraintsWithFormat(format: "V:|-10-[v0(45)]", views: suggestTabBar)

        } else {
            view.addConstraintsWithFormat(format: "H:|-20-[v0]-70-|", views: suggestTabBar)
            view.addConstraintsWithFormat(format: "V:|-122-[v0(45)]", views: suggestTabBar)
        }

    }
    
    func registerXib() {
        
        let suggestHomeNib = UINib(nibName: SuggestHomeCVC.identifier, bundle: nil)
        collectionView.register(suggestHomeNib, forCellWithReuseIdentifier: SuggestHomeCVC.identifier)
        
    }
    
    func setCollectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setPhoneResolution(){
        if UIDevice.current.isiPhoneSE2 {
            collectionViewTopConstraint.constant = 0
        }
        if UIDevice.current.isiPhone12Pro {
            collectionViewTopConstraint.constant = 0
        }
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
        suggestTabBar.horizontalBarLeftAnchorConstraint?.constant = floor((scrollView.contentOffset.x)/5.2)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        suggestTabBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        position = indexPath.item
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
        
        if UIDevice.current.isiPhoneSE2 {
            return CGSize(width: view.frame.width, height: 700)
        } else if (UIDevice.current.isiPhone12Pro) {
            return CGSize(width: 390, height: 844)
        } else {
        
            return CGSize(width: view.frame.width, height: view.frame.height)
        }
    }
}


// MARK: - Protocols

extension SuggestVC: PassTagProtocol {
    func passTag(tag: Int) {
        switch tag {
        case 0:
            position = 0
        case 1:
            position = 1
        case 2:
            position = 2
        case 3:
            position = 3
        default:
            return
        }
    }
}

extension SuggestVC {
    @objc
    func getPosition(_ notification: Notification) {
        position = notification.object as! Int
    }
}
