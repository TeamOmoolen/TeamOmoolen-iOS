//
//  HomeVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/03.
//

import UIKit
import SnapKit
import Moya

class HomeVC: UIViewController {
    
    // MARK: - UI Components
   
    @IBOutlet weak var homeHeaderView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    
    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTop"), for: .normal)
        button.addTarget(self, action: #selector(touchUpTop), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Local Variables
    
    private var homeList: HomeResponse?
    private var guideList = [GuideList]()
    private var newList = [[NewLensDetailData]]()
    
    // MARK: - View Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setNavigationController()
        setTabbarController()
        
        searchIcon.isHidden = false
        searchLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setUI()
        getHomeWithAPI()
        registerXib()
        setHomeTableView()
        getNotification()

        // loadinglogo
        guard let loadingVC = UIStoryboard(name: Const.Storyboard.Name.LoadingLogo, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.LoadingLogo) as? LoadingLogoVC else {
            return
        }
        loadingVC.modalPresentationStyle = .overFullScreen
        loadingVC.modalTransitionStyle = .crossDissolve
        loadingVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.present(loadingVC, animated: true, completion: nil)
        
    }
}

// MARK:- Custom Methods

extension HomeVC {
    func setUI() {
        view.backgroundColor = .white
        dividerView.backgroundColor = .omAlmostwhite
        
        homeHeaderView.backgroundColor = .white
        homeTableView.backgroundColor = .white
        
        view.addSubview(topButton)
        
        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(-100)
        }
        
        logoImageView.image = UIImage(named: "imgLogo")
        
        searchView.layer.borderColor = UIColor.omMainOrange.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 8
        searchView.layer.masksToBounds = true
        
        searchIcon.image = UIImage(named: "icSearchSmall")
        searchLabel.text = "오늘은 무슨 렌즈끼지?"
        searchLabel.textColor = .omFourthGray
        searchLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpSearchView))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    func registerXib() {
        let categoryNib = UINib(nibName: CategoryTVC.identifier, bundle: nil)
        homeTableView.register(categoryNib, forCellReuseIdentifier: CategoryTVC.identifier)
        
        let recommedNib = UINib(nibName: RecommendTVC.identifier, bundle: nil)
        homeTableView.register(recommedNib, forCellReuseIdentifier: RecommendTVC.identifier)
        
        let oneMinNib = UINib(nibName: OneMinTVC.identifier, bundle: nil)
        homeTableView.register(oneMinNib, forCellReuseIdentifier: OneMinTVC.identifier)
        
        let seasonNib = UINib(nibName: SeasonTVC.identifier, bundle: nil)
        homeTableView.register(seasonNib, forCellReuseIdentifier: SeasonTVC.identifier)
        
        let middleBannerNib = UINib(nibName: MiddleBannerTVC.identifier, bundle: nil)
        homeTableView.register(middleBannerNib, forCellReuseIdentifier: MiddleBannerTVC.identifier)
        
        let newLensNib = UINib(nibName: NewLensTVC.identifier, bundle: nil)
        homeTableView.register(newLensNib, forCellReuseIdentifier: NewLensTVC.identifier)
        
        let timeRecommendNib = UINib(nibName: SituationTVC.identifier, bundle: nil)
        homeTableView.register(timeRecommendNib, forCellReuseIdentifier: SituationTVC.identifier)
        
        let lastBannerNib = UINib(nibName: LastBannerTVC.identifier, bundle: nil)
        homeTableView.register(lastBannerNib, forCellReuseIdentifier: LastBannerTVC.identifier)
    }
    
    func setHomeTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.separatorStyle = .none
        homeTableView.allowsSelection = false
    }
    
    // MARK: - Network 
    func getHomeWithAPI() {
        let accesstoken = UserDefaults.standard.string(forKey: "Accesstoken") ?? ""
        OnboardingAPI.shared.getHome(accesstoken: accesstoken) { response in
            self.dismiss(animated: true, completion: nil)
            
            self.homeList = response
            
            self.guideList.append(response.guides.guideList1)
            self.guideList.append(response.guides.guideList2)
            self.guideList.append(response.guides.guideList3)
            
            self.newList.append(response.newLens.newLensBrand1)
            self.newList.append(response.newLens.newLensBrand2)
            self.newList.append(response.newLens.newLensBrand3)
            
            self.homeTableView.reloadData()
        }
    }
    
    func setNavigationController() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setTabbarController() {
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Action Methods

extension HomeVC {
    @objc
    func touchUpTop() {
        let topIndex = IndexPath(row: 0, section: 0)
        homeTableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
    @objc
    func touchUpSearchView(_ sender: UITapGestureRecognizer) {
        searchLabel.isHidden = true
        searchIcon.isHidden = true
        
        guard let searchVC = UIStoryboard(name: Const.Storyboard.Name.Search, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Search) as? SearchVC else {
            return
        }
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}

// MARK: - UITableView Delegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 140
        case 1:
            return 387
        case 2:
            return 516
        case 3:
            return 1095
        case 4:
            return 180
        case 5:
            return 807
        case 6:
            return 1085
        case 7:
            return 230
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topButton.isHidden = false
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(100)
            }
        } else {
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }
        }
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableView DataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  CategoryTVC.identifier, for: indexPath) as? CategoryTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  RecommendTVC.identifier, for: indexPath) as? RecommendTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(name: homeList?.username ?? "", data: homeList?.recommendationByUser ?? [RecommendationBy]())
            cell.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  OneMinTVC.identifier, for: indexPath) as? OneMinTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(data: guideList)
            cell.delegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SituationTVC.identifier, for: indexPath) as? SituationTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(time: homeList?.situation ?? "", data: homeList?.recommendationBySituation ?? [RecommendationBySituation]())
            cell.delegate = self
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  MiddleBannerTVC.identifier, for: indexPath) as? MiddleBannerTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(ImageList: homeList?.deadlineEvent ?? [Event]())
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  NewLensTVC.identifier, for: indexPath) as? NewLensTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(data: self.newList)
            cell.delegate = self
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SeasonTVC.identifier, for: indexPath) as? SeasonTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(data: homeList?.recommendationBySeason ?? [RecommendationBy]())
            cell.delegate = self
            return cell
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  LastBannerTVC.identifier, for: indexPath) as? LastBannerTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.initCell(ImageList: homeList?.lastestEvent ?? [Event]())
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Protocol

extension HomeVC: ViewModalProtocol {
    func detailViewModalDelegate(dvc: DetailVC) {
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - Notification

extension HomeVC {
    func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToDetailVC(_:)), name: NSNotification.Name("PushToDetailVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushToPopUpVC(_:)), name: NSNotification.Name("PushToPopUp"), object: nil)
    }
    
    @objc
    func pushToDetailVC(_ notification: Notification) {
        var id: String
        id = notification.object as! String
        
        guard let detailVC = UIStoryboard(name: Const.Storyboard.Name.Detail, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Detail) as? DetailVC else {
            return
        }
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.id = id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc
    func pushToPopUpVC (_ notification: Notification) {
        guard let popup = UIStoryboard(name: Const.Storyboard.Name.PopupModal, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.PopupModal) as? PopupModalVC else {
            return
        }
        popup.titleText = "1분 렌즈 상식"
        popup.subtitleText =
        """
        준비중입니다.
        빠른시일 내에 새로운 기능으로 찾아뵙겠습니다!
        """
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = . crossDissolve
        
        self.present(popup, animated: true, completion: nil)
    }
}
