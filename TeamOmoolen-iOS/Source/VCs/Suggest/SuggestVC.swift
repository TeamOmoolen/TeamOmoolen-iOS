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
    @IBOutlet weak var searchLeadingConstraint: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var suggestViews : [UIViewController] = []
    var position: Int = 0

    //MARK: - Local Variables
    private var forYouList = [SuggestProduct]()
    private var situationList = [SuggestProduct]()
    private var newProductList = [SuggestProduct]()
    private var seasonList = [SuggestProduct]()
    
    private var foryouTotal: Int = 0
    private var situationTotal: Int = 0
    private var newProductTotal: Int = 0
    private var seasonTotal: Int = 0

    
    var season = ""
    var situation = ""
    
    lazy var suggestTabBar: SuggestTabBar = {
        let suggestTB = SuggestTabBar()
        suggestTB.suggestViewController = self
        return suggestTB
    }()
    
    private var suggestList: SuggestResponse?
    
    var forUlist = [SuggestProduct]()
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(getPosition(_:)), name: NSNotification.Name("PostPosition"), object: nil)
        
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
        tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSuggestWithAPI()
        setUI()
        setUpTabBar()
        registerXib()
        setCollectionViewDelegate()
        setPhoneResolution()
    }
    
    // MARK: - IBActions
    
    @IBAction func touchUpSearch(_ sender: Any) {
        guard let searchVC = UIStoryboard(name: Const.Storyboard.Name.Search, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Search) as? SearchVC else {
            return
        }
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func touchUpLogo(_ sender: Any) {
        guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Tabbar, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Tabbar) as? TabBarController else {
            return
        }
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        present(homeVC, animated: true, completion: nil)
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
        
        searchView.layer.cornerRadius = 8
        searchView.backgroundColor = .omFifthGray
        searchView.layer.borderColor = UIColor.omMainOrange.cgColor
        searchView.layer.borderWidth = 1
        searchView.backgroundColor = .omWhite
        
        searchTextField.layer.borderColor = UIColor.omWhite.cgColor
        searchTextField.placeholder = "오늘은 무슨 렌즈끼지?"
        searchTextField.layer.borderWidth = 1
        searchTextField.backgroundColor = .omWhite
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.omFourthGray,
            NSAttributedString.Key.font : UIFont(name: "NotoSansCJKKR-Regular", size: 13)!
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "오늘은 무슨 렌즈끼지?",attributes: attributes )
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
        
        foryouVC.list = forYouList
        situationVC.list = situationList
        seasonVC.list = seasonList
        newproductVC.list = newProductList
        
        foryouVC.totalPage = foryouTotal
        situationVC.totalPage = situationTotal
        seasonVC.totalPage = seasonTotal
        newproductVC.totalPage = newProductTotal
        
        suggestViews.append(foryouVC)
        suggestViews.append(situationVC)
        suggestViews.append(newproductVC)
        suggestViews.append(seasonVC)
    }
    
    private func setUpTabBar(){
        view.addSubview(suggestTabBar)
        
        if UIDevice.current.isiPhoneSE2 {
            view.addConstraintsWithFormat(format: "H:|-20-[v0]-70-|", views: suggestTabBar)
            view.addConstraintsWithFormat(format: "V:|-91-[v0(45)]", views: suggestTabBar)

        } else if (UIDevice.current.isiPhone12Pro) {
            view.addConstraintsWithFormat(format: "H:|-20-[v0]-70-|", views: suggestTabBar)
            view.addConstraintsWithFormat(format: "V:|-113-[v0(45)]", views: suggestTabBar)

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
            searchLeadingConstraint.constant = 34
        }
    }
    
    func scrollToSuggestTabBarIndex(tabBarIdx: Int){
        let indexPath = NSIndexPath(item: tabBarIdx, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        collectionView.isPagingEnabled = true
    }
    
    func getSuggestWithAPI() {
        let accesstoken = UserDefaults.standard.string(forKey: "Accesstoken") ?? ""
        
        SuggestAPI.shared.getSuggest(accesstoken: accesstoken) { [self] response in
            self.suggestList = response
            self.forYouList = self.suggestList?.suggestForYou ?? [SuggestProduct]()
            
            self.season = self.suggestList!.season
            self.situation = self.suggestList!.situation
            self.setResponse()
            
            self.forYouList = self.suggestList?.suggestForYou ?? [SuggestProduct]()
            self.situationList = self.suggestList?.suggestForSituation ?? [SuggestProduct]()
            self.seasonList = self.suggestList?.suggestForSeason ?? [SuggestProduct]()
            self.newProductList = self.suggestList?.suggestForNew ?? [SuggestProduct]()
            
            self.foryouTotal = self.suggestList?.suggestForYouTotalPage ?? 0
            self.situationTotal = self.suggestList?.suggestForSituationTotalPage ?? 0
            self.seasonTotal = self.suggestList?.suggestForSeasonTotalPage ?? 0
            self.newProductTotal = suggestList?.suggestForNewTotalPage ?? 0
            
            self.collectionView.reloadData()
            setVCs()
        }
    }
    func setResponse() {
        if (self.season == "summer") {
            self.season = "여름"
        } else if (self.season == "spring") {
            self.season = "봄"
        } else if (self.season == "fall") {
            self.season = "가을"
        } else {
            self.season = "겨울"
        }
        
        if (self.situation == "특별"){
            suggestTabBar.views = ["For You", "\(situation)한 날에", "신제품", "\(season)에 예쁜"]
        } else if (self.situation == "운동") {
            suggestTabBar.views = ["For You", "\(situation)할 때", "신제품", "\(season)에 예쁜"]
        } else if (self.situation == "일상" || self.situation == "여행") {
            suggestTabBar.views = ["For You", "\(situation)에서", "신제품", "\(season)에 예쁜"]
        }
        
        self.suggestTabBar.collectionView.reloadData()
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
            return CGSize(width: view.frame.width, height: 800)
        } else {
            return CGSize(width: view.frame.width, height: view.frame.height)
        }
    }
}

// MARK: - Notification func

extension SuggestVC {
    @objc
    func getPosition(_ notification: Notification) {
        position = notification.object as! Int
    }
}
